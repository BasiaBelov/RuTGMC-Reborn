#define FOOTSTEP_WOOD "wood"
#define FOOTSTEP_FLOOR "floor"
#define FOOTSTEP_PLATING "plating"
#define FOOTSTEP_CARPET "carpet"
#define FOOTSTEP_SAND "sand"
#define FOOTSTEP_DIRT "dirt"
#define FOOTSTEP_GRASS "grass"
#define FOOTSTEP_WET "wet"
#define FOOTSTEP_WATER "water"
#define FOOTSTEP_SWIM "swim"
#define FOOTSTEP_RESIN "resin"
#define FOOTSTEP_HULL "hull"
#define FOOTSTEP_CATWALK "catwalk"
#define FOOTSTEP_SNOW "snow"
#define FOOTSTEP_ICE "ice"
#define FOOTSTEP_CONCRETE "concrete"
#define FOOTSTEP_GRAVEL "gravel"
//barefoot and claw sounds
#define FOOTSTEP_HARD "hard"
//misc footstep sounds
#define FOOTSTEP_GENERIC_HEAVY "heavy"

//footstep mob defines
#define FOOTSTEP_MOB_BAREFOOT 1
#define FOOTSTEP_XENO_HEAVY 2
#define FOOTSTEP_MOB_SHOE 3
#define FOOTSTEP_MOB_HUMAN 4 //Warning: Only works on /mob/living/carbon/human
#define FOOTSTEP_XENO_MEDIUM 5
#define FOOTSTEP_XENO_STOMPY 6
#define FOOTSTEP_PREDALIEN_STOMPY 7

GLOBAL_LIST_INIT(shoefootstep, list(
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/wood1.ogg',
		'sound/effects/footstep/wood2.ogg',
		'sound/effects/footstep/wood3.ogg',
		'sound/effects/footstep/wood4.ogg',
		'sound/effects/footstep/wood5.ogg'), 100, 0),
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/floor1.ogg',
		'sound/effects/footstep/floor2.ogg',
		'sound/effects/footstep/floor3.ogg',
		'sound/effects/footstep/floor4.ogg',
		'sound/effects/footstep/floor5.ogg'), 75, -1),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/plating1.ogg',
		'sound/effects/footstep/plating2.ogg',
		'sound/effects/footstep/plating3.ogg',
		'sound/effects/footstep/plating4.ogg',
		'sound/effects/footstep/plating5.ogg'), 100, 1),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/carpet1.ogg',
		'sound/effects/footstep/carpet2.ogg',
		'sound/effects/footstep/carpet3.ogg',
		'sound/effects/footstep/carpet4.ogg',
		'sound/effects/footstep/carpet5.ogg'), 75, -1),
	FOOTSTEP_SAND = list(list(
		'sound/effects/footstep/sand1.ogg',
		'sound/effects/footstep/sand2.ogg',
		'sound/effects/footstep/sand3.ogg',
		'sound/effects/footstep/asteroid4.ogg'), 75, 0),
	FOOTSTEP_DIRT = list(list(
		'sound/effects/footstep/asteroid1.ogg',
		'sound/effects/footstep/asteroid2.ogg',
		'sound/effects/footstep/asteroid3.ogg',
		'sound/effects/footstep/asteroid4.ogg',
		'sound/effects/footstep/asteroid5.ogg'), 75, 0),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'), 75, 0),
	FOOTSTEP_WET = list(list(
		'sound/effects/footstep/waterstep1.ogg',
		'sound/effects/footstep/waterstep2.ogg',
		'sound/effects/footstep/water3.ogg'), 100, 1),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 1),
	FOOTSTEP_SWIM = list(list(
		'sound/effects/footstep/swimming1.ogg',
		'sound/effects/footstep/swimming2.ogg',
		'sound/effects/footstep/swimming3.ogg'), 100, 1),
	FOOTSTEP_RESIN = list(list(
		'sound/effects/footstep/alien/resin_move1.ogg',
		'sound/effects/footstep/alien/resin_move2.ogg',), 50, 2),
	FOOTSTEP_HULL = list(list(
		'sound/effects/footstep/hull1.ogg',
		'sound/effects/footstep/hull2.ogg',
		'sound/effects/footstep/hull3.ogg',
		'sound/effects/footstep/hull4.ogg',
		'sound/effects/footstep/hull5.ogg'), 100, 1),
	FOOTSTEP_CATWALK = list(list(
		'sound/effects/footstep/catwalk1.ogg',
		'sound/effects/footstep/catwalk2.ogg',
		'sound/effects/footstep/catwalk3.ogg',
		'sound/effects/footstep/catwalk4.ogg',
		'sound/effects/footstep/catwalk5.ogg'), 100, 1),
	FOOTSTEP_SNOW = list(list(
		'sound/effects/footstep/snow1.ogg',
		'sound/effects/footstep/snow2.ogg',
		'sound/effects/footstep/snow3.ogg',
		'sound/effects/footstep/snow4.ogg',
		'sound/effects/footstep/snow5.ogg'), 100, 1),
	FOOTSTEP_ICE = list(list(
		'sound/effects/footstep/ice1.ogg',
		'sound/effects/footstep/ice2.ogg',
		'sound/effects/footstep/ice3.ogg',
		'sound/effects/footstep/ice4.ogg',
		'sound/effects/footstep/ice5.ogg'), 60, 1),
	FOOTSTEP_CONCRETE = list(list(
		'sound/effects/footstep/concrete1.ogg',
		'sound/effects/footstep/concrete2.ogg',
		'sound/effects/footstep/concrete3.ogg',
		'sound/effects/footstep/concrete4.ogg',
		'sound/effects/footstep/concrete5.ogg'), 100, 1),
	FOOTSTEP_GRAVEL = list(list(
		'sound/effects/footstep/gravel_1.ogg',
		'sound/effects/footstep/gravel_2.ogg',
		'sound/effects/footstep/gravel_3.ogg',
		'sound/effects/footstep/gravel_4.ogg',
		'sound/effects/footstep/gravel_5.ogg',
		'sound/effects/footstep/gravel_6.ogg',
		'sound/effects/footstep/gravel_7.ogg',
		'sound/effects/footstep/gravel_8.ogg',
		'sound/effects/footstep/gravel_9.ogg',
		'sound/effects/footstep/gravel_11.ogg',
		'sound/effects/footstep/gravel_12.ogg',
		'sound/effects/footstep/gravel_13.ogg',
		'sound/effects/footstep/gravel_14.ogg',
		'sound/effects/footstep/gravel_15.ogg',
		'sound/effects/footstep/gravel_16.ogg',
		'sound/effects/footstep/gravel_17.ogg',
		'sound/effects/footstep/gravel_18.ogg'), 75, 1),
))

//bare footsteps lists
GLOBAL_LIST_INIT(barefootstep, list(
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/woodbarefoot1.ogg',
		'sound/effects/footstep/woodbarefoot2.ogg',
		'sound/effects/footstep/woodbarefoot3.ogg',
		'sound/effects/footstep/woodbarefoot4.ogg',
		'sound/effects/footstep/woodbarefoot5.ogg'
	), 80, -1),
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/woodbarefoot1.ogg',
		'sound/effects/footstep/woodbarefoot2.ogg',
		'sound/effects/footstep/woodbarefoot3.ogg',
		'sound/effects/footstep/woodbarefoot4.ogg',
		'sound/effects/footstep/woodbarefoot5.ogg'), 80, -1),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/hardbarefoot1.ogg',
		'sound/effects/footstep/hardbarefoot2.ogg',
		'sound/effects/footstep/hardbarefoot3.ogg',
		'sound/effects/footstep/hardbarefoot4.ogg',
		'sound/effects/footstep/hardbarefoot5.ogg'), 80, -1),
	FOOTSTEP_HARD = list(list(
		'sound/effects/footstep/hardbarefoot1.ogg',
		'sound/effects/footstep/hardbarefoot2.ogg',
		'sound/effects/footstep/hardbarefoot3.ogg',
		'sound/effects/footstep/hardbarefoot4.ogg',
		'sound/effects/footstep/hardbarefoot5.ogg'), 80, -1),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/carpetbarefoot1.ogg',
		'sound/effects/footstep/carpetbarefoot2.ogg',
		'sound/effects/footstep/carpetbarefoot3.ogg',
		'sound/effects/footstep/carpetbarefoot4.ogg',
		'sound/effects/footstep/carpetbarefoot5.ogg'), 75, -2),
	FOOTSTEP_SAND = list(list(
		'sound/effects/footstep/sand1.ogg',
		'sound/effects/footstep/sand2.ogg',
		'sound/effects/footstep/sand3.ogg',
		'sound/effects/footstep/asteroid4.ogg'), 60, 0),
	FOOTSTEP_DIRT = list(list(
		'sound/effects/footstep/asteroid1.ogg',
		'sound/effects/footstep/asteroid2.ogg',
		'sound/effects/footstep/asteroid3.ogg',
		'sound/effects/footstep/asteroid4.ogg',
		'sound/effects/footstep/asteroid5.ogg'), 60, 0),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'), 75, 0),
	FOOTSTEP_WET = list(list(
		'sound/effects/footstep/waterstep1.ogg',
		'sound/effects/footstep/waterstep2.ogg',
		'sound/effects/footstep/water3.ogg'), 100, 1),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 1),
	FOOTSTEP_SWIM = list(list(
		'sound/effects/footstep/swimming1.ogg',
		'sound/effects/footstep/swimming2.ogg',
		'sound/effects/footstep/swimming3.ogg'), 100, 1),
	FOOTSTEP_RESIN = list(list(
		'sound/effects/footstep/alien/resin_move1.ogg',
		'sound/effects/footstep/alien/resin_move2.ogg',), 70, 2),
	FOOTSTEP_HULL = list(list(
		'sound/effects/footstep/hull1.ogg',
		'sound/effects/footstep/hull2.ogg',
		'sound/effects/footstep/hull3.ogg',
		'sound/effects/footstep/hull4.ogg',
		'sound/effects/footstep/hull5.ogg'), 80, 1),
	FOOTSTEP_CATWALK = list(list(
		'sound/effects/footstep/catwalk1.ogg',
		'sound/effects/footstep/catwalk2.ogg',
		'sound/effects/footstep/catwalk3.ogg',
		'sound/effects/footstep/catwalk4.ogg',
		'sound/effects/footstep/catwalk5.ogg'), 80, -1),
	FOOTSTEP_SNOW = list(list(
		'sound/effects/footstep/snow1.ogg',
		'sound/effects/footstep/snow2.ogg',
		'sound/effects/footstep/snow3.ogg',
		'sound/effects/footstep/snow4.ogg',
		'sound/effects/footstep/snow5.ogg'), 80, 0),
	FOOTSTEP_ICE = list(list(
		'sound/effects/footstep/ice1.ogg',
		'sound/effects/footstep/ice2.ogg',
		'sound/effects/footstep/ice3.ogg',
		'sound/effects/footstep/ice4.ogg',
		'sound/effects/footstep/ice5.ogg'), 50, 0),
	FOOTSTEP_CONCRETE = list(list(
		'sound/effects/footstep/hardbarefoot1.ogg',
		'sound/effects/footstep/hardbarefoot2.ogg',
		'sound/effects/footstep/hardbarefoot3.ogg',
		'sound/effects/footstep/hardbarefoot4.ogg',
		'sound/effects/footstep/hardbarefoot5.ogg'), 80, -1),
	FOOTSTEP_GRAVEL = list(list(
		'sound/effects/footstep/gravel_1.ogg',
		'sound/effects/footstep/gravel_2.ogg',
		'sound/effects/footstep/gravel_3.ogg',
		'sound/effects/footstep/gravel_4.ogg',
		'sound/effects/footstep/gravel_5.ogg',
		'sound/effects/footstep/gravel_6.ogg',
		'sound/effects/footstep/gravel_7.ogg',
		'sound/effects/footstep/gravel_8.ogg',
		'sound/effects/footstep/gravel_9.ogg',
		'sound/effects/footstep/gravel_11.ogg',
		'sound/effects/footstep/gravel_12.ogg',
		'sound/effects/footstep/gravel_13.ogg',
		'sound/effects/footstep/gravel_14.ogg',
		'sound/effects/footstep/gravel_15.ogg',
		'sound/effects/footstep/gravel_16.ogg',
		'sound/effects/footstep/gravel_17.ogg',
		'sound/effects/footstep/gravel_18.ogg'), 60, 1),
))

//claw footsteps lists
GLOBAL_LIST_INIT(xenomediumstep, list(
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/woodclaw1.ogg',
		'sound/effects/footstep/woodclaw2.ogg',
		'sound/effects/footstep/woodclaw3.ogg'), 60, 1),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/hardclaw1.ogg',
		'sound/effects/footstep/hardclaw2.ogg',
		'sound/effects/footstep/hardclaw3.ogg',
		'sound/effects/footstep/hardclaw4.ogg'), 70, 1),
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/hardclaw1.ogg',
		'sound/effects/footstep/hardclaw2.ogg',
		'sound/effects/footstep/hardclaw3.ogg',
		'sound/effects/footstep/hardclaw4.ogg'), 70, 1),
	FOOTSTEP_HARD = list(list(
		'sound/effects/footstep/hardclaw1.ogg',
		'sound/effects/footstep/hardclaw2.ogg',
		'sound/effects/footstep/hardclaw3.ogg',
		'sound/effects/footstep/hardclaw4.ogg'), 70, 1),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/carpetbarefoot1.ogg',
		'sound/effects/footstep/carpetbarefoot2.ogg',
		'sound/effects/footstep/carpetbarefoot3.ogg',
		'sound/effects/footstep/carpetbarefoot4.ogg',
		'sound/effects/footstep/carpetbarefoot5.ogg'), 55, -1),
	FOOTSTEP_SAND = list(list(
		'sound/effects/footstep/sand1.ogg',
		'sound/effects/footstep/sand2.ogg',
		'sound/effects/footstep/sand3.ogg',
		'sound/effects/footstep/asteroid4.ogg'), 55, 0),
	FOOTSTEP_DIRT = list(list(
		'sound/effects/footstep/asteroid1.ogg',
		'sound/effects/footstep/asteroid2.ogg',
		'sound/effects/footstep/asteroid3.ogg',
		'sound/effects/footstep/asteroid4.ogg',
		'sound/effects/footstep/asteroid5.ogg'), 55, 0),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'), 65, 1),
	FOOTSTEP_WET = list(list(
		'sound/effects/footstep/waterstep1.ogg',
		'sound/effects/footstep/waterstep2.ogg',
		'sound/effects/footstep/water3.ogg'), 50, 1),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 50, 1),
	FOOTSTEP_SWIM = list(list(
		'sound/effects/footstep/swimming1.ogg',
		'sound/effects/footstep/swimming2.ogg',
		'sound/effects/footstep/swimming3.ogg'), 50, 1),
	FOOTSTEP_RESIN = list(list(
		'sound/effects/footstep/alien/resin_move1.ogg',
		'sound/effects/footstep/alien/resin_move2.ogg',), 15, -4),
	FOOTSTEP_HULL = list(list(
		'sound/effects/footstep/hull1.ogg',
		'sound/effects/footstep/hull2.ogg',
		'sound/effects/footstep/hull3.ogg',
		'sound/effects/footstep/hull4.ogg',
		'sound/effects/footstep/hull5.ogg'), 70, 1),
	FOOTSTEP_CATWALK = list(list(
		'sound/effects/footstep/catwalk1.ogg',
		'sound/effects/footstep/catwalk2.ogg',
		'sound/effects/footstep/catwalk3.ogg',
		'sound/effects/footstep/catwalk4.ogg',
		'sound/effects/footstep/catwalk5.ogg'), 70, 1),
	FOOTSTEP_SNOW = list(list(
		'sound/effects/footstep/snow1.ogg',
		'sound/effects/footstep/snow2.ogg',
		'sound/effects/footstep/snow3.ogg',
		'sound/effects/footstep/snow4.ogg',
		'sound/effects/footstep/snow5.ogg'), 70, 1),
	FOOTSTEP_ICE = list(list(
		'sound/effects/footstep/ice1.ogg',
		'sound/effects/footstep/ice2.ogg',
		'sound/effects/footstep/ice3.ogg',
		'sound/effects/footstep/ice4.ogg',
		'sound/effects/footstep/ice5.ogg'), 50, 1),
	FOOTSTEP_CONCRETE = list(list(
		'sound/effects/footstep/concrete1.ogg',
		'sound/effects/footstep/concrete2.ogg',
		'sound/effects/footstep/concrete3.ogg',
		'sound/effects/footstep/concrete4.ogg',
		'sound/effects/footstep/concrete5.ogg'), 70, 1),
	FOOTSTEP_GRAVEL = list(list(
		'sound/effects/footstep/gravel_1.ogg',
		'sound/effects/footstep/gravel_2.ogg',
		'sound/effects/footstep/gravel_3.ogg',
		'sound/effects/footstep/gravel_4.ogg',
		'sound/effects/footstep/gravel_5.ogg',
		'sound/effects/footstep/gravel_6.ogg',
		'sound/effects/footstep/gravel_7.ogg',
		'sound/effects/footstep/gravel_8.ogg',
		'sound/effects/footstep/gravel_9.ogg',
		'sound/effects/footstep/gravel_11.ogg',
		'sound/effects/footstep/gravel_12.ogg',
		'sound/effects/footstep/gravel_13.ogg',
		'sound/effects/footstep/gravel_14.ogg',
		'sound/effects/footstep/gravel_15.ogg',
		'sound/effects/footstep/gravel_16.ogg',
		'sound/effects/footstep/gravel_17.ogg',
		'sound/effects/footstep/gravel_18.ogg'), 55, 1),
))

//heavy footsteps list
GLOBAL_LIST_INIT(xenoheavystep, list(
	FOOTSTEP_GENERIC_HEAVY = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_HARD = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_SAND = list(list(
		'sound/effects/footstep/sand1.ogg',
		'sound/effects/footstep/sand2.ogg',
		'sound/effects/footstep/sand3.ogg',
		'sound/effects/footstep/asteroid4.ogg'), 100, 0),
	FOOTSTEP_DIRT = list(list(
		'sound/effects/footstep/asteroid1.ogg',
		'sound/effects/footstep/asteroid2.ogg',
		'sound/effects/footstep/asteroid3.ogg',
		'sound/effects/footstep/asteroid4.ogg',
		'sound/effects/footstep/asteroid5.ogg'), 100, 0),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_WET = list(list(
		'sound/effects/footstep/waterstep1.ogg',
		'sound/effects/footstep/waterstep2.ogg',
		'sound/effects/footstep/water3.ogg'), 100, 1),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 100, 1),
	FOOTSTEP_SWIM = list(list(
		'sound/effects/footstep/swimming1.ogg',
		'sound/effects/footstep/swimming2.ogg',
		'sound/effects/footstep/swimming3.ogg'), 100, 1),
	FOOTSTEP_RESIN = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_HULL = list(list(
		'sound/effects/footstep/hull1.ogg',
		'sound/effects/footstep/hull2.ogg',
		'sound/effects/footstep/hull3.ogg',
		'sound/effects/footstep/hull4.ogg',
		'sound/effects/footstep/hull5.ogg'), 100, 1),
	FOOTSTEP_CATWALK = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_SNOW = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_ICE = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_CONCRETE = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
	FOOTSTEP_GRAVEL = list(list(
		'sound/effects/footstep/heavy1.ogg',
		'sound/effects/footstep/heavy2.ogg',
		'sound/effects/footstep/heavy3.ogg'), 100, 2),
))

//claw footsteps lists
GLOBAL_LIST_INIT(xenostompy, list(
	FOOTSTEP_GENERIC_HEAVY = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 100, 2),
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 60, 1),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 70, 1),
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 70, 1),
	FOOTSTEP_HARD = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 70, 1),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 55, -1),
	FOOTSTEP_SAND = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 55, 1),
	FOOTSTEP_DIRT = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 55, 1),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 65, 1),
	FOOTSTEP_WET = list(list(
		'sound/effects/footstep/waterstep1.ogg',
		'sound/effects/footstep/waterstep2.ogg',
		'sound/effects/footstep/water3.ogg'), 100, 1),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 50, 1),
	FOOTSTEP_CATWALK = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 70, 1),
	FOOTSTEP_SNOW = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 70, 1),
	FOOTSTEP_ICE = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 50, 1),
	FOOTSTEP_CONCRETE = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 70, 1),
	FOOTSTEP_GRAVEL = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 55, 1),
	FOOTSTEP_SWIM = list(list(
		'sound/effects/footstep/swimming1.ogg',
		'sound/effects/footstep/swimming2.ogg',
		'sound/effects/footstep/swimming3.ogg'), 100, 1),
	FOOTSTEP_RESIN = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 40, -1),
	FOOTSTEP_HULL = list(list(
		'sound/effects/footstep/alien/large1.ogg',
		'sound/effects/footstep/alien/large2.ogg',
		'sound/effects/footstep/alien/large3.ogg'), 50, 1),
	))

GLOBAL_LIST_INIT(predalienstompy, list(
	FOOTSTEP_GENERIC_HEAVY = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 100, 2),
	FOOTSTEP_WOOD = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 60, 1),
	FOOTSTEP_PLATING = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 70, 1),
	FOOTSTEP_FLOOR = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 70, 1),
	FOOTSTEP_HARD = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 70, 1),
	FOOTSTEP_CARPET = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 55, -1),
	FOOTSTEP_SAND = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 55, 1),
	FOOTSTEP_DIRT = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 55, 1),
	FOOTSTEP_GRASS = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 65, 1),
	FOOTSTEP_WET = list(list(
		'sound/effects/footstep/waterstep1.ogg',
		'sound/effects/footstep/waterstep2.ogg',
		'sound/effects/footstep/water3.ogg'), 100, 1),
	FOOTSTEP_WATER = list(list(
		'sound/effects/footstep/water1.ogg',
		'sound/effects/footstep/water2.ogg',
		'sound/effects/footstep/water3.ogg',
		'sound/effects/footstep/water4.ogg'), 50, 1),
	FOOTSTEP_CATWALK = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 70, 1),
	FOOTSTEP_SNOW = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 70, 1),
	FOOTSTEP_ICE = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 50, 1),
	FOOTSTEP_CONCRETE = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 70, 1),
	FOOTSTEP_GRAVEL = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 55, 1),
	FOOTSTEP_SWIM = list(list(
		'sound/effects/footstep/swimming1.ogg',
		'sound/effects/footstep/swimming2.ogg',
		'sound/effects/footstep/swimming3.ogg'), 70, -1),
	FOOTSTEP_RESIN = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 40, -1),
	FOOTSTEP_HULL = list(list(
		'sound/effects/footstep/alien/medium1.ogg',
		'sound/effects/footstep/alien/medium2.ogg',
		'sound/effects/footstep/alien/medium3.ogg'), 40, -1),
	))
