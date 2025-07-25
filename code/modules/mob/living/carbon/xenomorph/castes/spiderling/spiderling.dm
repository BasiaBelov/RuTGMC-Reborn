/mob/living/carbon/xenomorph/spiderling
	caste_base_type = /datum/xeno_caste/spiderling
	name = "Spiderling"
	desc = "A widow spawn, it chitters angrily without any sense of self-preservation, only to obey the widow's will."
	icon = 'icons/Xeno/Effects.dmi'
	icon_state = "Spiderling Running"
	health = 150
	maxHealth = 150
	plasma_stored = 200
	mob_size = MOB_SIZE_HUMAN
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	pull_speed = -2
	allow_pass_flags = PASS_XENO
	pass_flags = PASS_XENO|PASS_LOW_STRUCTURE
	density = FALSE
	/// The widow that this spiderling belongs to
	var/mob/living/carbon/xenomorph/spidermother

/mob/living/carbon/xenomorph/spiderling/Initialize(mapload, mob/living/carbon/xenomorph/mother)
	. = ..()
	spidermother = mother
	if(spidermother)
		AddComponent(/datum/component/ai_controller, /datum/ai_behavior/spiderling, spidermother)
		transfer_to_hive(spidermother.get_xeno_hivenumber())
	else
		AddComponent(/datum/component/ai_controller, /datum/ai_behavior/xeno)

/mob/living/carbon/xenomorph/spiderling/on_death()
	//We QDEL them as cleanup and preventing them from being sold
	QDEL_IN(src, TIME_TO_DISSOLVE)
	spidermother = null
	return ..()

/mob/living/carbon/xenomorph/spiderling/Destroy()
	spidermother = null
	return ..()

///If we're covering our widow, any clicks should be transferred to them
/mob/living/carbon/xenomorph/spiderling/attack_alien(mob/living/carbon/xenomorph/xeno_attacker, damage_amount = xeno_attacker.xeno_caste.melee_damage, damage_type = BRUTE, armor_type = MELEE, effects = TRUE, isrightclick = FALSE)
	if(!get_dist(src, spidermother) && isxeno(x))
		spidermother.attack_alien(xeno_attacker, damage_amount, damage_type, armor_type, effects, isrightclick)
		return
	return ..()

/mob/living/carbon/xenomorph/spiderling/Life(seconds_per_tick, times_fired)
	. = ..()
	if(!spidermother)
		return
	if(get_dist(src, spidermother) > SPIDERLING_WITHER_RANGE)
		adjust_brute_loss(25)

// ***************************************
// *********** Spiderling AI Section
// ***************************************
/datum/ai_behavior/spiderling
	target_distance = 1
	base_action = ESCORTING_ATOM
	identifier = IDENTIFIER_XENO
	///should we go back to escorting the widow if we stray too far
	var/too_far_escort = TRUE
	///weakref to our mother
	var/datum/weakref/master_ref

/datum/ai_behavior/spiderling/New(loc, parent_to_assign, escorted_atom)
	. = ..()
	master_ref = WEAKREF(escorted_atom)
	change_order(null, SPIDERLING_RECALL)

///starts AI and registers obstructed move signal
/datum/ai_behavior/spiderling/start_ai()
	var/master = master_ref?.resolve()
	if(master)
		RegisterSignal(master, COMSIG_SPIDERLING_CHANGE_ALL_ORDER, PROC_REF(change_order))
	RegisterSignal(mob_parent, COMSIG_OBSTRUCTED_MOVE, PROC_REF(deal_with_obstacle))
	RegisterSignal(mob_parent, COMSIG_SPIDERLING_CHANGE_ORDER, PROC_REF(change_order))
	RegisterSignal(escorted_atom, COMSIG_XENOMORPH_REST, PROC_REF(start_resting))
	RegisterSignal(escorted_atom, COMSIG_XENOMORPH_UNREST, PROC_REF(stop_resting))
	RegisterSignal(escorted_atom, COMSIG_ELEMENT_JUMP_STARTED, PROC_REF(do_jump))
	RegisterSignal(escorted_atom, COMSIG_LIVING_DO_RESIST, PROC_REF(parent_resist))
	RegisterSignal(escorted_atom, COMSIG_XENOMORPH_RESIN_JELLY_APPLIED, PROC_REF(apply_spiderling_jelly))
	return ..()

///cleans up signals and unregisters obstructed move signal
/datum/ai_behavior/spiderling/cleanup_signals()
	. = ..()
	UnregisterSignal(mob_parent, list(COMSIG_OBSTRUCTED_MOVE,COMSIG_SPIDERLING_CHANGE_ORDER))
	var/master = master_ref?.resolve()
	if(master)
		UnregisterSignal(master, COMSIG_SPIDERLING_CHANGE_ALL_ORDER)

///Signal handler to try to attack our target
///Attack our current atom we are moving to, if targetted is specified attack that instead
/datum/ai_behavior/spiderling/proc/attack_target(datum/source, atom/targetted)
	SIGNAL_HANDLER
	if(world.time < mob_parent.next_move)
		return
	var/atom/target = targetted ? targetted : atom_to_walk_to
	if(!mob_parent.Adjacent(target))
		return
	if(mob_parent.z != target.z)
		return
	mob_parent.face_atom(target)
	mob_parent.UnarmedAttack(target, mob_parent)

///looks for a new state, handles recalling if too far and some AI shenanigans
/datum/ai_behavior/spiderling/look_for_new_state()
	switch(current_action)
		if(ESCORTING_ATOM)
			if(!escorted_atom && master_ref)
				escorted_atom = master_ref.resolve()
		if(MOVING_TO_ATOM)
			if(isliving(atom_to_walk_to))
				var/mob/living/target = atom_to_walk_to
				if(target.stat == DEAD)
					change_order(null, SPIDERLING_RECALL)
			if(QDELETED(atom_to_walk_to))
				change_order(null, SPIDERLING_RECALL)
	return ..()

///override for MOVING_TO_ATOM to register signals for maintaining distance with our target and attacking
/datum/ai_behavior/spiderling/register_action_signals(action_type)
	if(action_type == MOVING_TO_ATOM)
		RegisterSignal(mob_parent, COMSIG_STATE_MAINTAINED_DISTANCE, PROC_REF(attack_target))
		RegisterSignals(atom_to_walk_to, list(COMSIG_MOB_DEATH, COMSIG_QDELETING), PROC_REF(look_for_new_state))
	return ..()

///override for MOVING_TO_ATOM to unregister signals for maintaining distance with our target and attacking
/datum/ai_behavior/spiderling/unregister_action_signals(action_type)
	if(action_type == MOVING_TO_ATOM)
		UnregisterSignal(mob_parent, COMSIG_STATE_MAINTAINED_DISTANCE)
		if(!isnull(atom_to_walk_to))
			UnregisterSignal(atom_to_walk_to, list(COMSIG_MOB_DEATH, COMSIG_QDELETING))
	return ..()

///attack the first closest human, by moving towards it
/datum/ai_behavior/spiderling/proc/seek_and_attack_closest(mob/living/source)
	var/victim = get_nearest_target(mob_parent, target_distance, TARGET_HUMAN, mob_parent.faction)
	if(!victim)
		return FALSE
	change_action(MOVING_TO_ATOM, victim)
	return TRUE

///seeks a living humans in a 9 tile range near our parent, picks one, then changes our action to move towards it and attack.
/datum/ai_behavior/spiderling/proc/seek_and_attack()
	var/list/possible_victims = list()
	for(var/mob/living/carbon/human/victim in cheap_get_humans_near(mob_parent, 9))
		if(victim.stat == DEAD)
			continue
		if(HAS_TRAIT(victim, TRAIT_STEALTH))
			continue
		possible_victims += victim

	for(var/atom/nearby_turret AS in GLOB.marine_turrets)
		if(mob_parent.z != nearby_turret.z)
			continue
		if(!(get_dist(mob_parent, nearby_turret) < 9))
			continue
		possible_victims += nearby_turret

	if(!length(possible_victims))
		return FALSE

	change_action(MOVING_TO_ATOM, pick(possible_victims))
	return TRUE

///changes our current behavior with a define (order), optionally with a target, FALSE means fail and TRUE means success
/datum/ai_behavior/spiderling/proc/change_order(mob/living/source, order, atom/target)
	SIGNAL_HANDLER
	if(!order)
		stack_trace("spiderling AI was somehow passed a null order")
		return FALSE
	switch(order)
		if(SPIDERLING_SEEK_CLOSEST) //internal order, to attack closest enemy
			return seek_and_attack_closest()
		if(SPIDERLING_RECALL) //reset our escorted atom to master_ref and change our action to escorting it, and turn on recalling if out of range.
			escorted_atom = master_ref?.resolve()
			base_action = ESCORTING_ATOM
			change_action(ESCORTING_ATOM, escorted_atom)
			too_far_escort = TRUE
			return TRUE
		if(SPIDERLING_ATTACK) //turns on recalling out of range, if there is a target, attacks it, otherwise seeks and attacks one
			too_far_escort = TRUE
			source?.unbuckle_all_mobs()
			if(target)
				change_action(MOVING_TO_ATOM, target)
				return TRUE
			else
				return seek_and_attack()

///behavior to deal with obstacles
/datum/ai_behavior/spiderling/deal_with_obstacle(datum/source, direction)
	var/turf/obstacle_turf = get_step(mob_parent, direction)
	if(obstacle_turf.atom_flags & AI_BLOCKED)
		return
	for(var/thing in obstacle_turf.contents)
		if(istype(thing, /obj/structure/window_frame)) //if its a window, climb it after 2 seconds
			LAZYINCREMENT(mob_parent.do_actions, obstacle_turf)
			addtimer(CALLBACK(src, PROC_REF(climb_window_frame), obstacle_turf), 2 SECONDS)
			return COMSIG_OBSTACLE_DEALT_WITH
		if(istype(thing, /obj/alien)) //dont attack resin and such
			return
		if(isobj(thing)) //otherwise smash it if its damageable
			var/obj/obstacle = thing
			if(obstacle.resistance_flags & XENO_DAMAGEABLE)
				INVOKE_ASYNC(src, PROC_REF(attack_target), null, obstacle)
				return COMSIG_OBSTACLE_DEALT_WITH
	if(ISDIAGONALDIR(direction) && ((deal_with_obstacle(null, turn(direction, -45)) & COMSIG_OBSTACLE_DEALT_WITH) || (deal_with_obstacle(null, turn(direction, 45)) & COMSIG_OBSTACLE_DEALT_WITH)))
		return COMSIG_OBSTACLE_DEALT_WITH

///makes our parent climb over a turf with a window by setting its location to it
/datum/ai_behavior/spiderling/proc/climb_window_frame(turf/window_turf)
	mob_parent.loc = window_turf
	mob_parent.last_move_time = world.time
	LAZYDECREMENT(mob_parent.do_actions, window_turf)

/// rest when widow does
/datum/ai_behavior/spiderling/proc/start_resting(mob/source)
	SIGNAL_HANDLER
	var/mob/living/living = mob_parent
	living?.set_resting(TRUE)

/// stop resting when widow does
/datum/ai_behavior/spiderling/proc/stop_resting(mob/source)
	SIGNAL_HANDLER
	var/mob/living/living = mob_parent
	living?.set_resting(FALSE)
	source?.unbuckle_all_mobs()

/// jump when widow does
/datum/ai_behavior/spiderling/proc/do_jump()
	SIGNAL_HANDLER
	var/datum/component/jump/spider_jump = mob_parent.GetComponent(/datum/component/jump)
	spider_jump?.do_jump(mob_parent)

/// resist when widow does
/datum/ai_behavior/spiderling/proc/parent_resist()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/spiderling/spiderling_parent = mob_parent
	spiderling_parent?.do_resist()

/// Signal handler to apply resin jelly to the spiderling whenever widow gets it
/datum/ai_behavior/spiderling/proc/apply_spiderling_jelly()
	SIGNAL_HANDLER
	var/mob/living/carbon/xenomorph/spiderling/beno_to_coat = mob_parent
	beno_to_coat?.apply_status_effect(STATUS_EFFECT_RESIN_JELLY_COATING)

