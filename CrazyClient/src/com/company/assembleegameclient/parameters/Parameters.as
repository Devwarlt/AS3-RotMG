﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.parameters.Parameters

package com.company.assembleegameclient.parameters
{
    import flash.display.DisplayObject;
    import flash.net.SharedObject;
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;
    import com.company.util.KeyCodes;
    import com.company.assembleegameclient.map.Map;
    import flash.events.Event;
    import com.company.util.MoreDateUtil;
    import flash.display.StageScaleMode;

    public class Parameters 
    {

        public static const BUILD_VERSION:String = "X22.0";
        public static const MINOR_VERSION:String = "0";
        public static const CRAZY_VERSION:String = "Hotfix v420";//"v420"
        public static const ENABLE_ENCRYPTION:Boolean = true;
        public static const PORT:int = 2050;
        public static const ALLOW_SCREENSHOT_MODE:Boolean = true;
        public static const FELLOW_GUILD_COLOR:uint = 10944349;
        public static const NAME_CHOSEN_COLOR:uint = 0xFCDF00;
        public static var root:DisplayObject;
        public static var PLAYER_ROTATE_SPEED:Number = 0.003;
        public static const BREATH_THRESH:int = 20;
        public static const SERVER_CHAT_NAME:String = "";
        public static const CLIENT_CHAT_NAME:String = "*Client*";
        public static const ERROR_CHAT_NAME:String = "*Error*";
        public static const HELP_CHAT_NAME:String = "*Help*";
        public static const GUILD_CHAT_NAME:String = "*Guild*";
        public static const NEWS_TIMESTAMP_DEFAULT:Number = 1.1;
        public static const NAME_CHANGE_PRICE:int = 1000;
        public static const GUILD_CREATION_PRICE:int = 1000;
        public static var data_:Object = null;
        public static var GPURenderError:Boolean = false;
        public static var blendType_:int = 1;
        public static var projColorType_:int = 0;
        public static var drawProj_:Boolean = true;
        public static var screenShotMode_:Boolean = false;
        public static var screenShotSlimMode_:Boolean = false;
        public static var sendLogin_:Boolean = true;
        public static const TUTORIAL_GAMEID:int = -1;
        public static const NEXUS_GAMEID:int = -2;
        public static const RANDOM_REALM_GAMEID:int = -3;
        public static const VAULT_GAMEID:int = -5;
        public static const MAPTEST_GAMEID:int = -6;
        public static const DAILYQUESTROOM_GAMEID:int = -11;
        public static const MAX_SINK_LEVEL:Number = 18;
        public static const TERMS_OF_USE_URL:String = "";
        public static const PRIVACY_POLICY_URL:String = "";
        public static const USER_GENERATED_CONTENT_TERMS:String = "";
        public static const RANDOM1:String = "311f80691451c71b09a13a2a6e";
        public static const RANDOM2:String = "72c5583cafb6818995cbd74b80";
        public static const RSA_PUBLIC_KEY:String = ((((("-----BEGIN PUBLIC KEY-----\n" + "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCKFctVrhfF3m2Kes0FBL/JFeO") + "cmNg9eJz8k/hQy1kadD+XFUpluRqa//Uxp2s9W2qE0EoUCu59ugcf/p7lGuL99Uo") + "SGmQEynkBvZct+/M40L0E0rZ4BVgzLOJmIbXMp0J4PnPcb6VLZvxazGcmSfjauC7") + "F3yWYqUbZd/HCBtawwIDAQAB\n") + "-----END PUBLIC KEY-----");
        private static var savedOptions_:SharedObject = null;
        public static var toggleHPBar_:Boolean = false;
        public static const skinTypes16:Vector.<int> = new <int>[1027, 0x0404, 1029, 1030, 10973, 19494, 19531];
        public static const itemTypes16:Vector.<int> = new <int>[5473, 5474, 5475, 5476, 10939, 19494, 19531];
        private static var keyNames_:Dictionary = new Dictionary();


        public static function load():void
        {
            try
            {
                savedOptions_ = SharedObject.getLocal("AssembleeGameClientOptions", "/");
                data_ = savedOptions_.data;
            }
            catch(error:Error)
            {
                data_ = {};
            };
            setDefaults();
            save();
        }

        public static function save():void
        {
            try
            {
                if (savedOptions_ != null)
                {
                    savedOptions_.flush();
                };
            }
            catch(error:Error)
            {
            };
        }

        private static function setDefaultKey(_arg_1:String, _arg_2:uint):void
        {
            if (!data_.hasOwnProperty(_arg_1))
            {
                data_[_arg_1] = _arg_2;
            };
            keyNames_[_arg_1] = true;
        }

        public static function setKey(_arg_1:String, _arg_2:uint):void
        {
            var _local_3:String;
            if (_arg_2 == 0)
            {
                return;
            };
            for (_local_3 in keyNames_)
            {
                if (data_[_local_3] == _arg_2)
                {
                    data_[_local_3] = KeyCodes.UNSET;
                };
            };
            data_[_arg_1] = _arg_2;
        }

        private static function setDefault(_arg_1:String, _arg_2:*):void
        {
            if (!data_.hasOwnProperty(_arg_1))
            {
                data_[_arg_1] = _arg_2;
            };
        }

        public static function isGpuRender():Boolean
        {
            return ((!(GPURenderError)) && (!(Map.forceSoftwareRender)));
        }

        public static function clearGpuRenderEvent(_arg_1:Event):void
        {
            clearGpuRender();
        }

        public static function clearGpuRender():void
        {
            GPURenderError = true;
        }

        public static function setDefaults():void
        {
            setDefaultKey("moveLeft", KeyCodes.A);
            setDefaultKey("moveRight", KeyCodes.D);
            setDefaultKey("moveUp", KeyCodes.W);
            setDefaultKey("moveDown", KeyCodes.S);
            setDefaultKey("rotateLeft", KeyCodes.Q);
            setDefaultKey("rotateRight", KeyCodes.E);
            setDefaultKey("useSpecial", KeyCodes.SPACE);
            setDefaultKey("interact", KeyCodes.NUMBER_0);
            setDefaultKey("useInvSlot1", KeyCodes.NUMBER_1);
            setDefaultKey("useInvSlot2", KeyCodes.NUMBER_2);
            setDefaultKey("useInvSlot3", KeyCodes.NUMBER_3);
            setDefaultKey("useInvSlot4", KeyCodes.NUMBER_4);
            setDefaultKey("useInvSlot5", KeyCodes.NUMBER_5);
            setDefaultKey("useInvSlot6", KeyCodes.NUMBER_6);
            setDefaultKey("useInvSlot7", KeyCodes.NUMBER_7);
            setDefaultKey("useInvSlot8", KeyCodes.NUMBER_8);
            setDefaultKey("escapeToNexus2", KeyCodes.F5);
            setDefaultKey("escapeToNexus", KeyCodes.R);
            setDefaultKey("autofireToggle", KeyCodes.I);
            setDefaultKey("scrollChatUp", KeyCodes.PAGE_UP);
            setDefaultKey("scrollChatDown", KeyCodes.PAGE_DOWN);
            setDefaultKey("miniMapZoomOut", KeyCodes.MINUS);
            setDefaultKey("miniMapZoomIn", KeyCodes.EQUAL);
            setDefaultKey("resetToDefaultCameraAngle", KeyCodes.Z);
            setDefaultKey("togglePerformanceStats", KeyCodes.UNSET);
            setDefaultKey("options", KeyCodes.O);
            setDefaultKey("toggleCentering", KeyCodes.UNSET);
            setDefaultKey("chat", KeyCodes.ENTER);
            setDefaultKey("chatCommand", KeyCodes.SLASH);
            setDefaultKey("tell", KeyCodes.TAB);
            setDefaultKey("guildChat", KeyCodes.G);
            setDefaultKey("testOne", KeyCodes.PERIOD);
            setDefaultKey("toggleFullscreen", KeyCodes.UNSET);
            setDefaultKey("useHealthPotion", KeyCodes.F);
            setDefaultKey("GPURenderToggle", KeyCodes.UNSET);
            setDefaultKey("friendList", KeyCodes.UNSET);
            setDefaultKey("useMagicPotion", KeyCodes.V);
            setDefaultKey("switchTabs", KeyCodes.B);
            setDefaultKey("particleEffect", KeyCodes.P);
            setDefaultKey("toggleHPBar", KeyCodes.H);
            setDefault("playerObjectType", 782);
            setDefault("playMusic", true);
            setDefault("playSFX", true);
            setDefault("playPewPew", true);
            setDefault("centerOnPlayer", true);
            setDefault("preferredServer", null);
            setDefault("cameraAngle", ((7 * Math.PI) / 4));
            setDefault("defaultCameraAngle", ((7 * Math.PI) / 4));
            setDefault("showQuestPortraits", true);
            setDefault("fullscreenMode", false);
            setDefault("showProtips", true);
            setDefault("protipIndex", 0);
            setDefault("joinDate", MoreDateUtil.getDayStringInPT());
            setDefault("lastDailyAnalytics", null);
            setDefault("allowRotation", false);
            setDefault("allowMiniMapRotation", false);
            setDefault("charIdUseMap", {});
            setDefault("drawShadows", true);
            setDefault("textBubbles", true);
            setDefault("showTradePopup", true);
            setDefault("paymentMethod", null);
            setDefault("filterLanguage", true);
            setDefault("showGuildInvitePopup", true);
            setDefault("showBeginnersOffer", false);
            setDefault("beginnersOfferTimeLeft", 0);
            setDefault("beginnersOfferShowNow", false);
            setDefault("beginnersOfferShowNowTime", 0);
            setDefault("watchForTutorialExit", false);
            setDefault("clickForGold", false);
            setDefault("contextualPotionBuy", false);
            setDefault("inventorySwap", true);
            setDefault("particleEffect", true);
            setDefault("uiQuality", true);
            setDefault("cursorSelect", "4");
            setDefault("friendListDisplayFlag", false);
            setDefault("forceChatQuality", false);
            setDefault("hidePlayerChat", false);
            setDefault("chatStarRequirement", 13);
            setDefault("chatAll", true);
            setDefault("chatWhisper", true);
            setDefault("chatGuild", true);
            setDefault("chatTrade", true);
            setDefault("rotateSpeed", 3);
            setDefault("normalUI", false);
            setDefault("uiShadow", false);
            if (((data_.hasOwnProperty("playMusic")) && (data_.playMusic == true)))
            {
                setDefault("musicVolume", 1);
            }
            else
            {
                setDefault("musicVolume", 0);
            };
            if (((data_.hasOwnProperty("playSFX")) && (data_.playMusic == true)))
            {
                setDefault("SFXVolume", 1);
            }
            else
            {
                setDefault("SFXVolume", 0);
            };
            setDefault("friendList", KeyCodes.UNSET);
            setDefault("tradeWithFriends", false);
            setDefault("chatFriend", false);
            setDefault("friendStarRequirement", 0);
            setDefault("HPBar", true);
            setDefault("toggleBarText", false);
            setDefault("disableEnemyParticles", false);
            setDefault("disableAllyParticles", false);
            setDefault("disablePlayersHitParticles", false);
            setDefault("toggleToMaxText", false);
            setDefault("noParticlesMaster", false);
            setDefault("noAllyNotifications", false);
            setDefault("noEnemyDamage", false);
            setDefault("noAllyDamage", false);
            setDefault("forceEXP", false);
            setDefault("stageScale", StageScaleMode.NO_SCALE);
            setDefault("uiscale", false);
            setDefault("removeParticles", true);
            setDefault("drawProjectiles", true);
            setDefault("filterZeroStar", true);
            setDefault("tombAim", false);
            setDefault("activateSpellBomb", true);
            setDefault("dbBlind", false);
            setDefault("dbConfused", false);
            setDefault("dbDarkness", false);
            setDefault("dbDrunk", false);
            setDefault("dbHallucinating", false);
            setDefault("dbQuiet", false);
            setDefault("dbWeak", false);
            setDefault("dbSlowed", false);
            setDefault("dbSick", false);
            setDefault("dbDazed", false);
            setDefault("dbStunned", false);
            setDefault("dbParalyzed", false);
            setDefault("dbBleeding", false);
            setDefault("dbArmorBroken", false);
            setDefault("dbUnstable", false);
            setDefault("dbQuietCastle", true);
            setDefault("dbUnstableAbil", false);
            setDefault("dbPetStasis", false);
            setDefault("dbPetrify", false);
            setDefaultKey("AAHotkey", KeyCodes.N);
            setDefaultKey("AAModeHotkey", KeyCodes.M);
            setDefault("AATargetLead", true);
            setDefault("AAOn", false);
            setDefault("STDamage", false);
            setDefault("STHealth", true);
            setDefault("STColor", true);
            setDefault("LNAbility", 6);
            setDefault("LNRing", 6);
            setDefault("LNWeap", 12);
            setDefault("LNArmor", 13);
            setDefault("AutoLootOn", true);
            setDefault("showLootNotifs", true);
            setDefault("NoLoot", ["common", "tincture", "mark"]);
            setDefault("pots2inv", true);
            setDefault("potsMinor", true);
            setDefault("potsMajor", true);
            setDefault("lootHP", false);
            setDefault("lootMP", false);
            setDefaultKey("ReconRealm", KeyCodes.P);
            setDefaultKey("ReconDung", KeyCodes.K);
            setDefaultKey("ReconVault", KeyCodes.V);
            setDefaultKey("ReconRandom", KeyCodes.UNSET);
            setDefault("AutoNexus", 20);
            setDefault("NoClip", false);
            setDefault("NumericalHP", true);
            setDefault("PassesCover", true);
            setDefault("HidePlayerFilter", false);
            setDefault("hideLockList", false);
            setDefault("TradeDelay", true);
            setDefault("lockHighlight", true);
            setDefault("SafeWalk", false);
            setDefault("InvViewer", true);
            setDefault("StatsViewer", true);
            setDefault("aimMode", 1);
            setDefault("AAStasis", false);
            setDefault("AAInvincible", false);
            setDefault("AAInvulnerable", false);
            setDefault("AAInvulnerableQuest", false);
            setDefault("AAAddOne", false);
            setDefault("AABoundingDist", 20);
            setDefault("showMobInfo", false);
            setDefault("AAException", [3414, 3417, 3448, 3449, 3472, 3334, 5952, 2354, 2369, 3368, 3366, 3367, 3391, 3389, 3390, 5920, 2314, 3412, 3639, 3634, 2327, 1755, 24582, 24351, 24363, 24135, 24133, 24134, 24132, 24136, 3356, 3357, 3358, 3359, 3360, 3361, 3362, 3363, 3364, 2352, 28780, 28781, 28795, 28942, 28957, 28988, 28938, 29291, 29018, 29517, 24338, 29580, 29712, 6282, 29054, 29308, 29309, 29550, 29551, 29258, 29259, 29260, 29261, 29262]);
            setDefault("AAIgnore", [1550, 1551, 1552, 1619, 1715, 2309, 2310, 2311, 2371, 3441, 2312, 0x0909, 2370, 2392, 2393, 2400, 2401, 3335, 3336, 3337, 3338, 3413, 3418, 3419, 3420, 3421, 3427, 3454, 3638, 3645, 6157, 28715, 28716, 28717, 28718, 28719, 28730, 28731, 28732, 28733, 28734, 29306, 29568, 29594, 29597, 29710, 29711, 29742, 29743, 29746, 29748, 30001, 29752, 43702, 43708, 43709, 43710, 3389, 3390, 3391, 24223, 0x0900, 2305, 2306, 0x0600, 1537, 1538, 1539, 1540]);
            setDefault("AAPriority", [29054, 29308, 29309, 29550, 29551, 29258, 29259, 29260, 29261, 29262, 6282, 1646]);
            setDefault("damageIgnored", false);
            setDefault("QuestToolTipMod", true);
            setDefault("SkipRender", false);
            setDefaultKey("SkipRenderKey", KeyCodes.UNSET);
            setDefault("AntiLag", true);
            setDefault("bestServ", "Default");
            setDefault("showSkins", true);
            setDefault("showPests", true);
            setDefault("sizer", true);
            setDefaultKey("enterPortal", KeyCodes.UNSET);
            setDefault("perfectBomb", true);
            setDefault("perfectQuiv", true);
            setDefault("perfectStun", false);
            setDefault("perfectLead", true);
            setDefault("spellVoid", false);
            setDefault("tombHack", true);
            setDefault("curBoss", 3368);
            setDefaultKey("tombCycle", KeyCodes.UNSET);
            setDefaultKey("incFinder", KeyCodes.UNSET);
            setDefaultKey("Beekey", KeyCodes.UNSET);
            setDefaultKey("maxPrism", KeyCodes.UNSET);
            setDefaultKey("tpto", KeyCodes.UNSET);
            setDefaultKey("pbToggle", KeyCodes.UNSET);
            setDefault("clientSwap", true);
            setDefault("slideOnIce", false);
            setDefault("autoAbil", false);
            setDefault("autoHealP", 60);
            setDefault("autoPot", 60);
            setDefault("autoMana", 0);
            setDefault("servName", null);
            setDefault("servAddr", null);
            setDefault("reconGID", null);
            setDefault("reconTime", null);
            setDefault("reconKey", null);
            setDefault("dservName", null);
            setDefault("dservAddr", null);
            setDefault("dreconGID", null);
            setDefault("dreconTime", null);
            setDefault("dreconKey", null);
            setDefault("msg1", "black");
            setDefault("msg2", "ready");
            setDefault("msg3", "skip");
            setDefaultKey("msg1key", KeyCodes.UNSET);
            setDefaultKey("msg2key", KeyCodes.UNSET);
            setDefaultKey("msg3key", KeyCodes.UNSET);
            setDefault("spamFilter", ["realmk!ngs", "oryx.ln", "realmpower.net", "oryxsh0p.net", "lifepot. org"]);
            setDefault("oryxcalls", ["testx", "Skull_Shrine.new", "Pentaract.new", "Cube_God.new", "Ghost_Ship.new", "shtrs_Defense_System.new", "Grand_Sphinx.new", "Hermit_God.new", "Temple_Encounter.new", "Lord_of_the_Lost_Lands.new", "Dragon_Head_Leader.new", "LH_Lost_Sentry.new"]);
            setDefault("friendList2", []);
            setDefault("tptoList", ["lab", "manor", "sew"]);
            setDefault("lootIgnore", [9018, 9019, 9020, 9021, 9022, 9023, 9024, 9025, 3861, 2635, 7718, 7719, 7720, 7722, 7727, 7730]);
            setDefault("wMenu", true);
            setDefault("conCom", "/con");
            setDefault("dbPre1", ["Preset 1", 0, false]);
            setDefault("dbPre2", ["Preset 2", 0, false]);
            setDefault("dbPre3", ["Preset 3", 0, false]);
            setDefaultKey("kdbArmorBroken", KeyCodes.UNSET);
            setDefaultKey("kdbBleeding", KeyCodes.UNSET);
            setDefaultKey("kdbDazed", KeyCodes.UNSET);
            setDefaultKey("kdbParalyzed", KeyCodes.UNSET);
            setDefaultKey("kdbSick", KeyCodes.UNSET);
            setDefaultKey("kdbSlowed", KeyCodes.UNSET);
            setDefaultKey("kdbStunned", KeyCodes.UNSET);
            setDefaultKey("kdbWeak", KeyCodes.UNSET);
            setDefaultKey("kdbQuiet", KeyCodes.UNSET);
            setDefaultKey("kdbPetStasis", KeyCodes.UNSET);
            setDefaultKey("kdbPetrify", KeyCodes.UNSET);
            setDefaultKey("kdbPre1", KeyCodes.UNSET);
            setDefaultKey("kdbPre2", KeyCodes.UNSET);
            setDefaultKey("kdbPre3", KeyCodes.UNSET);
            setDefaultKey("kdbAll", KeyCodes.UNSET);
            setDefaultKey("resetCHP", KeyCodes.UNSET);
            setDefault("autoCorrCHP", false);
            setDefaultKey("tPassCover", KeyCodes.UNSET);
            setDefaultKey("Cam45DegInc", KeyCodes.UNSET);
            setDefaultKey("Cam45DegDec", KeyCodes.UNSET);
            setDefaultKey("cam2quest", KeyCodes.UNSET);
            setDefault("rclickTp", false);
            setDefault("autoTp", true);
            setDefault("spriteId", 0);
            setDefault("questClosest", true);
            setDefault("drinkPot", true);
            setDefault("deactPre", true);
            setDefault("ninjaTap", true);
            setDefault("palaSpam", true);
            setDefault("grandmaMode", false);
            setDefault("speedy", false);
            setDefault("setTex1", 0);
            setDefault("setTex2", 0);
            setDefault("nsetSkin", ["", -1]);
            setDefault("showDyes", true);
            setDefault("inaccurate", false);
            setDefault("priestAA", false);
            setDefault("abilTimer", true);
            setDefault("instaSelect", false);
            setDefault("dbAll", false);
            setDefault("thunderMove", false);
            setDefault("mapHack", false);
            setDefault("eventnotify", false);
            setDefault("sneakymode", false);
            setDefaultKey("keyFinder", KeyCodes.UNSET);
            setDefault("keyFinderid", 0);
            setDefault("urlbasestr", "you suck");
            setDefault("bDebug", false);
            setDefault("keynoti", false);
            setDefault("teehee", false);
        }


    }
}//package com.company.assembleegameclient.parameters

