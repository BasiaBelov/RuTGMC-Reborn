/datum/component/squeak
	/// What sound will we play on squeak
	var/squeak_sound = 'sound/items/dollsqueak.ogg'
	/// With what probability will we play sound?
	var/squeak_chance = 100
	/// How loud will we play our sound?
	var/volume = 30

	/// This is so shoes don't squeak every step
	var/steps = 0
	/// How long do we have to wait before being able to squeak on step
	var/step_delay = 1

	/// This is to stop squeak spam from inhand usage
	var/last_use = 0
	/// How long do we have to wait before being able to squeak in hand
	var/use_delay = 2 SECONDS

	///what we set connect_loc to if parent is a movable
	var/static/list/item_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(play_squeak_crossed),
		COMSIG_TURF_JUMP_ENDED_HERE = PROC_REF(play_squeak),
	)

/datum/component/squeak/Initialize(sound_to_play, volume_override, chance_override, step_delay_override, use_delay_override)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignals(parent, list(COMSIG_ATOM_ENTERED, COMSIG_ATOM_ATTACKBY), PROC_REF(play_squeak))
	if(ismovableatom(parent))
		AddComponent(/datum/component/connect_loc_behalf, parent, item_connections)
		RegisterSignals(parent, list(COMSIG_MOVABLE_BUMP, COMSIG_MOVABLE_IMPACT), PROC_REF(play_squeak))
		RegisterSignal(parent, COMSIG_MOVABLE_DISPOSING, PROC_REF(disposing_react))
		if(isitem(parent))
			RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(play_squeak))
			RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(use_squeak))
			RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
			RegisterSignal(parent, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
			if(istype(parent, /obj/item/clothing/shoes))
				RegisterSignal(parent, COMSIG_SHOES_STEP_ACTION, PROC_REF(step_squeak))
		else if(isstructure(parent))
			RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(use_squeak))

	if(sound_to_play)
		squeak_sound = sound_to_play
	if(chance_override)
		squeak_chance = chance_override
	if(volume_override)
		volume = volume_override
	if(isnum(step_delay_override))
		step_delay = step_delay_override
	if(isnum(use_delay_override))
		use_delay = use_delay_override

/datum/component/squeak/UnregisterFromParent()
	. = ..()
	qdel(GetComponent(/datum/component/connect_loc_behalf))

/datum/component/squeak/proc/play_squeak()
	SIGNAL_HANDLER
	if(!prob(squeak_chance))
		return

	if(islist(squeak_sound))
		playsound(parent, sound(pick(squeak_sound)), volume, TRUE, 10)
	else
		playsound(parent, sound(squeak_sound), volume, TRUE, 10)

/datum/component/squeak/proc/step_squeak()
	SIGNAL_HANDLER
	if(steps > step_delay)
		play_squeak()
		steps = 0
	else
		steps++

/datum/component/squeak/proc/play_squeak_crossed(datum/source, atom/movable/AM, oldloc, oldlocs)
	SIGNAL_HANDLER
	if(isitem(AM))
		if(!AM.throwing)
			return // cause fuck you, that's why
		var/obj/item/I = AM
		if(I.item_flags & ITEM_ABSTRACT)
			return

	if(istype(AM, /obj/projectile))
		var/obj/projectile/P = AM
		if(P.original_target != parent)
			return

	if(isobserver(AM))
		return

	if(CHECK_MULTIPLE_BITFIELDS(AM.pass_flags, HOVERING))
		return
	var/atom/current_parent = parent
	if(!isturf(current_parent.loc))
		return
	play_squeak()

/datum/component/squeak/proc/use_squeak()
	if(last_use + use_delay > world.time)
		return
	last_use = world.time
	play_squeak()

/datum/component/squeak/proc/on_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER
	RegisterSignal(equipper, COMSIG_MOVABLE_DISPOSING, PROC_REF(disposing_react), TRUE)

/datum/component/squeak/proc/on_drop(datum/source, mob/user)
	SIGNAL_HANDLER
	UnregisterSignal(user, COMSIG_MOVABLE_DISPOSING)

/datum/component/squeak/proc/disposing_react(datum/source, obj/structure/disposalholder/holder, obj/machinery/disposal/disposal_unit)
	SIGNAL_HANDLER
	//We don't need to worry about unregistering this signal as it will happen for us automaticaly when the holder is qdeleted
	RegisterSignal(holder, COMSIG_ATOM_DIR_CHANGE, PROC_REF(holder_dir_change))

/datum/component/squeak/proc/holder_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER
	//If the dir changes it means we're going through a bend in the pipes, let's pretend we bumped the wall
	if(old_dir != new_dir)
		play_squeak()
