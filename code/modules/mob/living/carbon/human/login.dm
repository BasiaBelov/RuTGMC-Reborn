/mob/living/carbon/human/Login()
	. = ..()
	species?.handle_login_special(src)

	if(HAS_TRAIT(src, TRAIT_IS_RESURRECTING))
		to_chat(src, span_notice("You are resurrecting, hold still..."))
