/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const MAX_VISIBLE_MESSAGES = 2500;
export const MAX_PERSISTED_MESSAGES = 1000;
export const MESSAGE_SAVE_INTERVAL = 10000;
export const MESSAGE_PRUNE_INTERVAL = 60000;
export const COMBINE_MAX_MESSAGES = 5;
export const COMBINE_MAX_TIME_WINDOW = 5000;
export const IMAGE_RETRY_DELAY = 250;
export const IMAGE_RETRY_LIMIT = 10;
export const IMAGE_RETRY_MESSAGE_AGE = 60000;

// Default message type
export const MESSAGE_TYPE_UNKNOWN = 'unknown';

// Internal message type
export const MESSAGE_TYPE_INTERNAL = 'internal';

// Must match the set of defines in code/__DEFINES/chat.dm
export const MESSAGE_TYPE_SYSTEM = 'system';
export const MESSAGE_TYPE_LOCALCHAT = 'localchat';
export const MESSAGE_TYPE_RADIO = 'radio';
export const MESSAGE_TYPE_INFO = 'info';
export const MESSAGE_TYPE_WARNING = 'warning';
export const MESSAGE_TYPE_DEADCHAT = 'deadchat';
export const MESSAGE_TYPE_OOC = 'ooc';
export const MESSAGE_TYPE_ADMINPM = 'adminpm';
export const MESSAGE_TYPE_COMBAT = 'combat';
export const MESSAGE_TYPE_ADMINCHAT = 'adminchat';
export const MESSAGE_TYPE_MENTORCHAT = 'mentorchat';
export const MESSAGE_TYPE_PRAYER = 'prayer';
export const MESSAGE_TYPE_ADMINLOG = 'adminlog';
export const MESSAGE_TYPE_STAFFLOG = 'stafflog';
export const MESSAGE_TYPE_ATTACKLOG = 'attacklog';
export const MESSAGE_TYPE_DEBUG = 'debug';

// Metadata for each message type
export const MESSAGE_TYPES = [
  // Always-on types
  {
    type: MESSAGE_TYPE_SYSTEM,
    name: 'System Messages',
    description: 'Messages from your client, always enabled',
    selector: '.boldannounce',
    important: true,
  },
  // Basic types
  {
    type: MESSAGE_TYPE_LOCALCHAT,
    name: 'Local',
    description: 'In-character local messages (say, emote, etc)',
    selector: '.say, .emote',
  },
  {
    type: MESSAGE_TYPE_RADIO,
    name: 'Radio',
    description: 'All departments of radio messages',
    selector:
      '.radio, .deptradio, .syndradio, .comradio, .casradio, .engradio, .medradio, .sciradio, .supradio, .alpharadio, .bravoradio, .charlieradio, .deltaradio, .zuluradio, .yankeeradio, .xrayradio, .whiskeyradio, .newscaster, .binarysay, .hivemind, .yautjaradio',
  },
  {
    type: MESSAGE_TYPE_INFO,
    name: 'Info',
    description: 'Non-urgent messages from the game and items',
    selector:
      '.notice, .xenonotice, .boldnotice, .adminnotice, .info, .cult, .infoplain',
  },
  {
    type: MESSAGE_TYPE_WARNING,
    name: 'Warnings',
    description:
      'Urgent messages from the game and items, usually combat messages',
    selector:
      '.alert, .warning, .boldwarning, .xenowarning, .danger, .xenodanger, .userdanger, .xenouserdanger, .xenoannounce, .xenobanishtitleannonce, .xenobanishannonce',
  },
  {
    type: MESSAGE_TYPE_DEADCHAT,
    name: 'Deadchat',
    description: 'All of deadchat',
    selector: '.deadsay',
  },
  {
    type: MESSAGE_TYPE_OOC,
    name: 'OOC',
    description: 'OOC messages, admin announcements and round announcements',
    selector:
      '.ooc, .colorooc, .looc, .adminooc, .hostooc, .projleadooc, .headcoderooc, .headminooc, .headmentorooc, .trialminooc, .candiminooc, .mentorooc, .maintainerooc, .contributorooc, .otherooc, .ooc_alert_ooc, .ooc_alert_game',
  },
  {
    type: MESSAGE_TYPE_ADMINPM,
    name: 'Staff PMs',
    description: 'Messages to/from staff (adminhelp/mentorhelp)',
    selector: '.staffpmin, .staffpmout, .adminhelp, .adminnotice',
  },
  {
    type: MESSAGE_TYPE_COMBAT,
    name: 'Combat Log',
    description: 'Urist McTraitor has stabbed you with a knife!',
    selector:
      '.danger, .userdanger, .xenodanger, .xenouserdanger, .attack, .moderate, .disarm, .passive',
  },
  {
    type: MESSAGE_TYPE_UNKNOWN,
    name: 'Unsorted',
    description: 'Everything we could not sort, always enabled',
  },
  // Admin stuff
  {
    type: MESSAGE_TYPE_ADMINCHAT,
    name: 'Admin Chat',
    description: 'ASAY messages',
    selector: '.admin, .asay, .headminasay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_MENTORCHAT,
    name: 'Mentor Chat',
    description: 'MSAY messages',
    selector: '.msay, .adminmsay, .headminmsay',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_PRAYER,
    name: 'Prayers',
    description: 'Prayers from players',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ADMINLOG,
    name: 'Admin Log',
    description: 'ADMIN LOG: Urist McAdmin has jumped to coordinates X, Y, Z',
    selector: '.log_message',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_STAFFLOG,
    name: 'Staff Log',
    description: 'STAFF LOG: 5Head has solved the mentor ticket #1',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_ATTACKLOG,
    name: 'Attack Log',
    description: 'Urist McTraitor has shot John Doe',
    admin: true,
  },
  {
    type: MESSAGE_TYPE_DEBUG,
    name: 'Debug Log',
    description: 'DEBUG: SSPlanets subsystem Recover().',
    admin: true,
  },
];
