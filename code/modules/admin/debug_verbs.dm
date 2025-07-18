ADMIN_VERB(delete_all, R_DEBUG, "Delete Instances", "Delete all instances of something", ADMIN_CATEGORY_DEBUG) // todo why does this exist instead of sdql

	var/blocked = list(/obj, /obj/item, /obj/effect, /obj/machinery, /mob, /mob/living, /mob/living/carbon, /mob/living/carbon/xenomorph, /mob/living/carbon/human, /mob/dead, /mob/dead/observer, /mob/living/silicon, /mob/living/silicon/ai)
	var/chosen_deletion = input(user, "Type the path of the object you want to delete", "Delete:") as null|text

	if(!chosen_deletion)
		return

	chosen_deletion = text2path(chosen_deletion)
	if(!ispath(chosen_deletion))
		return

	if(!ispath(/mob) && !ispath(/obj))
		to_chat(user,
			type = MESSAGE_TYPE_DEBUG,
			html = span_warning("Only works for types of /obj or /mob."))
		return

	var/hsbitem = input(user, "Choose an object to delete.", "Delete:") as null|anything in typesof(chosen_deletion)
	if(!hsbitem)
		return

	var/do_delete = TRUE
	if(hsbitem in blocked)
		if(alert("Are you REALLY sure you wish to delete all instances of [hsbitem]? This will lead to catastrophic results!",,"Yes","No") != "Yes")
			do_delete = FALSE

	var/del_amt = 0
	if(!do_delete)
		return

	for(var/atom/O in world)
		if(istype(O, hsbitem))
			del_amt++
			qdel(O)

	log_admin("[key_name(user)] deleted all instances of [hsbitem] ([del_amt]).")
	message_admins("[ADMIN_TPMONTY(user.mob)] deleted all instances of [hsbitem] ([del_amt]).")

ADMIN_VERB(generate_powernets, R_DEBUG, "Generate Powernets", "Regenerate all powernets.", ADMIN_CATEGORY_DEBUG)
	SSmachines.makepowernets()

	log_admin("[key_name(user)] has remade powernets.")
	message_admins("[ADMIN_TPMONTY(user.mob)] has remade powernets.")


ADMIN_VERB(debug_mob_lists, R_DEBUG, "Debug Mob Lists", "Debug mob globals", ADMIN_CATEGORY_DEBUG)
	var/list/options = list("Players", "Observers", "New Players", "Admins", "Clients", "Mobs", "Living Mobs", "Alive Living Mobs", "Dead Mobs", "Xenos", "Alive Xenos", "Dead Xenos", "Humans", "Alive Humans", "Dead Humans")
	var/choice = tgui_input_list(user, "Which list?", "Global Mob List debugging", options)
	if(!choice)
		return

	var/dat
	switch(choice)
		if("Players")
			for(var/i in GLOB.player_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Observers")
			for(var/i in GLOB.observer_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("New Players")
			for(var/i in GLOB.new_player_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Admins")
			for(var/i in GLOB.admins)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Clients")
			for(var/i in GLOB.clients)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Mobs")
			for(var/i in GLOB.mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Living Mobs")
			for(var/i in GLOB.mob_living_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Alive Living Mobs")
			for(var/i in GLOB.alive_living_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Dead Mobs")
			for(var/i in GLOB.dead_mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Xenos")
			for(var/i in GLOB.xeno_mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Alive Xenos")
			for(var/i in GLOB.alive_xeno_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Dead Xenos")
			for(var/i in GLOB.dead_xeno_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Humans")
			for(var/i in GLOB.human_mob_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Alive Humans")
			for(var/i in GLOB.alive_human_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"
		if("Dead Humans")
			for(var/i in GLOB.dead_human_list)
				var/mob/M = i
				dat += "[M] [ADMIN_VV(M)]<br>"

	var/datum/browser/browser = new(user, "moblists", "<div align='center'>[choice]</div>")
	browser.set_content(dat)
	browser.open(FALSE)

	log_admin("[key_name(user)] is debugging the [choice] list.")
	message_admins("[ADMIN_TPMONTY(user.mob)] is debugging the [choice] list.")


ADMIN_VERB(spawn_atom, R_SPAWN, "Spawn", "(atom path) Spawn an atom", ADMIN_CATEGORY_DEBUG, object as text)
	if(!object)
		return
	var/list/preparsed = splittext(object,":")
	var/path = preparsed[1]
	var/amount = 1
	if(length(preparsed) > 1)
		amount = clamp(text2num(preparsed[2]),1,ADMIN_SPAWN_CAP)

	var/chosen = pick_closest_path(path)
	if(!chosen)
		return
	var/turf/T = get_turf(user.mob)

	if(ispath(chosen, /turf))
		T.change_turf(chosen)
	else
		for(var/i in 1 to amount)
			var/atom/A = new chosen(T)
			A.atom_flags |= ADMIN_SPAWNED

	log_admin("[key_name(user)] spawned [amount] x [chosen] at [AREACOORD(user.mob)]")

ADMIN_VERB_AND_CONTEXT_MENU(delete_atom, R_DEBUG, "Delete", ADMIN_VERB_NO_DESCRIPTION, ADMIN_CATEGORY_HIDDEN, atom/target as obj|mob|turf in world)
	if(alert(user, "Are you sure you want to delete: [target]?", "Delete", "Yes", "No") != "Yes")
		return

	if(QDELETED(target))
		return

	var/turf/T = get_turf(target)

	log_admin("[key_name(user)] deleted [target]([target.type]) at [AREACOORD(T)].")
	message_admins("[ADMIN_TPMONTY(user.mob)] deleted [target]([target.type]) at [ADMIN_VERBOSEJMP(T)].")

	if(isturf(target))
		var/turf/deleting_turf = target
		deleting_turf.scrape_away()
		return

	qdel(target)

ADMIN_VERB(restart_controller, R_DEBUG, "Restart Controller", "Restart one of the various periodic loop controllers for the game (be careful!)", ADMIN_CATEGORY_DEBUG, controller in list("Master", "Failsafe"))
	switch(controller)
		if("Master")
			Recreate_MC()
			BLACKBOX_LOG_ADMIN_VERB("Restart Master Controller")
		if("Failsafe")
			new /datum/controller/failsafe()
			BLACKBOX_LOG_ADMIN_VERB("Restart Failsafe Controller")

	message_admins("Admin [key_name_admin(user)] has restarted the [controller] controller.")

ADMIN_VERB(debug_controller, R_DEBUG, "Debug Controller", "Debug the various periodic loop controllers for the game (be careful!)", ADMIN_CATEGORY_DEBUG)
	var/list/controllers = list()
	var/list/controller_choices = list()

	for(var/datum/controller/controller)
		if(istype(controller, /datum/controller/subsystem))
			continue
		controllers["[controller] (controller.type)"] = controller //we use an associated list to ensure clients can't hold references to controllers
		controller_choices += "[controller] (controller.type)"

	var/datum/controller/controller_string = input(user, "Select controller to debug", "Debug Controller") as null|anything in controller_choices
	var/datum/controller/controller = controllers[controller_string]

	if(!istype(controller))
		return
	SSadmin_verbs.dynamic_invoke_verb(user, /datum/admin_verb/debug_variables, controller)

	log_admin("[key_name(user)] is debugging the [controller] controller.")
	message_admins("Admin [key_name_admin(user)] is debugging the [controller] controller.")

ADMIN_VERB(reestablish_db_connection, R_DEBUG, "Reestablish DB Connection", "Attempts to (re)establish the DB Connection", ADMIN_CATEGORY_SERVER)
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	if(SSdbcore.IsConnected(TRUE))
		if(alert("The database is already connected! If you *KNOW* that this is incorrect, you can force a reconnection", "The database is already connected!", "Force Reconnect", "Cancel") != "Force Reconnect")
			return

		SSdbcore.Disconnect()
		log_admin("[key_name(usr)] has forced the database to disconnect")
		message_admins("[ADMIN_TPMONTY(usr)] has forced the database to disconnect!")

	log_admin("[key_name(usr)] is attempting to re-established the DB Connection.")
	message_admins("[ADMIN_TPMONTY(usr)] is attempting to re-established the DB Connection.")

	SSdbcore.failed_connections = 0

	if(!SSdbcore.Connect())
		log_admin("Database connection failed: " + SSdbcore.ErrorMsg())
		message_admins("Database connection failed: " + SSdbcore.ErrorMsg())
	else
		log_admin("Database connection re-established!")
		message_admins("Database connection re-established!")

ADMIN_VERB(view_runtimes, R_DEBUG, "View Runtimes", "Opens the runtime viewer.", ADMIN_CATEGORY_DEBUG)
	GLOB.error_cache.show_to(user)

	// The runtime viewer has the potential to crash the server if there's a LOT of runtimes
	// this has happened before, multiple times, so we'll just leave an alert on it
	if(GLOB.total_runtimes >= 50000) // arbitrary number, I don't know when exactly it happens
		var/warning = "There are a lot of runtimes, clicking any button (especially \"linear\") can have the potential to lag or crash the server"
		if(GLOB.total_runtimes >= 100000)
			warning = "There are a TON of runtimes, clicking any button (especially \"linear\") WILL LIKELY crash the server"
		// Not using TGUI alert, because it's view runtimes, stuff is probably broken
		alert(user, "[warning]. Proceed with caution. If you really need to see the runtimes, download the runtime log and view it in a text editor.", "HEED THIS WARNING CAREFULLY MORTAL")

ADMIN_VERB(spatial_agent, R_FUN, "Spatial Agent", "Become a spatial agent", ADMIN_CATEGORY_DEBUG)
	var/mob/M = user.mob
	var/mob/living/carbon/human/H
	var/spatial = FALSE
	if(ishuman(M))
		H = M
		var/datum/job/J = H.job
		spatial = istype(J, /datum/job/spatial_agent)

	if(spatial)
		log_admin("[key_name(M)] stopped being a spatial agent.")
		message_admins("[ADMIN_TPMONTY(M)] stopped being a spatial agent.")
		qdel(M)
	else
		H = new(get_turf(M))
		M.client.prefs.copy_to(H)
		M.mind.transfer_to(H, TRUE)
		var/datum/job/J = SSjob.GetJobType(/datum/job/spatial_agent)
		H.apply_assigned_role_to_spawn(J)
		qdel(M)

		log_admin("[key_name(H)] became a spatial agent.")
		message_admins("[ADMIN_TPMONTY(H)] became a spatial agent.")

ADMIN_VERB(military_policeman, R_FUN, "Military Policeman", "Become a marine law-enforcing MRP retard", ADMIN_CATEGORY_DEBUG)
	var/mob/M = user.mob
	var/mob/living/carbon/human/H
	var/spatial = FALSE
	if(ishuman(M))
		H = M
		var/datum/job/J = H.job
		spatial = istype(J, /datum/job/terragov/command/military_police)

	if(spatial)
		log_admin("[key_name(M)] stopped being a debug military policeman.")
		message_admins("[ADMIN_TPMONTY(M)] stopped being a debug military policeman.")
		qdel(M)
	else
		H = new(get_turf(M))
		M.client.prefs.copy_to(H)
		M.mind.transfer_to(H, TRUE)
		var/datum/job/J = SSjob.GetJobType(/datum/job/terragov/command/military_police)
		H.apply_assigned_role_to_spawn(J)
		qdel(M)

		log_admin("[key_name(H)] became a debug military policeman.")
		message_admins("[ADMIN_TPMONTY(H)] became a debug military policeman.")

ADMIN_VERB(profiler, R_DEBUG|R_RUNTIME, "Profiler", "Inspect the procs that take most of cpu or world time", ADMIN_CATEGORY_DEBUG)
	winset(usr, null, "command=.profile")

/proc/wipe_color_and_text(list/atom/wiping)
	for(var/i in wiping)
		var/atom/atom_to_clean = i
		atom_to_clean.color = null
		atom_to_clean.maptext = ""

ADMIN_VERB(cmd_display_del_log, R_DEBUG, "Display del() Log", "Display del's log of everything that's passed through it.", ADMIN_CATEGORY_DEBUG)
	var/list/dellog = list("<B>List of things that have gone through qdel this round</B><BR><BR><ol>")
	sortTim(SSgarbage.items, cmp=/proc/cmp_qdel_item_time, associative = TRUE)
	for(var/path in SSgarbage.items)
		var/datum/qdel_item/I = SSgarbage.items[path]
		dellog += "<li><u>[path]</u><ul>"
		if (I.qdel_flags & QDEL_ITEM_SUSPENDED_FOR_LAG)
			dellog += "<li>SUSPENDED FOR LAG</li>"
		if (I.failures)
			dellog += "<li>Failures: [I.failures]</li>"
		dellog += "<li>qdel() Count: [I.qdels]</li>"
		dellog += "<li>Destroy() Cost: [I.destroy_time]ms</li>"
		if (I.hard_deletes)
			dellog += "<li>Total Hard Deletes [I.hard_deletes]</li>"
			dellog += "<li>Time Spent Hard Deleting: [I.hard_delete_time]ms</li>"
			dellog += "<li>Highest Time Spent Hard Deleting: [I.hard_delete_max]ms</li>"
			if (I.hard_deletes_over_threshold)
				dellog += "<li>Hard Deletes Over Threshold: [I.hard_deletes_over_threshold]</li>"
		if (I.slept_destroy)
			dellog += "<li>Sleeps: [I.slept_destroy]</li>"
		if (I.no_respect_force)
			dellog += "<li>Ignored force: [I.no_respect_force]</li>"
		if (I.no_hint)
			dellog += "<li>No hint: [I.no_hint]</li>"
		dellog += "</ul></li>"

	dellog += "</ol>"

	var/datum/browser/browser = new(usr, "dellog", "Del Log", 00, 400)
	browser.set_content(dellog.Join())
	browser.open()

ADMIN_VERB(debug_statpanel, R_DEBUG, "Debug Stat Panel", "Toggles local debug of the stat panel", ADMIN_CATEGORY_DEBUG)
	user.stat_panel.send_message("create_debug")

ADMIN_VERB(display_sendmaps, R_DEBUG, "Send Maps Profile", "View the profile.", ADMIN_CATEGORY_DEBUG)
	user << link("?debug=profile&type=sendmaps&window=test")
