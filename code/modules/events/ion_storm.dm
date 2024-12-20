/datum/round_event_control/ion_storm
	name = "Communication Blackout"
	typepath = /datum/round_event/ion_storm
	weight = 7
	earliest_start = 60 MINUTES
	max_occurrences = 1

	gamemode_blacklist = list("Crash")

/datum/round_event_control/ion_storm/can_spawn_event(players_amt, gamemode)
	return ..()

/datum/round_event/ion_storm/
	announce_when = 0

/datum/round_event/ion_storm/start()
	for(var/obj/machinery/telecomms/C AS in GLOB.telecomms_list)
		if(C.machine_stat & (NOPOWER|BROKEN|DISABLED))
			continue
		C.machine_stat |= NOPOWER|BROKEN|DISABLED

	var/comms_knockout_timer = pick(1,1.5,1.7,2,2.3,2.5,3,4,8)
	addtimer(CALLBACK(src, PROC_REF(fix_comms)), comms_knockout_timer MINUTES)

/datum/round_event/ion_storm/announce()
	var/alert = pick( "Обнаружена ионосферная аномалия. Сбой связи неизбежен. Пожалуйста, свяжитесь с ваши*%fj00)`5vc",
		"Обнаружена ионосферная аномалия. Сбой связи неизб*3mga;b4;'1v¬",
		"Обнаружена ионосферная аномалия. Сбой свя#MCi46:5.;@63",
		"Обнаружена ионосферная аномал'fZ\\kg5_0",
		"Обнаружена ионосфер:%£ MCayj^j<.3",
		"#4nd%;f4y6,>£%",
	)
	priority_announce(alert)

///Restores comms back to normal
/datum/round_event/ion_storm/proc/fix_comms()
	for(var/obj/machinery/telecomms/C AS in GLOB.telecomms_list)
		var/area/A = get_area(C)
		if(A.power_environ == FALSE)
			C.machine_stat = NOPOWER //remove the broken flags from before, so marines can still use the machines after they fix the area power
			continue
		C.machine_stat = NONE
