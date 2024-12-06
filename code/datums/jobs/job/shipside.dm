/datum/job/terragov/command
	job_category = JOB_CAT_COMMAND
	selection_color = "#ddddff"
	supervisors = "the acting captain"
	exp_type_department = EXP_TYPE_COMMAND

//Captain
/datum/job/terragov/command/captain
	title = CAPTAIN
	req_admin_notify = TRUE
	paygrade = "O6"
	comm_title = "CPT"
	supervisors = "TGMC high command"
	selection_color = "#ccccff"
	total_positions = 1
	skills_type = /datum/skills/captain
	access = ALL_MARINE_ACCESS
	minimal_access = ALL_MARINE_ACCESS
	display_order = JOB_DISPLAY_ORDER_CAPTAIN
	outfit = /datum/outfit/job/command/captain
	exp_type = EXP_TYPE_COMMAND
	exp_requirements = XP_REQ_INTERMEDIATE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to</b> TGMC High Command<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Lead the TGMC platoon and complete your mission. Support the marines and communicate with your command staff, execute orders.
	"}
	minimap_icon = "captain"

/datum/job/terragov/command/captain/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"As the captain of the [SSmapping.configs[SHIP_MAP].map_name] you are held by higher standard and are expected to act competently.
While you may support Nanotrasen, you report to the TGMC High Command, not the corporate office.
Your primary task is the safety of the ship and her crew, and ensuring the survival and success of the marines.
Your first order of business should be briefing the marines on the mission they are about to undertake.
You should not be voluntarily leaving your vessel under any circumstances. A captain goes down with their ship.
If you require any help, use <b>mentorhelp</b> to ask mentors about what you're supposed to do.
Godspeed, captain! And remember, you are not above the law."})

/datum/job/terragov/command/captain/after_spawn(mob/living/new_mob, mob/user, latejoin)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	new_human.dropItemToGround(new_human.head)
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "O6"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/captain/black, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red, SLOT_BACK)
		if(1501 to 3000) // 25hrs
			new_human.wear_id.paygrade = "O7"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/captain/black, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red, SLOT_BACK)
		if(3001 to 4500) //50 hrs
			new_human.wear_id.paygrade = "O8"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/captain, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red/white, SLOT_BACK)
		if(4501 to INFINITY) //75 hrs
			new_human.wear_id.paygrade = "O9"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/captain, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/captain_cloak_red/white, SLOT_BACK)

/datum/outfit/job/command/captain
	name = CAPTAIN
	jobtype = /datum/job/terragov/command/captain

	id = /obj/item/card/id/gold
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/command
	shoes = /obj/item/clothing/shoes/marinechief/captain
	gloves = /obj/item/clothing/gloves/marine/techofficer/captain
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/leadership
	belt = /obj/item/storage/holster/blade/officer/sabre/full
	glasses = /obj/item/clothing/glasses/sunglasses/aviator/yellow
	head = null
	back = FALSE

//Field Commander
/datum/job/terragov/command/fieldcommander
	title = FIELD_COMMANDER
	req_admin_notify = TRUE
	paygrade = "O3"
	comm_title = "FCDR"
	total_positions = 1
	skills_type = /datum/skills/fo
	access = ALL_MARINE_ACCESS
	minimal_access = ALL_MARINE_ACCESS
	display_order = JOB_DISPLAY_ORDER_EXECUTIVE_OFFICER
	outfit = /datum/outfit/job/command/fieldcommander
	exp_type = EXP_TYPE_COMMAND
	exp_requirements = XP_REQ_UNSEASONED
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> Captain<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Lead your platoon on the field. Take advantage of the military staff and assets you will need for the mission, keep good relations between command and the marines. Assist the captain if available.
	"}
	minimap_icon = "fieldcommander"

/datum/job/terragov/command/fieldcommander/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are charged with overseeing the operation on the ground, and are the highest-ranked deployed marine.
Your duties are to ensure marines hold when ordered, and push when they are cowering behind barricades.
Do not ask your men to do anything you would not do side by side with them.
Make the TGMC proud!"})

/datum/job/terragov/command/fieldcommander/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	SSdirection.set_leader(TRACKING_ID_MARINE_COMMANDER, new_mob)
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) //starting
			new_human.wear_id.paygrade = "O3"
		if(1500 to 7500) // 25 hrs
			new_human.wear_id.paygrade = "MO4"
		if(7501 to INFINITY) // 125 hrs
			new_human.wear_id.paygrade = "MO5"


/datum/outfit/job/command/fieldcommander
	name = FIELD_COMMANDER
	jobtype = /datum/job/terragov/command/fieldcommander

	id = /obj/item/card/id/dogtag/fc
	belt = /obj/item/storage/holster/blade/officer/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/exec
	wear_suit = /obj/item/clothing/suit/modular/xenonauten
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine/officer
	head = /obj/item/clothing/head/tgmcberet/fc
	r_store = /obj/item/storage/pouch/general/large/command
	l_store = /obj/item/hud_tablet/fieldcommand
	suit_store = /obj/item/storage/holster/belt/pistol/m4a3/fieldcommander

//Staff Officer
/datum/job/terragov/command/staffofficer
	title = STAFF_OFFICER
	paygrade = "O3"
	comm_title = "SO"
	total_positions = 4
	access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_BRIG, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_ALPHA, ACCESS_MARINE_BRAVO, ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DELTA)
	minimal_access = ALL_MARINE_ACCESS
	skills_type = /datum/skills/so
	display_order = JOB_DISPLAY_ORDER_STAFF_OFFICER
	outfit = /datum/outfit/job/command/staffofficer
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Captain<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Take charge of one of the four squads, be their eyes and ears providing intel and additional shipside support via Orbital Bombardments.
	"}

	minimap_icon = "staffofficer"

/datum/job/terragov/command/staffofficer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to monitor the marines, man the CIC, and listen to your superior officers.
You are in charge of logistics and the overwatch system. You are also in line to take command after the captain."})

/datum/job/terragov/command/staffofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	new_human.dropItemToGround(new_human.head)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "O3"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/beret/marine/staff, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/officer_cloak_red, SLOT_BACK)
		if(1501 to 3000) // 25 hrs
			new_human.wear_id.paygrade = "O4"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/staff, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/officer_cloak_red, SLOT_BACK)
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "O5"
			new_human.equip_to_slot_or_del(new /obj/item/clothing/head/highcap/staff, SLOT_HEAD)
			new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/satchel/officer_cloak_red/alt, SLOT_BACK)

/datum/outfit/job/command/staffofficer
	name = STAFF_OFFICER
	jobtype = /datum/job/terragov/command/staffofficer

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/pistol/m4a3/officer
	ears = /obj/item/radio/headset/mainship/mcom
	r_store = /obj/item/storage/pouch/general/large
	l_store = /obj/item/binoculars/tactical
	back = FALSE
	head = null
	w_uniform = /obj/item/clothing/under/marine/whites/blacks
	shoes = /obj/item/clothing/shoes/laceup

//Transport Officer
/datum/job/terragov/command/transportofficer
	title = TRANSPORT_OFFICER
	paygrade = "WO"
	comm_title = "TO"
	total_positions = 1
	access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT, ACCESS_MARINE_TADPOLE)
	minimal_access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT, ACCESS_MARINE_TADPOLE, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	skills_type = /datum/skills/transportofficer
	display_order = JOB_DISPLAY_ORDER_TRANSPORT_OFFICER
	outfit = /datum/outfit/job/command/transportofficer
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE_STRONG,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: 100 hours<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Pilot the Tadpole, a versatile dropship capable of fulfilling roles ranging from ambulance to mobile bunker.
	"}
	minimap_icon = "transportofficer"

/datum/job/terragov/command/transportofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "WO"
		if(601 to 3000) // 10 hrs
			new_human.wear_id.paygrade = "CWO"
		if(3001 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "O1"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "O2"

/datum/job/terragov/command/transportofficer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to support marines mobile dropship support with the Tadpole.
You are to ensure the Tadpole's survival and to transport marines around, acting as a mobile bunker. In the case of it's death, you may perform the role of Combat Engineer.
"})

/datum/outfit/job/command/transportofficer
	name = TRANSPORT_OFFICER
	jobtype = /datum/job/terragov/command/transportofficer

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/pilot
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/pilot
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine/insulated
	glasses = /obj/item/clothing/glasses/welding/superior
	head = /obj/item/clothing/head/helmet/marine/pilot
	r_store = /obj/item/storage/pouch/construction
	l_store = /obj/item/hud_tablet/transportofficer
	back = /obj/item/storage/backpack/marine/engineerpack
	suit_store = /obj/item/storage/holster/belt/pistol/m4a3/vp70

/datum/outfit/job/command/transportofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/stack/sheet/metal/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/stack/sheet/plasteel/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/stack/sandbags/large_stack, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/stack/barbed_wire/full, SLOT_IN_R_POUCH)

//Pilot Officer
/datum/job/terragov/command/pilot
	title = PILOT_OFFICER
	paygrade = "WO"
	comm_title = "PO"
	total_positions = 1
	access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT)
	minimal_access = list(ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_PILOT, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_MEDBAY)
	skills_type = /datum/skills/pilot
	display_order = JOB_DISPLAY_ORDER_PILOT_OFFICER
	outfit = /datum/outfit/job/command/pilot
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE_STRONG,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Pilot the Condor, a modular attack aircraft that provides close air support with a variety of weapons ranging from the inbuilt gatling to wing mounted rockets.
	"}
	minimap_icon = "pilot"

/datum/job/terragov/command/pilot/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "WO"
		if(601 to 3000) // 10 hrs
			new_human.wear_id.paygrade = "CWO"
		if(3001 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "O1"
		if(6001 to 9000) // 100 hrs
			new_human.wear_id.paygrade = "O2"
		if(9001 to 15000) // 150 hrs
			new_human.wear_id.paygrade = "O3"
		if(15001 to 18000) // 250 hrs
			new_human.wear_id.paygrade = "O4"
		if(18001 to INFINITY) // 300 hrs
			new_human.wear_id.paygrade = "O4"

/datum/job/terragov/command/pilot/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to support marines with either close air support via the Condor.
You are expected to use the Condor as the Alamo is able to be ran automatically, though at some points you will be required to take control of the Alamo for the operation's success, though highly unlikey.
Though you are a warrant officer, your authority is limited to the dropship and the Condor, where you have authority over the enlisted personnel.
"})

/datum/outfit/job/command/pilot
	name = PILOT_OFFICER
	jobtype = /datum/job/terragov/command/pilot

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/pistol/m4a3/vp70
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/pilot
	wear_suit = /obj/item/clothing/suit/modular/xenonauten/pilot
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/insulated
	glasses = /obj/item/clothing/glasses/sunglasses/aviator
	head = /obj/item/clothing/head/helmet/marine/pilot
	r_store = /obj/item/clothing/glasses/night/imager_goggles
	l_store = /obj/item/hud_tablet/pilot

//Mech pilot
/datum/job/terragov/command/mech_pilot
	title = MECH_PILOT
	req_admin_notify = TRUE
	paygrade = "E3"
	comm_title = "MCH"
	total_positions = 0
	skills_type = /datum/skills/mech_pilot
	access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_MECH, ACCESS_CIVILIAN_PUBLIC)
	minimal_access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_MECH, ACCESS_CIVILIAN_PUBLIC, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO)
	display_order = JOB_DISPLAY_ORDER_MECH_PILOT
	outfit = /datum/outfit/job/command/mech_pilot
	exp_type = EXP_TYPE_MARINES
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	job_points_needed = 80
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Act as the spearhead of the operation
	"}
	minimap_icon = "mech_pilot"

/datum/job/terragov/command/mech_pilot/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"\nYou are the operator of a very expensive and valuable Mech, and are trained and expected to use it in the field of combat.
You can serve your Division in a variety of roles, so choose carefully."})

/datum/job/terragov/command/mech_pilot/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) //starting
			new_human.wear_id.paygrade = "E3"
		if(1500 to 7500) // 25 hrs
			new_human.wear_id.paygrade = "E4"
		if(7501 to INFINITY) // 125 hrs
			new_human.wear_id.paygrade = "E5"

/datum/outfit/job/command/mech_pilot
	name = MECH_PILOT
	jobtype = /datum/job/terragov/command/mech_pilot

	id = /obj/item/card/id/dogtag
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/mech
	wear_suit = /obj/item/clothing/suit/storage/marine/mech_pilot
	head = /obj/item/clothing/head/helmet/marine/mech_pilot
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine

//apc/jeep driver
/datum/job/terragov/command/transport_crewman
	title = TRANSPORT_CREWMAN
	req_admin_notify = TRUE
	paygrade = "E3"
	comm_title = "TC"
	total_positions = 0
	skills_type = /datum/skills/transport_crewman
	access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_ARMORED, ACCESS_CIVILIAN_PUBLIC)
	minimal_access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_ARMORED, ACCESS_CIVILIAN_PUBLIC, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO)
	display_order = JOB_DISPLAY_ORDER_MECH_PILOT
	outfit = /datum/outfit/job/command/transport_crewman
	exp_requirements = XP_REQ_MASTER
	exp_type = EXP_TYPE_MARINES
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	job_points_needed = 40
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Transport and support the frontline troops
	"}
	minimap_icon = "transport_crew"

/datum/job/terragov/command/transport_crewman/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a Transport Crewman. You operate the TGMC's transport vehciles to ensure that marines and equipment gets to the front in a timely and safe manner."})

/datum/job/terragov/command/transport_crewman/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "E3"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "E4"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "E5"
		if(18001 to 60000) // 300 hrs
			new_human.wear_id.paygrade = "E6"
		if(60001 to INFINITY) // 1000 hrs
			new_human.wear_id.paygrade = "E9A" //If you play way too much TGMC. 1000 hours.

/datum/outfit/job/command/transport_crewman
	name = TRANSPORT_CREWMAN
	jobtype = /datum/job/terragov/command/transport_crewman

	id = /obj/item/card/id/dogtag
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/transport_crewman
	wear_suit = /obj/item/clothing/suit/storage/marine/transport_crewman
	head = /obj/item/clothing/head/helmet/marine/transport_crewman
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine

//tank/arty driver+gunner
/datum/job/terragov/command/assault_crewman
	title = ASSAULT_CREWMAN
	req_admin_notify = TRUE
	paygrade = "E3"
	comm_title = "AC"
	total_positions = 0
	skills_type = /datum/skills/assault_crewman
	access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_ARMORED, ACCESS_CIVILIAN_PUBLIC)
	minimal_access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_ARMORED, ACCESS_CIVILIAN_PUBLIC, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO)
	display_order = JOB_DISPLAY_ORDER_MECH_PILOT
	outfit = /datum/outfit/job/command/assault_crewman
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	exp_type = EXP_TYPE_MARINES
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	job_points_needed = 999 //50
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Provide heavy fire support
	"}
	minimap_icon = "assault_crew"

/datum/job/terragov/command/assault_crewman/add_job_points(amount)
	. = ..()
	if(total_positions % 2)
		add_job_positions(1) //always 2 there are, a master and an apprentice

/datum/job/terragov/command/assault_crewman/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are an Assault Crewman. You operate the TGMC's armored assault vehicles along with your partner, and in some cases a \"willing\" loader. Make sure that you work as a team to advance the front!"})

/datum/job/terragov/command/assault_crewman/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "E3"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "E4"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "E5"
		if(18001 to 60000) // 300 hrs
			new_human.wear_id.paygrade = "E6"
		if(60001 to INFINITY) // 1000 hrs
			new_human.wear_id.paygrade = "E9A" //If you play way too much TGMC. 1000 hours.

/datum/outfit/job/command/assault_crewman
	name = ASSAULT_CREWMAN
	jobtype = /datum/job/terragov/command/assault_crewman

	id = /obj/item/card/id/dogtag
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/assault_crewman
	wear_suit = /obj/item/clothing/suit/storage/marine/assault_crewman
	head = /obj/item/clothing/head/helmet/marine/assault_crewman
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine
	l_store = /obj/item/pamphlet/tank_loader

//apc/jeep driver
/datum/job/terragov/command/transport_crewman
	title = TRANSPORT_CREWMAN
	req_admin_notify = TRUE
	paygrade = "E3"
	comm_title = "TC"
	total_positions = 0
	skills_type = /datum/skills/transport_crewman
	access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_ARMORED, ACCESS_CIVILIAN_PUBLIC)
	minimal_access = list(ACCESS_MARINE_WO, ACCESS_MARINE_PREP, ACCESS_MARINE_ARMORED, ACCESS_CIVILIAN_PUBLIC, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO)
	display_order = JOB_DISPLAY_ORDER_MECH_PILOT
	outfit = /datum/outfit/job/command/transport_crewman
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	exp_type = EXP_TYPE_MARINES
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	job_points_needed = 40
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_REGULAR,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>:Very Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Transport and support the frontline troops
	"}
	minimap_icon = "transport_crew"

/datum/job/terragov/command/transport_crewman/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a Transport Crewman. You operate the TGMC's transport vehciles to ensure that marines and equipment gets to the front in a timely and safe manner."})

/datum/job/terragov/command/transport_crewman/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 1500) // starting
			new_human.wear_id.paygrade = "E3"
		if(1501 to 6000) // 25 hrs
			new_human.wear_id.paygrade = "E4"
		if(6001 to 18000) // 100 hrs
			new_human.wear_id.paygrade = "E5"
		if(18001 to 60000) // 300 hrs
			new_human.wear_id.paygrade = "E6"
		if(60001 to INFINITY) // 1000 hrs
			new_human.wear_id.paygrade = "E9A" //If you play way too much TGMC. 1000 hours.

/datum/outfit/job/command/transport_crewman
	name = TRANSPORT_CREWMAN
	jobtype = /datum/job/terragov/command/transport_crewman

	id = /obj/item/card/id/dogtag
	belt = /obj/item/storage/belt/utility/full
	glasses = /obj/item/clothing/glasses/welding
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/transport_crewman
	wear_suit = /obj/item/clothing/suit/storage/marine/transport_crewman
	head = /obj/item/clothing/head/helmet/marine/transport_crewman
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/marine

//Ship Engineer
/datum/job/terragov/requisitions/tech
	title = SHIP_TECH
	comm_title = "ST"
	paygrade = "PO3"
	total_positions = 5
	supervisors = "the requisitions officer"
	access = list(ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_PREP, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CARGO, ACCESS_CIVILIAN_ENGINEERING)
	minimal_access = list(ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_PREP, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_CARGO, ACCESS_CIVILIAN_ENGINEERING)
	skills_type = /datum/skills/st
	display_order = JOB_DISPLAY_ORDER_SHIP_TECH
	outfit = /datum/outfit/job/requisitions/tech
	exp_type = EXP_TYPE_MARINES
	exp_requirements = XP_REQ_NOVICE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Requisitions Officer<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Maintain the ship, be in charge of the engines. Be the secondary engineer to a forward operating base, prepare the shipside defenses if needed. Help the Pilot Officer in preparing the dropship.
	"}
	minimap_icon = "st"

/datum/job/terragov/requisitions/tech/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "PO3"
		if(601 to 3000) // 10 hrs
			new_human.wear_id.paygrade = "PO2"
		if(3001 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "PO1"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "CPO"

/datum/job/terragov/requisitions/tech/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to make sure the ship is operational, you should firstly focus on manning the
requisitions line and later on to be ready to send supplies for marines who are groundside."})


/datum/outfit/job/requisitions/tech
	name = SHIP_TECH
	jobtype = /datum/job/terragov/requisitions/tech

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/st
	w_uniform = /obj/item/clothing/under/marine/officer/engi
	wear_suit = /obj/item/clothing/suit/storage/marine/ship_tech
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/insulated
	glasses = /obj/item/clothing/glasses/welding/flipped
	head = /obj/item/clothing/head/tgmccap/req
	r_store = /obj/item/storage/pouch/general/medium
	back = /obj/item/storage/backpack/marine/engineerpack

/datum/job/terragov/requisitions
	job_category = JOB_CAT_REQUISITIONS
	selection_color = "#BAAFD9"
	supervisors = "the acting captain"
	exp_type_department = EXP_TYPE_REQUISITIONS


//Requisitions Officer
/datum/job/terragov/requisitions/officer
	title = REQUISITIONS_OFFICER
	req_admin_notify = TRUE
	paygrade = "CPO"
	comm_title = "RO"
	selection_color = "#9990B2"
	total_positions = 1
	access = list(ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_PREP, ACCESS_MARINE_ALPHA, ACCESS_MARINE_BRAVO, ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DELTA)
	minimal_access = list(ACCESS_MARINE_CARGO, ACCESS_MARINE_RO, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_PREP, ACCESS_MARINE_ALPHA, ACCESS_MARINE_BRAVO, ACCESS_MARINE_CHARLIE, ACCESS_MARINE_DELTA, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS)
	skills_type = /datum/skills/ro
	display_order = JOB_DISPLAY_ORDER_REQUISITIONS_OFFICER
	outfit = /datum/outfit/job/requisitions/officer
	exp_type = EXP_TYPE_ENGINEERING
	exp_requirements = XP_REQ_UNSEASONED
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		Requisition supplies to the battlefield. Ensure that the marines are reparing miners for more points. Supply the marines with deluxe equipment to ensure success.
	"}
	minimap_icon = "requisition"


/datum/job/terragov/requisitions/officer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // starting
			new_human.wear_id.paygrade = "CPO"
		if(601 to 1500) // 10 hrs
			new_human.wear_id.paygrade = "WO"
		if(1501 to 6000) // 50 hrs
			new_human.wear_id.paygrade = "CWO"
		if(6001 to INFINITY) // 100 hrs
			new_human.wear_id.paygrade = "O1"

/datum/job/terragov/requisitions/officer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your job is to dispense supplies to the marines, including weapon attachments.
While you may request paperwork for supplies, do not go out of your way to screw with marines, unless you want to get deposed.
A happy ship is a well-functioning ship."})


/datum/outfit/job/requisitions/officer
	name = REQUISITIONS_OFFICER
	jobtype = /datum/job/terragov/requisitions/officer

	id = /obj/item/card/id/silver
	belt = /obj/item/storage/holster/belt/revolver/m44/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/marine/officer/ro_suit
	wear_suit = /obj/item/clothing/suit/storage/marine/officer/req
	suit_store = /obj/item/weapon/gun/energy/taser
	shoes = /obj/item/clothing/shoes/marine/full
	gloves = /obj/item/clothing/gloves/insulated
	head = /obj/item/clothing/head/tgmccap/req
	r_store = /obj/item/storage/pouch/general/large

/datum/job/terragov/medical
	job_category = JOB_CAT_MEDICAL
	selection_color = "#BBFFBB"
	exp_type_department = EXP_TYPE_MEDICAL


/datum/job/terragov/medical/professor
	title = CHIEF_MEDICAL_OFFICER
	req_admin_notify = TRUE
	comm_title = "CMO"
	paygrade = "CHO"
	total_positions = 1
	supervisors = "the acting captain"
	selection_color = "#99FF99"
	access = list(ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_CMO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_CHEMISTRY)
	minimal_access = list(ACCESS_MARINE_CMO, ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_LOGISTICS)
	skills_type = /datum/skills/cmo
	display_order = JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER
	outfit = /datum/outfit/job/medical/professor
	exp_type = EXP_TYPE_MEDICAL
	exp_requirements = XP_REQ_INTERMEDIATE
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard<br /><br />
		<b>You answer to the</b> acting Command Staff<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Communicate and lead your fellow medical staff (if available), supervise the medical department. Coordinate and teach fellow medical staff and corpsmen what they’re doing for treating an injury. Be the sole doctor in the Canterbury.
	"}
	minimap_icon = "chief_medical"


/datum/job/terragov/medical/professor/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are the chief medical officer aboard the [SSmapping.configs[SHIP_MAP].map_name] and supervisor to the medical department.
You have final authority over the medical department, medications, and treatments.
Make sure that the doctors and nurses are doing their jobs and keeping the marines healthy and strong."})

/datum/job/terragov/medical/professor/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "CHO"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "CMO"

/datum/outfit/job/medical/professor
	name = CHIEF_MEDICAL_OFFICER
	jobtype = /datum/job/terragov/medical/professor

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/medical
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/rank/medical/blue
	wear_suit = /obj/item/clothing/suit/storage/labcoat/cmo
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	head = /obj/item/clothing/head/cmo
	r_store = /obj/item/storage/pouch/surgery
	l_store = /obj/item/storage/pouch/medkit/medic

/datum/outfit/job/medical/professor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/tweezers, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_S_STORE)

//Medical Officer
/datum/job/terragov/medical/medicalofficer
	title = MEDICAL_DOCTOR
	comm_title = "MD"
	paygrade = "RES"
	total_positions = 4
	supervisors = "the chief medical officer"
	access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY)
	minimal_access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP)
	skills_type = /datum/skills/doctor
	display_order = JOB_DISPLAY_ORDER_DOCTOR
	outfit = /datum/outfit/job/medical/medicalofficer
	exp_type = EXP_TYPE_MARINES
	exp_requirements = XP_REQ_UNSEASONED
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Chief Medical Officer<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Tend severely wounded patients to your aid in the form of surgery, repair broken bones and damaged organs, fix internal bleeding and prevent the birth of a xenomorph larva. Develop superior healing medicines.
	"}
	minimap_icon = "medical"

/datum/job/terragov/medical/medicalofficer/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "RES"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "MD"

/datum/job/terragov/medical/medicalofficer/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a doctor stationed aboard the [SSmapping.configs[SHIP_MAP].map_name].
You are tasked with keeping the marines healthy and strong, usually in the form of surgery.
You are also an expert when it comes to medication and treatment. If you do not know what you are doing, <b>mentorhelp</b> so a mentor can assist you."})


/datum/outfit/job/medical/medicalofficer
	name = MEDICAL_DOCTOR
	jobtype = /datum/job/terragov/medical/medicalofficer

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/medical
	ears = /obj/item/radio/headset/mainship/doc
	w_uniform = /obj/item/clothing/under/rank/medical
	wear_suit = /obj/item/clothing/suit/storage/labcoat
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	head = /obj/item/clothing/head/surgery/green
	r_store = /obj/item/storage/pouch/surgery
	l_store = /obj/item/storage/pouch/medkit/medic

/datum/outfit/job/medical/medicalofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/tweezers, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_S_STORE)


//Researcher
/datum/job/terragov/medical/researcher
	title = FIELD_RESEARCHER
	comm_title = "Rsr"
	paygrade = "CD"
	total_positions = 2
	supervisors = "the NT corporate office"
	access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_ENGINEERING, ACCESS_CIVILIAN_ENGINEERING)
	minimal_access = list(ACCESS_MARINE_MEDBAY, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_CHEMISTRY, ACCESS_MARINE_CARGO, ACCESS_MARINE_DROPSHIP)
	skills_type = /datum/skills/researcher
	display_order = JOB_DISPLAY_ORDER_FIELD_RESEARCHER
	outfit = /datum/outfit/job/medical/researcher
	exp_type = EXP_TYPE_MEDICAL
	exp_requirements = XP_REQ_UNSEASONED
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ALLOWS_PREFS_GEAR|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Medium<br /><br />
		<b>You answer to the</b> Nanotrasen Corporate Office<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Research extraterrestrial life aboard the ship if provided by Nanotrasen/TerraGov, synthesize chemicals for the benefit of the marines. Find out the cause of why and when. Learn new things for humankind. Act as a secondary medical officer in practice.
	"}
	minimap_icon = "researcher"


/datum/job/terragov/medical/researcher/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"You are a civilian, working for the Nanotrasen Corporation, but you are still subject to the military chain of command.
You are tasked with deploying with the marines and researching the remains of the colony to get funding for Requisitions.
You are free to use any new technology you discover as you want, or give them out to the marines.
If shipside medbay is unstaffed, you should consider working as a regular doctor until someone else is available to take over.
It is also recommended that you gear up like a regular marine, or your 'internship' might be ending early..."})

/datum/job/terragov/medical/researcher/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 3000) // starting
			new_human.wear_id.paygrade = "CD"
		if(3001 to INFINITY) // 50 hrs
			new_human.wear_id.paygrade = "PROF"


/datum/outfit/job/medical/researcher
	name = FIELD_RESEARCHER
	jobtype = /datum/job/terragov/medical/researcher

	id = /obj/item/card/id
	belt = /obj/item/storage/belt/rig/research
	ears = /obj/item/radio/headset/mainship/res
	w_uniform = /obj/item/clothing/under/marine/officer/researcher
	wear_suit = /obj/item/clothing/suit/storage/labcoat/researcher
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/latex
	glasses = /obj/item/clothing/glasses/hud/health
	mask = /obj/item/clothing/mask/surgical
	r_store = /obj/item/storage/pouch/surgery
	l_store = /obj/item/storage/pouch/medkit/medic

/datum/outfit/job/medical/researcher/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	H.equip_to_slot_or_hand(new /obj/item/tweezers, SLOT_IN_R_POUCH)
	H.equip_to_slot_or_hand(new /obj/item/reagent_containers/glass/bottle/lemoline/doctor, SLOT_S_STORE)

/datum/job/terragov/civilian
	job_category = JOB_CAT_CIVILIAN
	selection_color = "#ffeedd"


//Liaison
/datum/job/terragov/civilian/liaison
	title = CORPORATE_LIAISON
	paygrade = "NT"
	comm_title = "CL"
	supervisors = "the NT corporate office"
	total_positions = 1
	access = list(ACCESS_NT_CORPORATE, ACCESS_ILLEGAL_PIRATE, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_LOGISTICS)
	minimal_access = list(ACCESS_NT_CORPORATE, ACCESS_ILLEGAL_PIRATE, ACCESS_MARINE_BRIDGE, ACCESS_MARINE_DROPSHIP, ACCESS_MARINE_RESEARCH, ACCESS_MARINE_LOGISTICS, ACCESS_MARINE_CARGO, ACCESS_MARINE_MEDBAY)
	skills_type = /datum/skills/civilian
	display_order = JOB_DISPLAY_ORDER_CORPORATE_LIAISON
	outfit = /datum/outfit/job/civilian/liaison
	exp_type = EXP_TYPE_COMMAND
	exp_requirements = XP_REQ_UNSEASONED
	job_flags = JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_PROVIDES_BANK_ACCOUNT|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_PROVIDES_SQUAD_HUD
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Hard (varies)<br /><br />
		<b>You answer to the</b> Nanotrasen Corporate Office<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Manage relations between Nanotrasen and TerraGov Marine Corps. Report your findings via faxes. Reply if you’re called.
	"}
	minimap_icon = "cl"

/datum/job/terragov/civilian/liaison/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return

	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) // 0 to 10 hours
			new_human.wear_id.paygrade = "NT1"
		if(601 to 1500) // 10 to 25 hours
			new_human.wear_id.paygrade = "NT2"
		if(1501 to 3000) // 25 to 50 hours
			new_human.wear_id.paygrade = "NT3"
		if(3001 to 6000) // 50 to 100 hours
			new_human.wear_id.paygrade = "NT4"
		if(6000 to INFINITY) // Above 100 hours
			new_human.wear_id.paygrade = "NT5"

/datum/job/terragov/civilian/liaison/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"As a representative of Nanotrasen Corporation you are expected to stay professional and loyal to the corporation at all times.
You are not required to follow military orders; however, you cannot give military orders.
Your primary job is to observe and report back your findings to Nanotrasen. Follow regular game rules unless told otherwise by your superiors.
Use your office fax machine to communicate with corporate headquarters or to acquire new directives. You may not receive anything back (especially if the game staff is absent or otherwise busy), and this is normal."})

/datum/outfit/job/civilian/liaison
	name = CORPORATE_LIAISON
	jobtype = /datum/job/terragov/civilian/liaison

	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/liaison_suit
	shoes = /obj/item/clothing/shoes/laceup

/datum/job/terragov/silicon
	job_category = JOB_CAT_SILICON
	selection_color = "#aaee55"

//Synthetic
/datum/job/terragov/silicon/synthetic
	title = SYNTHETIC
	req_admin_notify = TRUE
	comm_title = "Syn"
	paygrade = "Mk.I"
	supervisors = "the acting captain"
	total_positions = 1
	skills_type = /datum/skills/synthetic
	access = ALL_ACCESS
	minimal_access = ALL_ACCESS
	display_order = JOB_DISPLAY_ORDER_SYNTHETIC
	outfit = /datum/outfit/job/civilian/synthetic
	exp_type = EXP_TYPE_SYNTHETIC
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	job_flags = JOB_FLAG_SPECIALNAME|JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_ADDTOMANIFEST|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_PROVIDES_SQUAD_HUD|JOB_FLAG_CAN_SEE_ORDERS|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	job_points_needed = 40
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE_STRONG,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Soul Crushing<br /><br />
		<b>You answer to the</b> acting Command Staff and the human crew<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Crash, Nuclear War<br /><br /><br />
		<b>Duty</b>: Support and assist in every department of the TerraGov Marine Corps, use your incredibly developed skills to help the marines during their missions. You can talk to other synthetics or the AI on the :n channel. Serve your purpose.
	"}
	minimap_icon = "synth"

/datum/job/terragov/silicon/synthetic/get_special_name(client/preference_source)
	return preference_source.prefs.synthetic_name

/datum/job/terragov/silicon/synthetic/return_spawn_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /mob/living/carbon/human/species/early_synthetic
	return /mob/living/carbon/human/species/synthetic

/datum/job/terragov/silicon/synthetic/return_skills_type(datum/preferences/prefs)
	if(prefs?.synthetic_type == "Early Synthetic")
		return /datum/skills/early_synthetic
	return ..()

/datum/job/terragov/silicon/synthetic/after_spawn(mob/living/carbon/new_mob, mob/user, latejoin = FALSE)
	. = ..()
	if(!ishuman(new_mob))
		return
	var/mob/living/carbon/human/new_human = new_mob
	var/playtime_mins = user?.client?.get_exp(title)
	if(!playtime_mins || playtime_mins < 1 )
		return
	switch(playtime_mins)
		if(0 to 600) //up to 10 hours
			new_human.wear_id.paygrade = "Mk.I"
		if(601 to 3000) // 10 to 50 hrs
			new_human.wear_id.paygrade = "Mk.II"
		if(3001 to 6000) // 50 to 100 hrs
			new_human.wear_id.paygrade = "Mk.III"
		if(6001 to 9000) // 100 to 150 hrs
			new_human.wear_id.paygrade = "Mk.IV"
		if(9001 to 12000) // 150 to 200 hrs
			new_human.wear_id.paygrade = "Mk.V"
		if(12001 to 15000) // 200 to 250 hrs
			new_human.wear_id.paygrade = "Mk.VI"
		if(15001 to 18000) // 250 to 300 hrs
			new_human.wear_id.paygrade = "Mk.VII"
		if(18001 to 21000) // 300 to 350 hrs
			new_human.wear_id.paygrade = "Mk.VIII"
		if(21001 to 60000) // 350 to 1000 hrs
			new_human.wear_id.paygrade = "Mk.IX"
		if(60001 to INFINITY) // 1000 hrs and more
			new_human.wear_id.paygrade = "Mk.X"

/datum/job/terragov/silicon/synthetic/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your primary job is to support and assist all TGMC departments and personnel on-board.
In addition, being a Synthetic gives you knowledge in every field and specialization possible on-board the ship."})

/datum/outfit/job/civilian/synthetic
	name = SYNTHETIC
	jobtype = /datum/job/terragov/silicon/synthetic

	id = /obj/item/card/id/gold
	belt = /obj/item/storage/belt/utility/full
	ears = /obj/item/radio/headset/mainship/mcom
	w_uniform = /obj/item/clothing/under/rank/synthetic
	shoes = /obj/item/clothing/shoes/white
	gloves = /obj/item/clothing/gloves/insulated
	r_store = /obj/item/storage/pouch/general/medium
	l_store = /obj/item/storage/pouch/general/medium

/datum/job/terragov/silicon/ai
	title = SILICON_AI
	job_category = JOB_CAT_SILICON
	req_admin_notify = TRUE
	comm_title = "AI"
	total_positions = 1
	selection_color = "#92c255"
	supervisors = "your laws and the human crew"
	exp_requirements = XP_REQ_INTERMEDIATE
	exp_type = EXP_TYPE_REGULAR_ALL
	exp_requirements = XP_REQ_UPPER_INTERMEDIATE
	display_order = JOB_DISPLAY_ORDER_AI
	skills_type = /datum/skills/ai
	job_flags = JOB_FLAG_SPECIALNAME|JOB_FLAG_LATEJOINABLE|JOB_FLAG_ROUNDSTARTJOINABLE|JOB_FLAG_OVERRIDELATEJOINSPAWN|JOB_FLAG_ISCOMMAND|JOB_FLAG_BOLD_NAME_ON_SELECTION|JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP
	jobworth = list(
		/datum/job/xenomorph = LARVA_POINTS_SHIPSIDE,
		/datum/job/terragov/squad/smartgunner = SMARTIE_POINTS_REGULAR,
		/datum/job/terragov/silicon/synthetic = SYNTH_POINTS_REGULAR,
		/datum/job/terragov/command/mech_pilot = MECH_POINTS_REGULAR,
		/datum/job/terragov/command/assault_crewman = ARMORED_VEHICLE_POINTS_REGULAR,
	)
	html_description = {"
		<b>Difficulty</b>: Easy<br /><br />
		<b>You answer to the</b> acting Command Staff and the human crew<br /><br />
		<b>Unlock Requirement</b>: Starting Role<br /><br />
		<b>Gamemode Availability</b>: Nuclear War<br /><br /><br />
		<b>Duty</b>: Assist the crew whenever you’re needed, be the doorknob of the ship. Recon the areas for threats via cameras, report your findings to the crew at various communication channels. Follow your laws.
	"}
	minimap_icon = "ai" // this is saved for making minimap icon later for ai core

/datum/job/terragov/silicon/ai/get_special_name(client/preference_source)
	return preference_source.prefs.ai_name

/datum/job/terragov/silicon/ai/return_spawn_type(datum/preferences/prefs)
	return /mob/living/silicon/ai

/datum/job/terragov/silicon/ai/radio_help_message(mob/M)
	. = ..()
	to_chat(M, {"Your primary job is to support and assist all TGMC departments and personnel on-board.
However, your vision is limited through cameras from the ship or to marines groundside.
Recon any threats and report findings at various communication channels.
If you require any help, use <b>mentorhelp</b> to ask mentors about what you're supposed to do."})

/datum/job/terragov/silicon/ai/announce(mob/living/announced_mob)
	. = ..()
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(minor_announce), "[announced_mob] has been downloaded to an empty bluespace-networked AI core at [AREACOORD(announced_mob)]."))

/datum/job/terragov/silicon/ai/config_check()
	return CONFIG_GET(flag/allow_ai)

// Silicons only need a very basic preview since there is no customization for them.
/datum/job/terragov/silicon/ai/handle_special_preview(client/parent)
	parent.show_character_previews(image('icons/mob/ai.dmi', icon_state = "ai"), list(SOUTH))
	return TRUE
