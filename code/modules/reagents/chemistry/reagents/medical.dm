/datum/reagent/medicine
	name = "Medicine"
	taste_description = "bitterness"
	reagent_state = LIQUID
	taste_description = "bitterness"

/datum/reagent/medicine/inaprovaline
	name = "Inaprovaline"
	description = "Inaprovaline is a synaptic stimulant and cardiostimulant. Commonly used to stabilize patients."
	color = COLOR_REAGENT_INAPROVALINE
	overdose_threshold = REAGENTS_OVERDOSE*2
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL*2
	trait_flags = TACHYCARDIC

/datum/reagent/medicine/inaprovaline/on_mob_add(mob/living/L, metabolism)
	ADD_TRAIT(L, TRAIT_IGNORE_SUFFOCATION, REAGENT_TRAIT(src))
	var/mob/living/carbon/human/H = L
	if(TIMER_COOLDOWN_CHECK(L, name) || L.stat == DEAD)
		return
	if(L.health < H.health_threshold_crit && volume > 14) //If you are in crit, and someone injects at least 15u into you at once, you will heal 30% of your physical damage instantly.
		to_chat(L, span_userdanger("You feel a rush of energy as stimulants course through your veins!"))
		L.adjust_brute_loss(-L.get_brute_loss(TRUE) * 0.30)
		L.adjust_fire_loss(-L.get_fire_loss(TRUE) * 0.30)
		L.jitter(5)
		TIMER_COOLDOWN_START(L, name, 300 SECONDS)

/datum/reagent/medicine/inaprovaline/on_mob_delete(mob/living/L, metabolism)
	REMOVE_TRAIT(L, TRAIT_IGNORE_SUFFOCATION, REAGENT_TRAIT(src))
	return ..()

/datum/reagent/medicine/inaprovaline/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier += PAIN_REDUCTION_LIGHT
	return ..()

/datum/reagent/medicine/inaprovaline/overdose_process(mob/living/L, metabolism)
	L.jitter(2) //Overdose causes a spasm
	if(prob(15))
		L.Unconscious(rand(5, 25))

/datum/reagent/medicine/inaprovaline/overdose_crit_process(mob/living/L, metabolism)
	L.set_drowsyness(L.drowsyness, 20)
	if(ishuman(L)) //Critical overdose causes total blackout and heart damage. Too much stimulant
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/heart/E = H.get_organ_slot(ORGAN_SLOT_HEART)
		E.take_damage(0.5 * effect_str, TRUE)
	if(prob(10))
		L.emote(pick("twitch", "blink_r", "shiver"))

/datum/reagent/medicine/ryetalyn
	name = "Ryetalyn"
	description = "Ryetalyn is a long-duration shield against toxic chemicals."
	reagent_state = SOLID
	color = COLOR_REAGENT_RYETALYN
	custom_metabolism = REAGENTS_METABOLISM * 0.125
	purge_list = list(
		/datum/reagent/toxin,
		/datum/reagent/zombium,
	)
	purge_rate = 3
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/ryetalyn/on_mob_add(mob/living/L, metabolism)
	ADD_TRAIT(L, TRAIT_INTOXICATION_RESISTANT, REAGENT_TRAIT(src))
	return ..()

/datum/reagent/medicine/ryetalyn/on_mob_delete(mob/living/L, metabolism)
	REMOVE_TRAIT(L, TRAIT_INTOXICATION_RESISTANT, REAGENT_TRAIT(src))
	return ..()

/datum/reagent/medicine/ryetalyn/on_mob_life(mob/living/L, metabolism)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.disabilities = 0
	return ..()

/datum/reagent/medicine/ryetalyn/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/ryetalyn/overdose_crit_process(mob/living/L, metabolism)
	if(prob(15))
		L.Unconscious(30 SECONDS)
	L.apply_damage(3*effect_str, CLONE)

/datum/reagent/medicine/paracetamol
	name = "Paracetamol"
	description = "Most probably know this as Tylenol, but this chemical is a mild, simple painkiller, good for enduring heavy labor. Do not mix with Tramadol."
	color = COLOR_REAGENT_PARACETAMOL
	custom_metabolism = REAGENTS_METABOLISM * 0.125
	purge_list = list(
		/datum/reagent/medicine/bicaridine,
		/datum/reagent/medicine/kelotane,
	)
	purge_rate = 5
	overdose_threshold = REAGENTS_OVERDOSE*2
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL*2

/datum/reagent/medicine/paracetamol/on_mob_life(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_HEAVY
	L.heal_overall_damage(0.5*effect_str, 0.5*effect_str)
	L.adjust_tox_loss(-1.5*effect_str)
	L.adjust_stamina_loss(-effect_str)
	L.adjust_drowsyness(-0.5 SECONDS)
	L.AdjustUnconscious(-1 SECONDS)
	L.AdjustStun(-1 SECONDS)
	L.AdjustParalyzed(-1 SECONDS)
	L.add_movespeed_modifier(MOVESPEED_ID_MOB_PARACETAMOL_SPEED, TRUE, 0, NONE, TRUE, -0.1)
	return ..()


/datum/reagent/medicine/paracetamol/overdose_process(mob/living/L, metabolism)
	L.hallucination = max(L.hallucination, 2)
	L.reagent_pain_modifier += PAIN_REDUCTION_VERY_LIGHT
	L.apply_damage(0.5*effect_str, TOX)

/datum/reagent/medicine/paracetamol/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(3*effect_str, TOX)

/datum/reagent/medicine/paracetamol/on_mob_delete(mob/living/L, metabolism)
	L.remove_movespeed_modifier(MOVESPEED_ID_MOB_PARACETAMOL_SPEED)

/datum/reagent/medicine/tramadol
	name = "Tramadol"
	description = "A simple, yet effective painkiller."
	color = COLOR_REAGENT_TRAMADOL
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/tramadol/on_mob_life(mob/living/L)
	L.reagent_pain_modifier += PAIN_REDUCTION_VERY_HEAVY
	if(volume > 20)
		L.reagent_pain_modifier += PAIN_REDUCTION_LIGHT
		L.apply_damage(0.25*effect_str, TOX)
	return ..()

/datum/reagent/medicine/tramadol/overdose_process(mob/living/L, metabolism)
	L.hallucination = max(L.hallucination, 2) //Hallucinations and oxy damage
	L.apply_damage(effect_str, OXY)

/datum/reagent/medicine/tramadol/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(3*effect_str, TOX)

/datum/reagent/medicine/oxycodone
	name = "Oxycodone"
	description = "An effective and very addictive painkiller."
	color = COLOR_REAGENT_OXYCODONE
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5

/datum/reagent/medicine/oxycodone/on_mob_add(mob/living/L, metabolism)
	if(TIMER_COOLDOWN_CHECK(L, name))
		return
	L.adjust_stamina_loss(-20*effect_str)
	to_chat(L, span_userdanger("You feel a burst of energy revitalize you all of a sudden! You can do anything!"))

/datum/reagent/medicine/oxycodone/on_mob_life(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_SUPER_HEAVY
	L.apply_damage(0.2*effect_str, TOX)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_painloss(min(C.painloss - 1*effect_str, 150)) //you can still paincrit if under ludicrous situations, but you can't go into deep shock
	return ..()

/datum/reagent/medicine/oxycodone/overdose_process(mob/living/L, metabolism)
	L.adjust_stamina_loss(5*effect_str)
	L.set_drugginess(10)
	L.jitter(3)
	L.AdjustConfused(0.6 SECONDS)

/datum/reagent/medicine/oxycodone/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(3*effect_str, TOX)
	L.reagent_pain_modifier += PAIN_REDUCTION_VERY_HEAVY
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/heart/E = H.get_organ_slot(ORGAN_SLOT_HEART)
		if(E)
			E.take_damage(3*effect_str, TRUE)

/datum/reagent/medicine/oxycodone/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("The room spins slightly as you start to come down off your painkillers!"))
	TIMER_COOLDOWN_START(L, name, 60 SECONDS)

/datum/reagent/medicine/hydrocodone
	name = "Hydrocodone"
	description = "An effective but very short lasting painkiller only made by autodocs."
	color = COLOR_REAGENT_HYDROCODONE
	custom_metabolism = REAGENTS_METABOLISM * 2
	overdose_threshold = REAGENTS_OVERDOSE*0.6 //You aren't using this out of combat. And only the B18 makes it.
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL*0.5

/datum/reagent/medicine/hydrocodone/on_mob_life(mob/living/L, metabolism)
	L.reagent_pain_modifier += PAIN_REDUCTION_VERY_HEAVY
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_painloss(min(C.painloss - 1*effect_str, 150)) //you can still paincrit if under ludicrous situations, but you can't go into deep shock
	return ..()

/datum/reagent/medicine/hydrocodone/overdose_process(mob/living/L, metabolism)
	L.adjust_tox_loss(2.5*effect_str, TRUE)

/datum/reagent/medicine/hydrocodone/overdose_crit_process(mob/living/L, metabolism)
	L.adjust_brain_loss(1.5*effect_str, TRUE)

/datum/reagent/medicine/leporazine
	name = "Leporazine"
	description = "Leporazine can be use to stabilize an individuals body temperature."
	color = COLOR_REAGENT_LEPORAZINE
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/leporazine/on_mob_life(mob/living/L, metabolism)
	var/target_temp = L.get_standard_bodytemperature()
	if(L.bodytemperature > target_temp)
		L.adjust_bodytemperature(-40*TEMPERATURE_DAMAGE_COEFFICIENT*effect_str, target_temp)
	else if(L.bodytemperature < target_temp + 1)
		L.adjust_bodytemperature(40*TEMPERATURE_DAMAGE_COEFFICIENT*effect_str, 0, target_temp)
	return ..()

/datum/reagent/medicine/leporazine/overdose_process(mob/living/L, metabolism)
	if(prob(10))
		L.Unconscious(5 SECONDS)

/datum/reagent/medicine/leporazine/overdose_crit_process(mob/living/L, metabolism)
	L.drowsyness = max(L.drowsyness, 30)

/datum/reagent/medicine/kelotane
	name = "Kelotane"
	description = "Kelotane is a drug used to treat burns."
	color = COLOR_REAGENT_KELOTANE
	purge_list = list(
		/datum/reagent/medicine/ryetalyn,
		/datum/reagent/medicine/paracetamol,
		/datum/reagent/medicine/ifosfamide,
	)
	purge_rate = 2.5
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/kelotane/on_mob_life(mob/living/L, metabolism)
	var/target_temp = L.get_standard_bodytemperature()
	L.heal_overall_damage(0, effect_str)
	if(L.bodytemperature > target_temp)
		L.adjust_bodytemperature(-2.5*TEMPERATURE_DAMAGE_COEFFICIENT*effect_str, target_temp)
	if(volume > 10)
		L.reagent_pain_modifier -= PAIN_REDUCTION_VERY_LIGHT
	if(volume > 20)
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
		L.heal_overall_damage(0, 0.5*effect_str)
	return ..()

/datum/reagent/medicine/kelotane/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/kelotane/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2*effect_str, 0, 2*effect_str)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/lung = H.get_organ_slot(ORGAN_SLOT_LUNGS)
		lung.take_damage(0.7 * effect_str)

/datum/reagent/medicine/dermaline
	name = "Dermaline"
	description = "Dermaline is the next step in burn medication. Works twice as good as kelotane and enables the body to restore even the direst heat-damaged tissue."
	color = COLOR_REAGENT_DERMALINE
	overdose_threshold = REAGENTS_OVERDOSE*0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL*0.5

/datum/reagent/medicine/dermaline/on_mob_life(mob/living/L, metabolism)
	var/target_temp = L.get_standard_bodytemperature()
	L.heal_overall_damage(0, 2*effect_str)
	if(L.bodytemperature > target_temp)
		L.adjust_bodytemperature(-5*TEMPERATURE_DAMAGE_COEFFICIENT*effect_str, target_temp)
	if(volume > 5)
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
	if(volume > 10)
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
		L.heal_overall_damage(0, 1.5*effect_str)
	return ..()

/datum/reagent/medicine/dermaline/overdose_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, 0, effect_str)

/datum/reagent/medicine/dermaline/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(3*effect_str, 0, 3*effect_str)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/lung = H.get_organ_slot(ORGAN_SLOT_LUNGS)
		lung.take_damage(0.35 * effect_str)

/datum/reagent/medicine/saline_glucose
	name = "Saline-Glucose"
	description = "Saline-Glucose can be used to restore blood in a pinch."
	color = COLOR_REAGENT_SALINE_GLUCOSE
	custom_metabolism = REAGENTS_METABOLISM * 2
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL
	taste_description = "salty water"

/datum/reagent/medicine/saline_glucose/on_mob_life(mob/living/L, metabolism)
	if(L.blood_volume < BLOOD_VOLUME_NORMAL)
		L.adjust_blood_volume(1.2)
	return ..()

/datum/reagent/medicine/saline_glucose/overdose_process(mob/living/L, metabolism)
	L.apply_damages(1, 0, 1)

/datum/reagent/medicine/saline_glucose/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(1, 0, 1)

/datum/reagent/medicine/dexalin
	name = "Dexalin"
	description = "Dexalin is used in the treatment of oxygen deprivation."
	color = COLOR_REAGENT_DEXALIN
	custom_metabolism = REAGENTS_METABOLISM * 2.5
	overdose_threshold = REAGENTS_OVERDOSE * 0.5 // 15
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.6 // 30
	purge_list = list(/datum/reagent/medicine/synaptizine)
	purge_rate = 1

/datum/reagent/medicine/dexalin/on_mob_life(mob/living/L,metabolism)
	L.adjust_oxy_loss(-3*effect_str)
	holder.remove_reagent("lexorin", effect_str)
	return ..()

/datum/reagent/medicine/dexalin/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2 * effect_str, BURN)

/datum/reagent/medicine/dexalin/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2*effect_str, 0, 2*effect_str)

/datum/reagent/medicine/dexalinplus
	name = "Dexalin Plus"
	description = "Dexalin Plus is used in the treatment of oxygen deprivation. It is highly effective."
	color = COLOR_REAGENT_DEXALINPLUS
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5

/datum/reagent/medicine/dexalinplus/on_mob_life(mob/living/L,metabolism)
	L.adjust_oxy_loss(-L.get_oxy_loss())
	holder.remove_reagent("lexorin", effect_str)
	return ..()

/datum/reagent/medicine/dexalinplus/on_mob_add(mob/living/L, metabolism)
	if(TIMER_COOLDOWN_CHECK(L, name))
		return
	L.adjust_stamina_loss(-100*effect_str)
	to_chat(L, span_userdanger("You feel a complete lack of fatigue, so relaxing!"))

/datum/reagent/medicine/dexalinplus/on_mob_delete(mob/living/L, metabolism)
	TIMER_COOLDOWN_START(L, name, 180 SECONDS)

/datum/reagent/medicine/dexalinplus/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/dexalinplus/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2*effect_str, 0, 3*effect_str)

/datum/reagent/medicine/tricordrazine
	name = "Tricordrazine"
	description = "Tricordrazine is a highly potent stimulant, originally derived from cordrazine. Can be used to treat a wide range of injuries."
	color = COLOR_REAGENT_TRICORDRAZINE
	purge_list = list(/datum/reagent/medicine/ryetalyn)
	purge_rate = 1
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL
	taste_description = "grossness"

/datum/reagent/medicine/tricordrazine/on_mob_life(mob/living/L, metabolism)

	L.adjust_oxy_loss(-0.5*effect_str)
	L.adjust_tox_loss(-0.4*effect_str)
	L.heal_overall_damage(0.8*effect_str, 0.8*effect_str)
	if(volume > 10)
		L.reagent_pain_modifier -= PAIN_REDUCTION_VERY_LIGHT
	if(volume > 20)
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
	return ..()

/datum/reagent/medicine/tricordrazine/overdose_process(mob/living/L, metabolism)
	L.jitter(5)
	L.adjust_brain_loss(effect_str, TRUE)

/datum/reagent/medicine/tricordrazine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(3*effect_str, 3*effect_str, 3*effect_str)

/datum/reagent/medicine/dylovene
	name = "Dylovene"
	description = "Dylovene is a broad-spectrum antitoxin."
	color = COLOR_REAGENT_DYLOVENE
	purge_list = list(/datum/reagent/toxin, /datum/reagent/medicine/research/stimulon, /datum/reagent/consumable/atomiccoffee, /datum/reagent/medicine/paracetamol, /datum/reagent/medicine/larvaway)
	purge_rate = 1
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL
	taste_description = "a roll of gauze"

/datum/reagent/medicine/dylovene/on_mob_add(mob/living/L, metabolism)
	L.add_stamina_regen_modifier(name, -0.5)
	return ..()

/datum/reagent/medicine/dylovene/on_mob_delete(mob/living/L, metabolism)
	L.remove_stamina_regen_modifier(name)
	return ..()

/datum/reagent/medicine/dylovene/on_mob_life(mob/living/L,metabolism)
	L.hallucination = max(0, L.hallucination -  2.5*effect_str)
	L.adjust_tox_loss(-effect_str)
	return ..()

/datum/reagent/medicine/dylovene/overdose_process(mob/living/L, metabolism)
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/H = L
	var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
	if(E)
		E.take_damage(0.5*effect_str, TRUE)

/datum/reagent/medicine/dylovene/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2*effect_str, 2*effect_str)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
		if(E)
			E.take_damage(1.5*effect_str, TRUE)

/datum/reagent/medicine/adminordrazine //An OP chemical for admins
	name = "Adminordrazine"
	description = "It's magic. We don't have to explain it."
	color = COLOR_REAGENT_ADMINORDRAZINE
	taste_description = "badmins"

/datum/reagent/medicine/adminordrazine/on_mob_life(mob/living/L, metabolism)
	L.reagents.remove_all_type(/datum/reagent/toxin, 2.5*effect_str, 0, 1)
	L.set_clone_loss(0)
	L.set_oxy_loss(0)
	L.heal_overall_damage(5, 5)
	L.adjust_tox_loss(-5)
	L.hallucination = 0
	L.set_brain_loss(0)
	L.set_blurriness(0, TRUE)
	L.set_blindness(0, TRUE)
	L.SetStun(0, FALSE)
	L.SetUnconscious(0)
	L.SetParalyzed(0)
	L.dizziness = 0
	L.set_drowsyness(0)
	// Remove all speech related status effects
	for(var/effect in typesof(/datum/status_effect/speech))
		L.remove_status_effect(effect)
	L.SetConfused(0)
	L.SetSleeping(0)
	L.jitteriness = 0
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.drunkenness = 0
		C.disabilities = 0
	return ..()

/datum/reagent/medicine/synaptizine
	name = "Synaptizine"
	description = "Synaptizine is a commonly used performance-enhancing drug with minimal side effects."
	color = COLOR_REAGENT_SYNAPTIZINE
	overdose_threshold = REAGENTS_OVERDOSE/5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/5
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	purge_list = list(/datum/reagent/toxin/mindbreaker)
	purge_rate = 5

/datum/reagent/medicine/synaptizine/on_mob_add(mob/living/L, metabolism)
	if(TIMER_COOLDOWN_CHECK(L, name))
		return
	L.adjust_stamina_loss(-30*effect_str)
	to_chat(L, span_userdanger("You feel a burst of energy as the stimulants course through you! Time to go!"))

/datum/reagent/medicine/synaptizine/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier += PAIN_REDUCTION_MEDIUM
	L.adjust_drowsyness(-0.5 SECONDS)
	L.AdjustUnconscious(-2 SECONDS)
	L.AdjustStun(-2 SECONDS)
	L.AdjustParalyzed(-2 SECONDS)
	L.adjust_tox_loss(effect_str)
	L.hallucination = max(0, L.hallucination - 10)
	switch(current_cycle)
		if(1 to 10)
			L.adjust_stamina_loss(-7.5*effect_str)
		if(11 to 40)
			L.adjust_stamina_loss((current_cycle*0.75 - 14)*effect_str)
		if(41 to INFINITY)
			L.adjust_stamina_loss(15*effect_str)
	return ..()

/datum/reagent/medicine/synaptizine/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2 * effect_str, TOX)

/datum/reagent/medicine/synaptizine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2 * effect_str, 2 * effect_str, 3 * effect_str)

/datum/reagent/medicine/synaptizine/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("The room spins as you start to come down off your stimulants!"))
	TIMER_COOLDOWN_START(L, name, 60 SECONDS)

///ADRENALINE, basically old synaptizine with buffs?
/datum/reagent/medicine/adrenaline
	name = "Adrenaline"
	description = "Gotta go fast!"
	color = "#f14a17"
	overdose_threshold = REAGENTS_OVERDOSE/5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/5
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	purge_rate = 5

/datum/reagent/medicine/adrenaline/on_mob_add(mob/living/carbon/human/L, metabolism)
	var/mob/living/carbon/human/H = L
	if(TIMER_COOLDOWN_CHECK(L, COOLDOWN_STAMINA))
		return
	L.adjust_stamina_loss(-30 * effect_str)
	to_chat(L, span_userdanger("You feel a burst of energy as the adrenaline courses through you! Time to go fast!"))

	if(TIMER_COOLDOWN_CHECK(L, COOLDOWN_CRIT) || L.stat == DEAD)
		return
	if(L.health < H.health_threshold_crit && volume >= 2)
		to_chat(L, span_userdanger("Heart explosion! Power running in your veins!"))
		L.adjust_brute_loss(-L.get_brute_loss(TRUE) * 0.40)
		L.adjust_fire_loss(-L.get_fire_loss(TRUE) * 0.20)
		L.adjust_tox_loss(5)
		L.jitter(5)
		TIMER_COOLDOWN_START(L, COOLDOWN_CRIT, 120 SECONDS)

/datum/reagent/medicine/adrenaline/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier += PAIN_REDUCTION_MEDIUM
	L.adjust_drowsyness(-0.5 SECONDS)
	L.AdjustUnconscious(-2 SECONDS)
	L.AdjustStun(-2 SECONDS)
	L.AdjustParalyzed(-2 SECONDS)
	L.adjust_tox_loss(0.8 * effect_str)
	L.hallucination = max(0, L.hallucination - 10)
	switch(current_cycle)
		if(1 to 10)
			L.adjust_stamina_loss(-7.5 * effect_str)
		if(11 to 40)
			L.adjust_stamina_loss((current_cycle*0.75 - 14)*effect_str)
		if(41 to INFINITY)
			L.adjust_stamina_loss(15 * effect_str)
	return ..()

/datum/reagent/medicine/adrenaline/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/adrenaline/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, effect_str, effect_str)

/datum/reagent/medicine/adrenaline/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("The room spins as your adrenaline starts to wear off!"))
	TIMER_COOLDOWN_START(L, COOLDOWN_STAMINA, 60 SECONDS)

/datum/reagent/medicine/neuraline //injected by neurostimulator implant and medic-only injector
	name = "Neuraline"
	description = "A chemical cocktail tailored to enhance or dampen specific neural processes."
	color = COLOR_REAGENT_NEURALINE
	custom_metabolism = REAGENTS_METABOLISM * 2
	overdose_threshold = 5
	overdose_crit_threshold = 6

/datum/reagent/medicine/neuraline/on_mob_add(mob/living/L, metabolism)
	var/mob/living/carbon/human/H = L
	if(TIMER_COOLDOWN_CHECK(L, name) || L.stat == DEAD)
		return
	if(L.health < H.health_threshold_crit && volume > 3) //If you are in crit, and someone injects at least 3u into you, you will heal 20% of your physical damage instantly.
		to_chat(L, span_userdanger("You feel a rush of energy as stimulants course through your veins!"))
		L.adjust_brute_loss(-L.get_brute_loss(TRUE) * 0.20)
		L.adjust_fire_loss(-L.get_fire_loss(TRUE) * 0.20)
		L.jitter(10)
		TIMER_COOLDOWN_START(L, name, 300 SECONDS)

/datum/reagent/medicine/neuraline/on_mob_life(mob/living/L)
	L.reagent_shock_modifier += (2 * PAIN_REDUCTION_VERY_HEAVY)
	L.adjust_drowsyness(-5)
	L.dizzy(-5)
	L.adjust_timed_status_effect(-10 SECONDS, /datum/status_effect/speech/stutter)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.drunkenness = max(C.drunkenness-5, 0)
	L.AdjustConfused(-10 SECONDS)
	L.adjust_blurriness(-5)
	L.AdjustUnconscious(-4 SECONDS)
	L.AdjustStun(-4 SECONDS)
	L.AdjustParalyzed(-2 SECONDS)
	L.AdjustSleeping(-4 SECONDS)
	L.adjust_stamina_loss(-30*effect_str)
	L.heal_overall_damage(7.5*effect_str, 7.5*effect_str)
	L.adjust_tox_loss(3.75*effect_str)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_painloss(min(C.painloss - volume*effect_str, 150)) //will pull a target out of deep paincrit instantly, if he's in it
	return ..()

/datum/reagent/medicine/neuraline/overdose_process(mob/living/L, metabolism)
	L.adjust_tox_loss(2.5*effect_str, TRUE)

/datum/reagent/medicine/neuraline/overdose_crit_process(mob/living/L, metabolism)
	L.adjust_brain_loss(10*effect_str, TRUE) //if you double inject, you're fucked till surgery. This is the downside of a very strong chem.

/datum/reagent/medicine/hyronalin
	name = "Hyronalin"
	description = "Hyronalin is a medicinal drug used to counter the effect of toxin poisoning."
	color = COLOR_REAGENT_HYRONALIN
	custom_metabolism = REAGENTS_METABOLISM
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/hyronalin/on_mob_life(mob/living/L)
	L.adjust_tox_loss(-effect_str)
	return ..()

/datum/reagent/medicine/hyronalin/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, TOX)

/datum/reagent/medicine/hyronalin/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(0, effect_str, effect_str)

/datum/reagent/medicine/arithrazine
	name = "Arithrazine"
	description = "Arithrazine is a component medicine capable of healing minor amounts of toxin poisoning."
	color = COLOR_REAGENT_ARITHRAZINE
	custom_metabolism = REAGENTS_METABOLISM
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5

/datum/reagent/medicine/arithrazine/on_mob_life(mob/living/L)
	L.adjust_tox_loss(-0.5*effect_str)
	if(prob(15))
		L.take_limb_damage(effect_str, 0)
	return ..()

/datum/reagent/medicine/arithrazine/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/arithrazine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, effect_str, 2*effect_str)

/datum/reagent/medicine/russian_red
	name = "Russian Red"
	description = "An emergency generic treatment with extreme side effects."
	color = COLOR_REAGENT_RUSSIAN_RED
	custom_metabolism = REAGENTS_METABOLISM * 5
	overdose_threshold = REAGENTS_OVERDOSE * 0.5   //so it makes the OD threshold effectively 15 so two pills is too much but one is fine
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL / 2.5 //and this makes the Critical OD 20

/datum/reagent/medicine/russian_red/on_mob_add(mob/living/L, metabolism)
	var/mob/living/carbon/human/H = L
	if(TIMER_COOLDOWN_CHECK(L, name) || L.stat == DEAD)
		return
	if(L.health < H.health_threshold_crit && volume > 9) //If you are in crit, and someone injects at least 9u into you, you will heal 20% of your physical damage instantly.
		to_chat(L, span_userdanger("You feel a rush of energy as stimulants course through your veins!"))
		L.adjust_brute_loss(-L.get_brute_loss(TRUE) * 0.20)
		L.adjust_fire_loss(-L.get_fire_loss(TRUE) * 0.20)
		L.jitter(10)
		TIMER_COOLDOWN_START(L, name, 300 SECONDS)

/datum/reagent/medicine/russian_red/on_mob_life(mob/living/L, metabolism)
	L.heal_overall_damage(7*effect_str, 7*effect_str)
	L.adjust_tox_loss(-2.5*effect_str)
	L.adjust_clone_loss(0.7*effect_str)
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		C.set_painloss(min(C.painloss - 5*effect_str, 150)) //removes a target from deep paincrit instantly
	return ..()

/datum/reagent/medicine/russian_red/overdose_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, 0, 0)

/datum/reagent/medicine/russian_red/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, 2*effect_str, effect_str)
	L.adjust_brain_loss(2*effect_str, TRUE)

/datum/reagent/medicine/alkysine
	name = "Alkysine"
	description = "Alkysine is a drug used to lessen the damage to neurological and auditory tissue after a catastrophic injury. Can heal brain and ear tissue."
	color = COLOR_REAGENT_ALKYSINE
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/alkysine/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier += PAIN_REDUCTION_VERY_LIGHT
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/brain/B = H.get_organ_slot(ORGAN_SLOT_BRAIN)
		if(B.damage < 30)
			L.adjust_brain_loss(-1.5*effect_str)
			L.adjust_tox_loss(-1.5 * effect_str)
	L.adjust_ear_damage(-2 * effect_str, -2 * effect_str)
	return ..()

/datum/reagent/medicine/alkysine/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/alkysine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(0, effect_str, effect_str)

/datum/reagent/medicine/imidazoline
	name = "Imidazoline"
	description = "Heals eye damage"
	color = COLOR_REAGENT_IMIDAZOLINE
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL
	taste_description = "dull toxin"

/datum/reagent/medicine/imidazoline/on_mob_life(mob/living/L, metabolism)
	L.adjust_blurriness(-5)
	L.adjust_blindness(-5)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/eyes/E = H.get_organ_slot(ORGAN_SLOT_EYES)
		if(E.damage < 30)
			E.heal_organ_damage(effect_str)
			L.adjust_tox_loss(-1.5 * effect_str)
	return ..()

/datum/reagent/medicine/imidazoline/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, TOX)

/datum/reagent/medicine/imidazoline/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(0, effect_str, 2*effect_str)

/datum/reagent/medicine/peridaxon
	name = "Peridaxon"
	description = "Used to stabilize internal organs while waiting for surgery, and fixes organ damage at cryogenic temperatures. Medicate cautiously."
	color = "#C845DC"
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5
	custom_metabolism = REAGENTS_METABOLISM * 0.25

/datum/reagent/medicine/peridaxon/on_mob_life(mob/living/L, metabolism)
	if(!ishuman(L))
		return ..()
	var/mob/living/carbon/human/H = L
	for(var/datum/internal_organ/I in H.internal_organs)
		if(I.damage)
			if(L.bodytemperature > 169 && I.damage > 5)
				continue
			I.heal_organ_damage(3 * effect_str)
	return ..()
/datum/reagent/medicine/peridaxon/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, BRUTE)

/datum/reagent/medicine/peridaxon/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(6*effect_str, BRUTE)

/datum/reagent/medicine/peridaxon/on_mob_add(mob/living/L, metabolism)
	. = ..()
	var/mob/living/carbon/human/H = L
	for(var/datum/internal_organ/I in H.internal_organs)
		I.set_organ_status()

/datum/reagent/medicine/peridaxon/on_mob_delete(mob/living/L, metabolism)
	var/mob/living/carbon/human/H = L
	for(var/datum/internal_organ/I in H.internal_organs)
		I.set_organ_status()
	return ..()

/datum/reagent/medicine/peridaxon_plus
	name = "Peridaxon Plus"
	description = "Used to heal severely damaged internal organs in the field. Moderately toxic. Do not self-administer."
	color = COLOR_REAGENT_PERIDAXON_PLUS
	overdose_threshold = REAGENTS_OVERDOSE/30
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/25
	custom_metabolism = REAGENTS_METABOLISM * 0.5

/datum/reagent/medicine/peridaxon_plus/on_mob_life(mob/living/L, metabolism)
	L.reagents.add_reagent(/datum/reagent/toxin, 5)
	L.adjust_stamina_loss(10 * effect_str)
	if(!ishuman(L))
		return ..()
	var/mob/living/carbon/human/H = L
	var/datum/internal_organ/organ = H.get_damaged_organ()
	if(!organ)
		return ..()
	organ.heal_organ_damage(3 * effect_str)
	H.adjust_clone_loss(1 * effect_str)
	return ..()

/datum/reagent/medicine/peridaxon_plus/overdose_process(mob/living/L, metabolism)
	L.apply_damage(15*effect_str, TOX)

/datum/reagent/medicine/peridaxon_plus/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(15*effect_str, TOX) //Ya triple-clicked. Ya shouldn'ta did that.

/datum/reagent/medicine/bicaridine
	name = "Bicaridine"
	description = "Bicaridine is an analgesic medication and can be used to treat blunt trauma."
	color = COLOR_REAGENT_BICARIDINE
	purge_list = list(
		/datum/reagent/medicine/ryetalyn,
		/datum/reagent/medicine/paracetamol,
		/datum/reagent/medicine/ifosfamide,
	)
	purge_rate = 2.5
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/bicaridine/on_mob_life(mob/living/L, metabolism)
	L.heal_overall_damage(effect_str, 0)
	if(volume > 10)
		L.reagent_pain_modifier -= PAIN_REDUCTION_VERY_LIGHT
	if(volume > 20)
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
		L.heal_overall_damage(0.5*effect_str, 0)
	return ..()


/datum/reagent/medicine/bicaridine/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/bicaridine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(effect_str, 3*effect_str, 2*effect_str)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/liver = H.get_organ_slot(ORGAN_SLOT_LIVER)
		liver.take_damage(0.7 * effect_str)

/datum/reagent/medicine/meralyne
	name = "Meralyne"
	description = "Meralyne is a concentrated form of bicaridine and can be used to treat extensive blunt trauma."
	color = COLOR_REAGENT_MERALYNE
	overdose_threshold = REAGENTS_OVERDOSE*0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL*0.5

/datum/reagent/medicine/meralyne/on_mob_life(mob/living/L, metabolism)
	L.heal_overall_damage(2*effect_str, 0)
	if(volume > 5)
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
	if(volume > 10)
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT
		L.heal_overall_damage(1.5*effect_str, 0)
	return ..()


/datum/reagent/medicine/meralyne/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, BURN)

/datum/reagent/medicine/meralyne/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(2*effect_str, 6*effect_str, 4*effect_str)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/liver = H.get_organ_slot(ORGAN_SLOT_LIVER)
		liver.take_damage(0.35 * effect_str)

/datum/reagent/medicine/quickclot
	name = "Quick Clot"
	description = "A chemical designed to quickly arrest all sorts of bleeding by encouraging coagulation. Can rectify internal bleeding at cryogenic temperatures."
	color = COLOR_REAGENT_QUICKCLOT
	overdose_threshold = REAGENTS_OVERDOSE * 0.5 //Was 4, now 6 //Now 15
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5
	custom_metabolism = REAGENTS_METABOLISM * 0.25

/datum/reagent/medicine/quickclot/on_mob_life(mob/living/L, metabolism)
	L.adjust_blood_volume(0.2)
	if(!ishuman(L) || L.bodytemperature > 169) //only heals IB at cryogenic temperatures.
		return ..()
	var/mob/living/carbon/human/H = L
	for(var/datum/limb/X in H.limbs)
		for(var/datum/wound/internal_bleeding/W in X.wounds)
			W.damage = max(0, W.damage - (effect_str))
	return ..()

/datum/reagent/medicine/quickclot/overdose_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, BRUTE)

/datum/reagent/medicine/quickclot/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(0, 2*effect_str, 2*effect_str)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/affected_organ = pick(ORGAN_SLOT_HEART, ORGAN_SLOT_LUNGS, ORGAN_SLOT_LIVER, ORGAN_SLOT_KIDNEYS, ORGAN_SLOT_STOMACH)
		var/datum/internal_organ/Organrand = H.get_organ_slot(affected_organ)
		Organrand.take_damage(1 * effect_str)


/datum/reagent/medicine/quickclotplus
	name = "Quick Clot Plus"
	description = "A chemical designed to quickly and painfully remove internal bleeding by encouraging coagulation. Should not be self-administered."
	color = COLOR_REAGENT_QUICKCLOTPLUS
	overdose_threshold = REAGENTS_OVERDOSE/5 //6u
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/5 //12u
	custom_metabolism = REAGENTS_METABOLISM * 2.5
	///The IB wound this dose of QCP will cure, if it lasts long enough
	var/datum/wound/internal_bleeding/target_IB
	///Ticks remaining before the target_IB is cured
	var/ticks_left
	///Ticks needed to cure an IB
	var/ticks_to_cure_IB = 10

/datum/reagent/medicine/quickclotplus/on_mob_add(mob/living/L, metabolism)
	select_wound(L)

/datum/reagent/medicine/quickclotplus/on_mob_delete(mob/living/L, metabolism)
	if(target_IB)
		to_chat(L, span_warning("The searing pain in your [target_IB.parent_limb.display_name] returns to a dull ache..."))
		UnregisterSignal(target_IB, COMSIG_QDELETING)
		target_IB = null

/datum/reagent/medicine/quickclotplus/on_mob_life(mob/living/L, metabolism)
	L.reagents.add_reagent(/datum/reagent/toxin,5)
	L.reagent_shock_modifier -= PAIN_REDUCTION_VERY_HEAVY
	L.adjust_stamina_loss(15*effect_str)
	if(!target_IB)
		select_wound(L)
		ticks_left-- //Keep treatment time at the total ticks_to_cure if we select here, including the tick used to select a wound
		return ..()
	ticks_left--
	if(!ticks_left)
		to_chat(L, span_alert("The searing pain in your [target_IB.parent_limb.display_name] peaks, then slowly fades away entirely."))
		target_IB.parent_limb.createwound(CUT, target_IB.damage * 0.5)
		UnregisterSignal(target_IB, COMSIG_QDELETING)
		QDEL_NULL(target_IB)
		L.adjust_clone_loss(5*effect_str)
	return ..()

///Choose an internal bleeding wound to lock onto and cure after a delay.
/datum/reagent/medicine/quickclotplus/proc/select_wound(mob/living/L)
	if(target_IB)
		return
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/body = L
	for(var/datum/limb/possible_limb AS in body.limbs)
		for(var/datum/wound/internal_bleeding/possible_IB in possible_limb.wounds)
			target_IB = possible_IB
			RegisterSignal(target_IB, COMSIG_QDELETING, PROC_REF(clear_wound))
			break
		if(target_IB)
			break
	if(target_IB)
		to_chat(body, span_userdanger("The deep ache in your [target_IB.parent_limb.display_name] erupts into searing pain!"))
		ticks_left = ticks_to_cure_IB

///If something else removes the wound before the drug finishes with it, we need to clean references.
/datum/reagent/medicine/quickclotplus/proc/clear_wound(atom/target)
	SIGNAL_HANDLER
	if(target_IB)
		UnregisterSignal(target_IB, COMSIG_QDELETING)
		target_IB = null


/datum/reagent/medicine/quickclotplus/overdose_process(mob/living/L, metabolism)
	L.apply_damage(1.5*effect_str, TOX)
	L.adjust_blood_volume(-4)

/datum/reagent/medicine/quickclotplus/overdose_crit_process(mob/living/L, metabolism)
	L.adjust_blood_volume(-20)

/datum/reagent/medicine/nanoblood
	name = "Nanoblood"
	description = "A chemical designed to massively boost the body's natural blood restoration rate. Causes fatigue and minor toxic effects."
	color = COLOR_REAGENT_NANOBLOOD
	overdose_threshold = REAGENTS_OVERDOSE/5 //6u
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL/5 //10u

/datum/reagent/medicine/nanoblood/on_mob_life(mob/living/L, metabolism)
	L.adjust_blood_volume(3.4)
	L.adjust_tox_loss(effect_str)
	L.adjust_stamina_loss(6 * effect_str)
	if(L.blood_volume < BLOOD_VOLUME_OKAY)
		L.adjust_blood_volume(3.4)
	if(L.blood_volume < BLOOD_VOLUME_BAD)
		L.set_blood_volume(BLOOD_VOLUME_BAD + 2)
		L.reagents.add_reagent(/datum/reagent/toxin, 25)
		L.AdjustSleeping(10 SECONDS)
	return ..()

/datum/reagent/medicine/nanoblood/overdose_process(mob/living/L, metabolism)
	L.apply_damage(1.5*effect_str, TOX)

/datum/reagent/medicine/nanoblood/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(3*effect_str, TOX)

/datum/reagent/medicine/ultrazine
	name = "Ultrazine"
	description = "A highly-potent, long-lasting combination CNS and muscle stimulant. Extremely addictive."
	color = COLOR_REAGENT_ULTRAZINE
	custom_metabolism = REAGENTS_METABOLISM * 0.0835
	overdose_threshold = 10
	overdose_crit_threshold = 20
	addiction_threshold = 0.4 // Adios Addiction Virus
	taste_multi = 2

/datum/reagent/medicine/ultrazine/on_mob_add(mob/living/L, metabolism)
	. = ..()
	L.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -1)

/datum/reagent/medicine/ultrazine/on_mob_delete(mob/living/L, metabolism)
	L.remove_movespeed_modifier(type)

/datum/reagent/medicine/ultrazine/on_mob_life(mob/living/L, metabolism)
	if(prob(50))
		L.AdjustParalyzed(-2 SECONDS)
		L.AdjustStun(-2 SECONDS)
		L.AdjustUnconscious(-2 SECONDS)
	L.adjust_stamina_loss(-2*effect_str)
	if(prob(2))
		L.emote(pick("twitch","blink_r","shiver"))
	return ..()

/datum/reagent/medicine/ultrazine/addiction_act_stage1(mob/living/L, metabolism)
	if(prob(10))
		to_chat(L, span_notice("[pick("You could use another hit.", "More of that would be nice.", "Another dose would help.", "One more dose wouldn't hurt", "Why not take one more?")]"))
	if(prob(5))
		L.emote(pick("twitch","blink_r","shiver"))
		L.adjust_stamina_loss(20)
	if(prob(20))
		L.hallucination += 10

/datum/reagent/medicine/ultrazine/addiction_act_stage2(mob/living/L, metabolism)
	if(prob(10))
		to_chat(L, span_warning("[pick("It's just not the same without it.", "You could use another hit.", "You should take another.", "Just one more.", "Looks like you need another one.")]"))
	if(prob(5))
		L.emote("me", EMOTE_VISIBLE, pick("winces slightly.", "grimaces."))
		L.adjust_stamina_loss(35)
		L.Stun(2 SECONDS)
	if(prob(20))
		L.hallucination += 15

/datum/reagent/medicine/ultrazine/addiction_act_stage3(mob/living/L, metabolism)
	if(prob(10))
		to_chat(L, span_warning("[pick("You need more.", "It's hard to go on like this.", "You want more. You need more.", "Just take another hit. Now.", "One more.")]"))
	if(prob(5))
		L.emote("me", EMOTE_VISIBLE, pick("winces.", "grimaces.", "groans!"))
		L.Stun(3 SECONDS)
	if(prob(20))
		L.hallucination += 20
		L.dizzy(60)
	L.adjust_tox_loss(0.1*effect_str)
	L.adjust_brain_loss(0.1*effect_str, TRUE)

/datum/reagent/medicine/ultrazine/addiction_act_stage4(mob/living/L, metabolism)
	if(prob(10))
		to_chat(L, span_danger("[pick("You need another dose, now. NOW.", "You can't stand it. You have to go back. You have to go back.", "You need more. YOU NEED MORE.", "MORE", "TAKE MORE.")]"))
	if(prob(5))
		L.emote("me", EMOTE_VISIBLE, pick("groans painfully!", "contorts with pain!"))
		L.Stun(8 SECONDS)
		L.do_jitter_animation(200)
	if(prob(20))
		L.hallucination += 30
		L.dizzy(80)
	L.adjust_tox_loss(0.3*effect_str)
	L.adjust_brain_loss(0.1*effect_str, TRUE)
	if(prob(15) && ishuman(L))
		var/mob/living/carbon/human/H = L
		var/affected_organ = pick(ORGAN_SLOT_HEART, ORGAN_SLOT_LUNGS, ORGAN_SLOT_LIVER, ORGAN_SLOT_KIDNEYS, ORGAN_SLOT_STOMACH)
		var/datum/internal_organ/I = H.get_organ_slot(affected_organ)
		I.take_damage(5.5 * effect_str)

/datum/reagent/medicine/ultrazine/overdose_process(mob/living/L, metabolism)
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/heart/E = H.get_organ_slot(ORGAN_SLOT_HEART)
		if(E)
			E.take_damage(0.5*effect_str, TRUE)
	else
		L.adjust_tox_loss(0.5*effect_str)
	if(prob(10))
		L.emote(pick("twitch", "blink_r", "shiver"))

/datum/reagent/medicine/ultrazine/overdose_crit_process(mob/living/L, metabolism)
	if(!ishuman(L))
		L.adjust_tox_loss(1.5*effect_str)
	else
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/heart/E = H.get_organ_slot(ORGAN_SLOT_HEART)
		if(E)
			E.take_damage(1.5*effect_str, TRUE)

/datum/reagent/medicine/cryoxadone
	name = "Cryoxadone"
	description = "A chemical mixture with almost magical healing powers. Its main limitation is that the targets body temperature must be under 170K for it to metabolise correctly."
	reagent_state = LIQUID
	color = COLOR_REAGENT_CRYOXADONE
	taste_description = "sludge"
	trait_flags = BRADYCARDICS

/datum/reagent/medicine/cryoxadone/on_mob_life(mob/living/L, metabolism)
	if(L.bodytemperature < 170)
		L.adjust_clone_loss(-effect_str)
		L.adjust_oxy_loss(-effect_str)
		L.heal_overall_damage(effect_str,effect_str)
		L.adjust_tox_loss(-effect_str)
	return ..()

/datum/reagent/medicine/clonexadone
	name = "Clonexadone"
	description = "A liquid compound similar to that used in the cloning process. Can be used to 'finish' the cloning process when used in conjunction with a cryo tube."
	color = COLOR_REAGENT_CLONEXADONE
	taste_description = "muscle"
	trait_flags = BRADYCARDICS

/datum/reagent/medicine/clonexadone/on_mob_life(mob/living/L, metabolism)
	if(L.bodytemperature < 170)
		L.adjust_clone_loss(-3*effect_str)
		L.adjust_oxy_loss(-3*effect_str)
		L.heal_overall_damage(3*effect_str,3*effect_str)
		L.adjust_tox_loss(-3*effect_str)

	return ..()

/datum/reagent/medicine/rezadone
	name = "Rezadone"
	description = "A powder derived from fish toxin, this substance can effectively treat genetic damage in humanoids, though excessive consumption has side effects."
	reagent_state = SOLID
	color = COLOR_REAGENT_REZADONE
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL
	taste_description = "fish"

/datum/reagent/medicine/rezadone/on_mob_life(mob/living/L, metabolism)
	switch(current_cycle)
		if(1 to 15)
			L.adjust_clone_loss(-effect_str)
			L.heal_overall_damage(effect_str,effect_str)
		if(16 to 35)
			L.adjust_clone_loss(-2*effect_str)
			L.heal_overall_damage(2*effect_str,effect_str)

			L.status_flags &= ~DISFIGURED
			if(ishuman(L))
				var/mob/living/carbon/human/H = L
				H.name = H.get_visible_name()
		if(35 to INFINITY)
			L.adjust_tox_loss(effect_str)
			L.dizzy(5)
			L.jitter(5)
	return ..()

/datum/reagent/medicine/rezadone/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/rezadone/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, TOX)

/datum/reagent/medicine/spaceacillin
	name = "Spaceacillin"
	description = "An all-purpose antiviral agent."
	color = COLOR_REAGENT_SPACEACILLIN
	custom_metabolism = REAGENTS_METABOLISM * 0.05
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL
	purge_list = list(/datum/reagent/medicine/xenojelly)
	purge_rate = 5

/datum/reagent/medicine/spaceacillin/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/spaceacillin/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, TOX)

/datum/reagent/medicine/polyhexanide
	name = "Polyhexanide"
	description = "A sterilizing agent designed for internal use. Powerful, but dangerous."
	color = COLOR_REAGENT_POLYHEXANIDE
	custom_metabolism = REAGENTS_METABOLISM * 2
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/polyhexanide/on_mob_life(mob/living/L, metabolism)
	switch(current_cycle)
		if(1 to 9)
			L.adjust_tox_loss(effect_str)
			L.adjust_drowsyness(5)
		if(10 to 50)
			L.adjust_tox_loss(1.25*effect_str)
			L.Sleeping(10 SECONDS)
		if(51 to INFINITY)
			L.adjust_tox_loss((current_cycle * 0.1 - 4.6)*effect_str) //why yes, the sleeping stops after it stops working. Yay screaming patients running off!
	return ..()

/datum/reagent/medicine/polyhexanide/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, TOX)

/datum/reagent/medicine/larvaway
	name = "Larvaway"
	description = "A proprietary blend of antibiotics and antifungal agents designed to inhibit the growth of xenomorph embryos. Builds up toxicity over time."
	color = COLOR_REAGENT_LARVAWAY
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5
	purge_list = list(/datum/reagent/medicine/xenojelly)
	purge_rate = 5

/datum/reagent/medicine/larvaway/on_mob_life(mob/living/L, metabolism)
	switch(current_cycle)
		if(1 to 100)
			L.adjust_tox_loss(0.5*effect_str)
			if(prob(25))
				L.adjust_stamina_loss(0.5*effect_str)
		if(101 to 200)
			L.adjust_tox_loss(effect_str)
			if(prob(25))
				L.adjust_stamina_loss(20*effect_str)
		if(201 to INFINITY)
			L.adjust_tox_loss(3*effect_str)
	return ..()

/datum/reagent/medicine/larvaway/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/larvaway/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, TOX)


/datum/reagent/medicine/ethylredoxrazine	// FUCK YOU, ALCOHOL
	name = "Ethylredoxrazine"
	description = "A powerful oxidizer that reacts with ethanol."
	reagent_state = SOLID
	color = COLOR_REAGENT_ETHYLREDOXRAZINE
	overdose_threshold = REAGENTS_OVERDOSE
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL

/datum/reagent/medicine/ethylredoxrazine/on_mob_life(mob/living/L, metabolism)
	L.dizzy(-1)
	L.adjust_drowsyness(-1)
	L.adjust_timed_status_effect(-2 SECONDS, /datum/status_effect/speech/stutter)
	L.AdjustConfused(-2 SECONDS)
	var/mob/living/carbon/C = L
	C.drunkenness = max(C.drunkenness-4, 0)
	L.reagents.remove_all_type(/datum/reagent/consumable/ethanol, 0.5*effect_str, 0, 1)
	return ..()

/datum/reagent/medicine/ethylredoxrazine/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str, TOX)

/datum/reagent/medicine/ethylredoxrazine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damage(2*effect_str, TOX)

/datum/reagent/hypervene // this isn't under /medicine so things that purge /datum/reagent/medicine like neuro/larval don't purge it
	name = "Hypervene"
	description = "Quickly purges the body of toxin damage, radiation and all other chemicals. Causes significant pain."
	color = COLOR_REAGENT_HYPERVENE
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5
	custom_metabolism = REAGENTS_METABOLISM * 5
	purge_list = list(
		/datum/reagent/medicine,
		/datum/reagent/toxin,
		/datum/reagent/zombium,
	)
	purge_rate = 5
	taste_description = "punishment"
	taste_multi = 8

/datum/reagent/hypervene/on_mob_life(mob/living/carbon/human/L, metabolism)
	L.reagent_shock_modifier -= PAIN_REDUCTION_HEAVY //Significant pain while metabolized.
	if(prob(5)) //causes vomiting
		L.vomit()
	return ..()

/datum/reagent/hypervene/overdose_process(mob/living/carbon/human/L, metabolism)
	L.apply_damages(effect_str, effect_str)
	if(prob(10)) //heavy vomiting
		L.vomit()
	L.reagent_shock_modifier -= PAIN_REDUCTION_VERY_HEAVY * 1.25//Massive pain.

/datum/reagent/hypervene/overdose_crit_process(mob/living/carbon/human/L, metabolism)
	L.apply_damages(2*effect_str, 2*effect_str)
	if(prob(50)) //violent vomiting
		L.vomit()
	L.reagent_shock_modifier -= PAIN_REDUCTION_VERY_HEAVY * 4 //Unlimited agony.


/datum/reagent/medicine/roulettium
	name = "Roulettium"
	description = "The concentrated essence of unga. Unsafe to ingest in any quantity"
	color = COLOR_REAGENT_ROULETTIUM
	custom_metabolism = REAGENTS_METABOLISM * 0.5
	taste_description = "Poor life choices"

/datum/reagent/medicine/roulettium/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier += PAIN_REDUCTION_VERY_HEAVY * 4
	L.adjust_tox_loss(-30*effect_str)
	L.heal_overall_damage(30*effect_str, 30*effect_str)
	L.adjust_stamina_loss(-30*effect_str)
	L.AdjustStun(-10 SECONDS)
	if(prob(5))
		L.adjust_brute_loss(1200*effect_str) //the big oof. No, it's not kill or gib, I want them to nugget.

/datum/reagent/medicine/lemoline
	name = "Lemoline"
	description = "A concentrated set of powders used to enhance other medicine in chemical recipes. Has no use on its own."
	reagent_state = LIQUID
	color = COLOR_REAGENT_LEMOLINE
	taste_description = "piss"

/datum/reagent/medicine/bihexajuline
	name = "Bihexajuline"
	description = "Accelerates natural bone repair in a low temperature environment. Causes severe pain."
	color = COLOR_REAGENT_BIHEXAJULINE
	taste_description = "skim milk"
	overdose_threshold = REAGENTS_OVERDOSE

/datum/reagent/medicine/bihexajuline/on_mob_life(mob/living/L, metabolism)
	. = ..()
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/host = L
	host.reagent_shock_modifier -= PAIN_REDUCTION_VERY_HEAVY //oof ow ouch
	if(host.bodytemperature < 170)
		for(var/datum/limb/limb_to_fix AS in host.limbs)
			if(limb_to_fix.limb_status & (LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED))
				if(!(prob(20) || limb_to_fix.brute_dam > limb_to_fix.min_broken_damage))
					continue //Once every 10s average while active, but guaranteed if the limb'll just break again so we get maximum crunchtube.
				limb_to_fix.remove_limb_flags(LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED)
				limb_to_fix.add_limb_flags(LIMB_REPAIRED)
				break

/datum/reagent/medicine/bihexajuline/overdose_process(mob/living/L, metabolism)
	if(!ishuman(L))
		return
	var/mob/living/carbon/human/host = L
	for(var/datum/limb/limb_to_unfix AS in host.limbs)
		if(limb_to_unfix.limb_status & (LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED | LIMB_DESTROYED | LIMB_AMPUTATED))
			continue
		if(prob(15))
			limb_to_unfix.fracture()
		break

/datum/reagent/medicine/research
	name = "Research precursor" //nothing with this subtype should be added to vendors
	taste_description = "bitterness"
	reagent_state = LIQUID
	taste_description = "bitterness"

/datum/reagent/medicine/research/quietus
	name = "Quietus"
	description = "This is a latent poison, designed to quickly and painlessly kill you in the event that you become unable to fight. Never washes out on it's own, must be purged."
	color = COLOR_REAGENT_QUIETUS
	custom_metabolism = 0
	taste_description = "Victory"

/datum/reagent/medicine/research/quietus/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel like this shot will negatively affect your revival prospects."))

/datum/reagent/medicine/research/quietus/on_mob_life(mob/living/L, metabolism)
	switch(current_cycle)
		if(1 to 59)
			L.adjust_stamina_loss(1*effect_str)
			if(prob(5))
				to_chat(L, span_notice("You feel weakened by a poison."))
		if(60)
			to_chat(L, span_warning("You feel the poison settle into your body."))
		if(61 to INFINITY)
			if(L.stat == UNCONSCIOUS)
				L.adjust_oxy_loss(25*effect_str)
				to_chat(L, span_userdanger("You fade into blackness as your lungs seize up!"))
			if(prob(5))
				L.adjust_stamina_loss(1*effect_str)
	return ..()

/datum/reagent/medicine/research/quietus/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_danger("You convulse as your body violently rejects the suicide drug!"))
	L.adjust_tox_loss(30*effect_str)



/datum/reagent/medicine/research/somolent
	name = "Somolent"
	description = "This is a highly potent regenerative drug, designed to heal critically injured personnel. Only functions on unconscious or sleeping people."
	color = COLOR_REAGENT_SOMOLENT
	overdose_threshold = REAGENTS_OVERDOSE
	taste_description = "naptime"

/datum/reagent/medicine/research/somolent/on_mob_life(mob/living/L, metabolism)
	switch(current_cycle)
		if(1 to 24)
			if(L.stat == UNCONSCIOUS)
				L.heal_overall_damage(0.4*current_cycle*effect_str, 0.4*current_cycle*effect_str)
			if(prob(20) && L.stat != UNCONSCIOUS)
				to_chat(L, span_notice("You feel as though you should be sleeping for the medicine to work."))
		if(25)
			to_chat(L, span_notice("You feel very sleepy all of a sudden."))
		if(26 to INFINITY)
			if(L.stat == UNCONSCIOUS)
				L.heal_overall_damage(10*effect_str, 10*effect_str)
				L.adjust_clone_loss(-0.2*effect_str-(0.02*(L.maxHealth - L.health)))
				holder.remove_reagent(/datum/reagent/medicine/research/somolent, 0.6)
			if(prob(50) && L.stat != UNCONSCIOUS)
				L.adjust_stamina_loss((current_cycle*0.75 - 14)*effect_str)
	return ..()

/datum/reagent/medicine/research/somolent/overdose_process(mob/living/L, metabolism)
	holder.remove_reagent(/datum/reagent/medicine/research/somolent, 1)

/datum/reagent/medicalnanites
	name = "Medical nanites"
	description = "These are a batch of construction nanites altered for in-vivo replication. They can heal wounds using the iron present in the bloodstream. Medical care is recommended during injection."
	color = COLOR_REAGENT_MEDICALNANITES
	custom_metabolism = 0
	taste_description = "metal, followed by mild burning"
	overdose_threshold = REAGENTS_OVERDOSE * 1.2 //slight buffer to keep you safe
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 1.7
	purge_rate = 5
	purge_list = list(
		/datum/reagent/medicine/bicaridine,
		/datum/reagent/medicine/kelotane,
		/datum/reagent/medicine/tramadol,
		/datum/reagent/medicine/tricordrazine,
		/datum/reagent/medicine/paracetamol,
		/datum/reagent/medicine/oxycodone,
		/datum/reagent/medicine/ifosfamide,
	)

/datum/reagent/medicalnanites/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel like you should stay near medical help until this shot settles in."))
	L.add_movespeed_modifier(MOVESPEED_ID_MOB_NANITES_SPEED, TRUE, 0, NONE, TRUE, 0.1)

/datum/reagent/medicalnanites/on_mob_life(mob/living/L, metabolism)
	switch(current_cycle)
		if(1 to 75)
			L.adjust_tox_loss(1*effect_str)
			L.adjust_stamina_loss((1.5)*effect_str)
			L.reagents.add_reagent(/datum/reagent/medicalnanites, 0.4)
			if(prob(5))
				to_chat(L, span_notice("You feel intense itching!"))
		if(76)
			to_chat(L, span_warning("The pain rapidly subsides. Looks like they've adapted to you."))
		if(77 to INFINITY)
			if(volume < 30) //smol injection will self-replicate up to 30u using 240u of blood.
				L.reagents.add_reagent(/datum/reagent/medicalnanites, 0.15)
				L.adjust_blood_volume(-2)

			if(volume < 35) //allows 10 ticks of healing for 20 points of free heal to lower scratch damage bloodloss amounts.
				L.reagents.add_reagent(/datum/reagent/medicalnanites, 0.1)

			//cuz we purge painkillers
			if(volume > 5)
				L.reagent_pain_modifier += PAIN_REDUCTION_HEAVY

			if (volume > 5 && L.get_brute_loss(organic_only = TRUE))
				L.heal_overall_damage(3 * effect_str, 0)
				L.adjust_tox_loss(0.1*effect_str)
				holder.remove_reagent(/datum/reagent/medicalnanites, 0.5)
				if(prob(40))
					to_chat(L, span_notice("Your cuts and bruises begin to scab over rapidly!"))

			if (volume > 5 && L.get_fire_loss(organic_only = TRUE))
				L.heal_overall_damage(0, 3 * effect_str)
				L.adjust_tox_loss(0.1*effect_str)
				holder.remove_reagent(/datum/reagent/medicalnanites, 0.5)
				if(prob(40))
					to_chat(L, span_notice("Your burns begin to slough off, revealing healthy tissue!"))

			if(volume < 10)
				return ..()

			if(!ishuman(L))
				return ..()
			var/mob/living/carbon/human/human = L

			if(prob(5))
				var/datum/internal_organ/organ = human.get_damaged_organ()
				if(!organ)
					return ..()
				L.adjust_tox_loss(10 * effect_str)
				holder.remove_reagent(/datum/reagent/medicalnanites, 5)
				organ.heal_organ_damage(10 * effect_str)
				return ..()

			if(prob(5))
				for(var/datum/limb/limb_to_fix AS in human.limbs)
					if(limb_to_fix.limb_status & (LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED))
						if(limb_to_fix.brute_dam > limb_to_fix.min_broken_damage)
							continue
						limb_to_fix.remove_limb_flags(LIMB_BROKEN | LIMB_SPLINTED | LIMB_STABILIZED)
						limb_to_fix.add_limb_flags(LIMB_REPAIRED)
						holder.remove_reagent(/datum/reagent/medicalnanites, 5)
						L.adjust_tox_loss(15 * effect_str)
						break
	return ..()

/datum/reagent/medicalnanites/overdose_process(mob/living/L, metabolism)
	L.adjust_tox_loss(effect_str) //softcap VS injecting massive amounts of medical nanites for the healing factor with no downsides. Still doable if you're clever about it.
	holder.remove_reagent(/datum/reagent/medicalnanites, 0.25)

/datum/reagent/medicalnanites/overdose_crit_process(mob/living/L, metabolism)
	L.adjust_clone_loss(1) //YUM!
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		var/datum/internal_organ/stom = H.get_organ_slot(ORGAN_SLOT_STOMACH)
		stom.take_damage(0.7 * effect_str)

/datum/reagent/medicalnanites/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("Your nanites have been fully purged! They no longer affect you."))
	L.remove_movespeed_modifier(MOVESPEED_ID_MOB_NANITES_SPEED)

/datum/reagent/medicine/research/stimulon
	name = "Stimulon"
	description = "A chemical designed to boost running by driving your body beyond it's normal limits. Can have unpredictable side effects, caution recommended."
	color = COLOR_REAGENT_STIMULON
	custom_metabolism = 0

/datum/reagent/medicine/research/stimulon/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel jittery and fast! Time to MOVE!"))
	. = ..()
	L.add_movespeed_modifier(type, TRUE, 0, NONE, TRUE, -1)
	L.adjust_clone_loss(10*effect_str)

/datum/reagent/medicine/research/stimulon/on_mob_delete(mob/living/L, metabolism)
	L.remove_movespeed_modifier(type)
	L.Paralyze(2 SECONDS)
	to_chat(L, span_warning("You reel as the stimulant departs your bloodstream!"))

/datum/reagent/medicine/research/stimulon/on_mob_life(mob/living/L, metabolism)
	L.adjust_stamina_loss(1*effect_str)
	L.take_limb_damage(randfloat(0.5 * effect_str, 4 * effect_str), 0)
	L.adjust_clone_loss(rand(0, 5) * effect_str * current_cycle * 0.02)
	if(prob(20))
		L.emote(pick("twitch","blink_r","shiver"))
	if(volume < 100) //THERE IS NO "MINIMUM SAFE DOSE" MUAHAHAHA!
		L.reagents.add_reagent(/datum/reagent/medicine/research/stimulon, 0.5)
	switch(current_cycle)
		if(20)//avg cloneloss of 1/tick and 10 additional units made
			to_chat(L, span_userdanger("You start to ache and cramp as your muscles wear out. You should probably remove this drug soon."))
		if (21 to INFINITY)
			L.jitter(5)
	return ..()

/datum/reagent/medicine/sulfasalazine
	name = "sulfasalazine"
	description = "Sulfasalazine, a self-restoring agent that has great healing effects at the cost of purging all the other reagents."
	color = COLOR_REAGENT_SULFASALAZINE
	custom_metabolism = 0
	purge_rate = 5
	var/absorbtion = 0
	var/max_absorbtion = 10
	var/max_reagent = 50

/datum/reagent/medicine/sulfasalazine/on_mob_life(mob/living/L, metabolism)
	if(absorbtion > 0 && volume < max_reagent)
		L.reagents.add_reagent(/datum/reagent/medicine/sulfasalazine, 3.5)

	if(absorbtion > 0)
		absorbtion--

	if (volume > 5 && L.get_brute_loss(organic_only = TRUE) && absorbtion <= 0)
		L.heal_overall_damage(4*effect_str, 0)
		holder.remove_reagent(/datum/reagent/medicine/sulfasalazine, 3.5)

	if (volume > 5 && L.get_fire_loss(organic_only = TRUE) && absorbtion <= 0)
		L.heal_overall_damage(0, 4*effect_str)
		holder.remove_reagent(/datum/reagent/medicine/sulfasalazine, 3.5)

	for(var/datum/reagent/R in L.reagents.reagent_list)
		//we dont purge themself
		if(R.type != /datum/reagent/medicine/sulfasalazine)
			var/purge = min(R.volume, purge_rate)
			L.reagents.remove_reagent(R.type, purge)
			absorbtion = min(absorbtion + purge, max_absorbtion)

	return ..()

/datum/reagent/histamine
	name = "Histamine"
	description = "Histamine is an organic nitrogenous compound involved in local immune responses communication"
	color = COLOR_REAGENT_BICARIDINE
	custom_metabolism = 0.4
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5
	purge_list = list(
		/datum/reagent/medicine/bicaridine,
		/datum/reagent/medicine/kelotane,
		/datum/reagent/medicine/tricordrazine,
		/datum/reagent/medicine/paracetamol,
	)
	purge_rate = 5

/datum/reagent/histamine/on_mob_life(mob/living/L, metabolism)
	if(!L.reagents.get_reagent_amount(/datum/reagent/medicine/ifosfamide))
		holder.remove_reagent(/datum/reagent/histamine, custom_metabolism * L.metabolism_efficiency)

	L.apply_damage(0.5*effect_str, OXY)

	purge(L)
	current_cycle++
	return TRUE

/datum/reagent/histamine/on_mob_add(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel your throat tightening!"))

/datum/reagent/histamine/on_mob_delete(mob/living/L, metabolism)
	to_chat(L, span_userdanger("You feel how it becomes easier for you to breathe."))

/datum/reagent/histamine/overdose_process(mob/living/L, metabolism)
	L.apply_damages(1 * effect_str, 1 * effect_str, 1 * effect_str)

/datum/reagent/histamine/overdose_crit_process(mob/living/L, metabolism)
	L.apply_damages(0, 0, 6 * effect_str)

/datum/reagent/medicine/ifosfamide
	name = "ifosfamide"
	description = "Ifosfamide is a cytostatic antitumor drug."
	color = COLOR_REAGENT_BICARIDINE
	custom_metabolism = REAGENTS_METABOLISM * 2
	overdose_threshold = REAGENTS_OVERDOSE * 0.5
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL * 0.5

/datum/reagent/medicine/ifosfamide/on_mob_life(mob/living/L, metabolism)

	L.adjust_oxy_loss(-0.5 * effect_str)
	L.adjust_tox_loss(-0.5 * effect_str)
	L.heal_overall_damage(4 * effect_str, 4 * effect_str)

	if(volume > 5)
		L.reagent_pain_modifier -= PAIN_REDUCTION_MEDIUM
	else
		L.reagent_pain_modifier -= PAIN_REDUCTION_LIGHT

	L.reagents.add_reagent(/datum/reagent/histamine, 0.4)

	return ..()

/datum/reagent/medicine/ifosfamide/overdose_process(mob/living/L, metabolism)
	L.adjust_tox_loss(2*effect_str)

/datum/reagent/medicine/ifosfamide/overdose_crit_process(mob/living/L, metabolism)
	L.adjust_tox_loss(4*effect_str)


/datum/reagent/medicine/regrow
	name = "Re-grow"
	description = "Re-grow is rare and unusual drug that stimulates the rapid (and horrifically painful) regeneration of missing limbs."
	color = COLOR_REAGENT_SYNAPTIZINE
	overdose_threshold = REAGENTS_OVERDOSE*0.2
	overdose_crit_threshold = REAGENTS_OVERDOSE_CRITICAL*0.2
	custom_metabolism = REAGENTS_METABOLISM * 5

/datum/reagent/medicine/regrow/on_mob_add(mob/living/L, metabolism)
	if(volume < 5 || L.stat == DEAD || (!ishuman(L)))
		return
	var/mob/living/carbon/human/human = L
	var/limb_regrown = FALSE
	for(var/datum/limb/limb AS in human.limbs)
		if(!(limb.limb_status & LIMB_DESTROYED))
			continue
		limb_regrown = TRUE
		limb.biotize()
		to_chat(human, span_userdanger("You feel unbelievable pain as your [limb.display_name] regrows before your eyes!"))
		human.jitter(10)
		human.Paralyze(1 SECONDS)
		human.adjust_stamina_loss(20)
	if(!limb_regrown)
		return
	human.emote("burstscream")
	human.update_body()
	human.update_health()
	human.UpdateDamageIcon()

/datum/reagent/medicine/regrow/on_mob_life(mob/living/L, metabolism)
	L.reagent_shock_modifier -= PAIN_REDUCTION_SUPER_HEAVY
	L.adjust_tox_loss(effect_str * 2)
	return ..()

/datum/reagent/medicine/regrow/overdose_process(mob/living/L, metabolism)
	L.apply_damage(effect_str * 4, TOX)

/datum/reagent/medicine/regrow/overdose_crit_process(mob/living/L, metabolism)
	L.reagent_shock_modifier -= PAIN_REDUCTION_SUPER_HEAVY
	L.apply_damages(effect_str, effect_str, effect_str * 4)
