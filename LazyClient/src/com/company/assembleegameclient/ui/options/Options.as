﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.options.Options

package com.company.assembleegameclient.ui.options
{
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.screens.TitleMenuOption;
import com.company.assembleegameclient.sound.Music;
import com.company.assembleegameclient.sound.SFX;
import com.company.assembleegameclient.ui.StatusBar;
import com.company.rotmg.graphics.ScreenGraphic;
import com.company.util.AssetLibrary;
import com.company.util.KeyCodes;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.filters.DropShadowFilter;
import flash.geom.Point;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.navigateToURL;
import flash.system.Capabilities;
import flash.text.TextFieldAutoSize;
import flash.ui.Mouse;
import flash.ui.MouseCursor;
import flash.ui.MouseCursorData;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.game.view.components.StatView;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.UIUtils;
import kabam.rotmg.ui.signals.ToggleShowTierTagSignal;

public class Options extends Sprite
    {

        private static const TABS:Vector.<String> = new <String>[TextKey.OPTIONS_CONTROLS, TextKey.OPTIONS_HOTKEYS, TextKey.OPTIONS_CHAT, TextKey.OPTIONS_GRAPHICS, TextKey.OPTIONS_SOUND, TextKey.OPTIONS_FRIEND, TextKey.OPTIONS_MISC, "Hacks", "Experimental"];
        private static const hackTabs:Vector.<String> = new <String>["Hacks", "Hack Options", "Hack Keys"];
        public static const Y_POSITION:int = 550;
        public static const CHAT_COMMAND:String = "chatCommand";
        public static const CHAT:String = "chat";
        public static const TELL:String = "tell";
        public static const GUILD_CHAT:String = "guildChat";
        public static const SCROLL_CHAT_UP:String = "scrollChatUp";
        public static const SCROLL_CHAT_DOWN:String = "scrollChatDown";
        private static var registeredCursors:Vector.<String> = new Vector.<String>(0);

        private var gs_:GameSprite;
        private var continueButton_:TitleMenuOption;
        private var resetToDefaultsButton_:TitleMenuOption;
        private var homeButton_:TitleMenuOption;
        private var tabs_:Vector.<OptionsTabTitle> = new Vector.<OptionsTabTitle>();
        private var selected_:OptionsTabTitle = null;
        private var options_:Vector.<Sprite> = new Vector.<Sprite>();
        private var autoNexusArray:Array;
        private var nextHackTab_:int = 0;
        private var hackTabX:int = -1;

        public function Options(_arg_1:GameSprite)
        {
            var _local_2:TextFieldDisplayConcrete;
            var _local_6:int;
            var _local_7:OptionsTabTitle;
            super();
            this.gs_ = _arg_1;
            graphics.clear();
            graphics.beginFill(0x2B2B2B, 0.8);
            graphics.drawRect(0, 0, 800, 600);
            graphics.endFill();
            graphics.lineStyle(1, 0x5E5E5E);
            graphics.moveTo(0, 100);
            graphics.lineTo(800, 100);
            graphics.lineStyle();
            _local_2 = new TextFieldDisplayConcrete().setSize(36).setColor(0xFFFFFF);
            _local_2.setBold(true);
            _local_2.setStringBuilder(new LineBuilder().setParams(TextKey.OPTIONS_TITLE));
            _local_2.setAutoSize(TextFieldAutoSize.CENTER);
            _local_2.filters = [new DropShadowFilter(0, 0, 0)];
            _local_2.x = ((800 / 2) - (_local_2.width / 2));
            _local_2.y = 8;
            addChild(_local_2);
            addChild(new ScreenGraphic());
            this.continueButton_ = new TitleMenuOption(TextKey.OPTIONS_CONTINUE_BUTTON, 36, false);
            this.continueButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.continueButton_.setAutoSize(TextFieldAutoSize.CENTER);
            this.continueButton_.addEventListener(MouseEvent.CLICK, this.onContinueClick);
            addChild(this.continueButton_);
            this.resetToDefaultsButton_ = new TitleMenuOption(TextKey.OPTIONS_RESET_TO_DEFAULTS_BUTTON, 22, false);
            this.resetToDefaultsButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.resetToDefaultsButton_.setAutoSize(TextFieldAutoSize.LEFT);
            this.resetToDefaultsButton_.addEventListener(MouseEvent.CLICK, this.onResetToDefaultsClick);
            addChild(this.resetToDefaultsButton_);
            this.homeButton_ = new TitleMenuOption(TextKey.OPTIONS_HOME_BUTTON, 22, false);
            this.homeButton_.setVerticalAlign(TextFieldDisplayConcrete.MIDDLE);
            this.homeButton_.setAutoSize(TextFieldAutoSize.RIGHT);
            this.homeButton_.addEventListener(MouseEvent.CLICK, this.onHomeClick);
            addChild(this.homeButton_);
            var _local_3:int = 14;
            var _local_4:int = 0;
            while (_local_4 < TABS.length)
            {
                if (((!Parameters.data_.showHacks) && (TABS[_local_4] == "Hacks")) || ((!UIUtils.SHOW_EXPERIMENTAL_MENU) && (TABS[_local_4] == "Experimental")))
                {
                    _local_4++;
                    continue;
                }
                _local_7 = new OptionsTabTitle(TABS[_local_4]);
                _local_7.x = _local_3;
                _local_7.y = 70;
                addChild(_local_7);
                _local_7.addEventListener(MouseEvent.CLICK, this.onTabClick);
                this.tabs_.push(_local_7);
                _local_3 = (_local_3 + ((UIUtils.SHOW_EXPERIMENTAL_MENU) ? ((Parameters.data_.showHacks) ? 80 : 90) : ((Parameters.data_.showHacks) ? 98 : 108)));
                _local_4++;
            }
            addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            var _local_5:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
            _local_5.dispatch();
        }

        private static function makePotionBuy():ChoiceOption
        {
            return (new ChoiceOption("contextualPotionBuy", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CONTEXTUAL_POTION_BUY, TextKey.OPTIONS_CONTEXTUAL_POTION_BUY_DESC, null));
        }

        private static function makeOnOffLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_ON), makeLineBuilder(TextKey.OPTIONS_OFF)]);
        }

        private static function makeHighLowLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("High"), new StaticStringBuilder("Low")]);
        }

        private static function makeHpBarLabels():Vector.<StringBuilder>{
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("All"), new StaticStringBuilder("Enemy"), new StaticStringBuilder("Self & En."), new StaticStringBuilder("Self"), new StaticStringBuilder("Ally")]);
        }

        private static function makeForceExpLabels():Vector.<StringBuilder>{
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("On"), new StaticStringBuilder("Self")]);
        }

        private static function makeAllyShootLabels():Vector.<StringBuilder>{
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("All"), new StaticStringBuilder("Proj")]);
        }

        private static function makeBarTextLabels():Vector.<StringBuilder>{
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("All"), new StaticStringBuilder("Fame"), new StaticStringBuilder("HP/MP")]);
        }

        private static function makeStarSelectLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("1"), new StaticStringBuilder("2"), new StaticStringBuilder("3"), new StaticStringBuilder("5"), new StaticStringBuilder("10")]);
        }

        private static function makeCursorSelectLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder("ProX"), new StaticStringBuilder("X2"), new StaticStringBuilder("X3"), new StaticStringBuilder("X4"), new StaticStringBuilder("Corner1"), new StaticStringBuilder("Corner2"), new StaticStringBuilder("Symb"), new StaticStringBuilder("Alien"), new StaticStringBuilder("Xhair"), new StaticStringBuilder("Chusto1"), new StaticStringBuilder("Chusto2")]);
        }

        private function autoNexusValues():Vector.<StringBuilder>
        {
            //new StaticStringBuilder(((Parameters.data_.autoNexus == 0) ? "Off" : (Parameters.data_.autoNexus + "%")))
            return (new <StringBuilder>[new StaticStringBuilder("Off"), new StaticStringBuilder(this.autoNexusArray[1] + "%"), new StaticStringBuilder(this.autoNexusArray[2] + "%"), new StaticStringBuilder(this.autoNexusArray[3] + "%"), new StaticStringBuilder(this.autoNexusArray[4] + "%"), new StaticStringBuilder(this.autoNexusArray[5] + "%"), new StaticStringBuilder(this.autoNexusArray[6] + "%"), ((this.autoNexusArray.length == 8) ? new StaticStringBuilder(this.autoNexusArray[7] + "%") : null)]);
        }

        private static function makeConfuseRecoveryLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("0"), new StaticStringBuilder("0-5"), new StaticStringBuilder("3-8"), new StaticStringBuilder("5-10"), new StaticStringBuilder("10-15")]);
        }

        private static function makeConnectLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("/con"), new StaticStringBuilder("/conn")]);
        }

        private static function autoAimRangeValues():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("-.5"), new StaticStringBuilder("0"), new StaticStringBuilder(".5"), new StaticStringBuilder("1")]);
        }

        private static function makeAimReactionLabels():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("0"), new StaticStringBuilder("0-8"), new StaticStringBuilder("5-13"), new StaticStringBuilder("10-18"), new StaticStringBuilder("15-23"), new StaticStringBuilder("20-28")]);
        }

        private function showEnemyID_():void
        {
            if (((!(Parameters.data_.showEnemyID)) && (!(this.gs_.map.mapOverlay_ == null))))
            {
                this.gs_.map.mapOverlay_.removeChildren(0);
            }
        }

        private static function makeLineBuilder(_arg_1:String):LineBuilder
        {
            return (new LineBuilder().setParams(_arg_1));
        }

        private static function makeClickForGold():ChoiceOption
        {
            return (new ChoiceOption("clickForGold", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CLICK_FOR_GOLD, TextKey.OPTIONS_CLICK_FOR_GOLD_DESC, null));
        }

        private static function onUIQualityToggle():void
        {
            UIUtils.toggleQuality(Parameters.data_.uiQuality);
        }

        private static function onBarTextToggle():void
        {
            StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
        }

        private static function onToMaxTextToggle():void
        {
            StatusBar.barTextSignal.dispatch(Parameters.data_.toggleBarText);
            StatView.toMaxTextSignal.dispatch(Parameters.data_.toggleToMaxText);
        }

        public static function refreshCursor():void
        {
            var _local_1:MouseCursorData;
            var _local_2:Vector.<BitmapData>;
            if (((!(Parameters.data_.cursorSelect == MouseCursor.AUTO)) && (registeredCursors.indexOf(Parameters.data_.cursorSelect) == -1)))
            {
                _local_1 = new MouseCursorData();
                _local_1.hotSpot = new Point(15, 15);
                _local_2 = new Vector.<BitmapData>(1, true);
                _local_2[0] = AssetLibrary.getImageFromSet("cursorsEmbed", int(Parameters.data_.cursorSelect));
                _local_1.data = _local_2;
                Mouse.registerCursor(Parameters.data_.cursorSelect, _local_1);
                registeredCursors.push(Parameters.data_.cursorSelect);
            }
            Mouse.cursor = Parameters.data_.cursorSelect;
        }

        private static function makeDegreeOptions():Vector.<StringBuilder>
        {
            return (new <StringBuilder>[new StaticStringBuilder("45°"), new StaticStringBuilder("0°")]);
        }

        private static function onDefaultCameraAngleChange():void
        {
            Parameters.data_.cameraAngle = Parameters.data_.defaultCameraAngle;
            Parameters.save();
        }


        private function onContinueClick(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function onResetToDefaultsClick(_arg_1:MouseEvent):void
        {
            var _local_3:BaseOption;
            var _local_2:int;
            while (_local_2 < this.options_.length)
            {
                _local_3 = (this.options_[_local_2] as BaseOption);
                if (_local_3 != null)
                {
                    delete Parameters.data_[_local_3.paramName_];
                }
                _local_2++;
            }
            Parameters.setDefaults();
            Parameters.save();
            this.refresh();
        }

        private function onHomeClick(_arg_1:MouseEvent):void
        {
            this.close();
            this.gs_.closed.dispatch();
        }

        private function onTabClick(_arg_1:MouseEvent):void
        {
            var _local_2:OptionsTabTitle = (_arg_1.currentTarget as OptionsTabTitle);
            this.setSelected(_local_2);
        }

        private function setSelected(_arg_1:OptionsTabTitle):void
        {
            var _local_2:Boolean = false;
            if (_arg_1 == this.selected_)
            {
                if (_arg_1.text_ != "Hacks")
                {
                    return;
                }
                this.nextHackTab_ = ((this.nextHackTab_ < (hackTabs.length - 1)) ? (this.nextHackTab_ + 1) : (0));
            }
            if (this.selected_ != null)
            {
                this.selected_.setSelected(false);
            }
            this.selected_ = _arg_1;
            this.selected_.setSelected(true);
            this.removeOptions();
            switch (this.selected_.text_)
            {
                case TextKey.OPTIONS_CONTROLS:
                    this.addControlsOptions();
                    return;
                case TextKey.OPTIONS_HOTKEYS:
                    this.addHotKeysOptions();
                    return;
                case TextKey.OPTIONS_CHAT:
                    this.addChatOptions();
                    return;
                case TextKey.OPTIONS_GRAPHICS:
                    this.addGraphicsOptions();
                    return;
                case TextKey.OPTIONS_SOUND:
                    this.addSoundOptions();
                    return;
                case TextKey.OPTIONS_MISC:
                    this.addMiscOptions();
                    return;
                case TextKey.OPTIONS_FRIEND:
                    this.addFriendOptions();
                    return;
                case "Experimental":
                    this.addExperimentalOptions();
                    return;
                case "Hacks":
                    if (this.hackTabX == -1)
                    {
                        this.hackTabX = this.selected_.x;
                    }
                    this.selected_.textText_.setStringBuilder(new LineBuilder().setParams(hackTabs[this.nextHackTab_]));
                    switch (hackTabs[this.nextHackTab_])
                    {
                        case "Hacks":
                            this.selected_.x = this.hackTabX;
                            this.autoNexusArray = [0, 10, 15, 20, 25, 30, 40];
                            if (this.autoNexusArray.indexOf(Parameters.data_.autoNexus) == -1)
                            {
                                this.autoNexusArray.push(Parameters.data_.autoNexus);
                                this.autoNexusArray.sort(Array.NUMERIC);
                            }
                            this.addHackOptions();
                            break;
                        case "Hack Options":
                            this.selected_.x = this.hackTabX - 30;
                            this.addHackOptionOptions();
                            break;
                        case "Hack Keys":
                            this.selected_.x = this.hackTabX - 16;
                            this.addHackKeyOptions();
                            break;
                    }
                    return;
            }
        }

        private function onAddedToStage(_arg_1:Event):void
        {
            this.continueButton_.x = (stage.stageWidth / 2);
            this.continueButton_.y = Y_POSITION;
            this.resetToDefaultsButton_.x = 20;
            this.resetToDefaultsButton_.y = Y_POSITION;
            this.homeButton_.x = (stage.stageWidth - 20);
            this.homeButton_.y = Y_POSITION;
            if (Capabilities.playerType == "Desktop")
            {
                Parameters.data_.fullscreenMode = (stage.displayState == "fullScreenInteractive");
                Parameters.save();
            }
            this.setSelected(this.tabs_[0]);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false, 1);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false, 1);
        }

        private function onRemovedFromStage(_arg_1:Event):void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown, false);
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp, false);
        }

        private function onKeyDown(_arg_1:KeyboardEvent):void
        {
            if (((Capabilities.playerType == "Desktop") && (_arg_1.keyCode == KeyCodes.ESCAPE)))
            {
                Parameters.data_.fullscreenMode = false;
                Parameters.save();
                this.refresh();
            }
            if (_arg_1.keyCode == Parameters.data_.options)
            {
                this.close();
            }
            _arg_1.stopImmediatePropagation();
        }

        private function close():void
        {
            stage.focus = null;
            parent.removeChild(this);
        }

        private function onKeyUp(_arg_1:KeyboardEvent):void
        {
            _arg_1.stopImmediatePropagation();
        }

        private function removeOptions():void
        {
            var _local_1:Sprite;
            for each (_local_1 in this.options_)
            {
                removeChild(_local_1);
            }
            this.options_.length = 0;
        }

        private function addControlsOptions():void
        {
            this.addOptionAndPosition(new KeyMapper("moveUp", TextKey.OPTIONS_MOVE_UP, TextKey.OPTIONS_MOVE_UP_DESC));
            this.addOptionAndPosition(new KeyMapper("moveLeft", TextKey.OPTIONS_MOVE_LEFT, TextKey.OPTIONS_MOVE_LEFT_DESC));
            this.addOptionAndPosition(new KeyMapper("moveDown", TextKey.OPTIONS_MOVE_DOWN, TextKey.OPTIONS_MOVE_DOWN_DESC));
            this.addOptionAndPosition(new KeyMapper("moveRight", TextKey.OPTIONS_MOVE_RIGHT, TextKey.OPTIONS_MOVE_RIGHT_DESC));
            this.addOptionAndPosition(this.makeAllowCameraRotation());
            this.addOptionAndPosition(this.makeAllowMiniMapRotation());
            this.addOptionAndPosition(new KeyMapper("rotateLeft", TextKey.OPTIONS_ROTATE_LEFT, TextKey.OPTIONS_ROTATE_LEFT_DESC, (!(Parameters.data_.allowRotation))));
            this.addOptionAndPosition(new KeyMapper("rotateRight", TextKey.OPTIONS_ROTATE_RIGHT, TextKey.OPTIONS_ROTATE_RIGHT_DESC, (!(Parameters.data_.allowRotation))));
            this.addOptionAndPosition(new KeyMapper("useSpecial", TextKey.OPTIONS_USE_SPECIAL_ABILITY, TextKey.OPTIONS_USE_SPECIAL_ABILITY_DESC));
            this.addOptionAndPosition(new KeyMapper("autofireToggle", TextKey.OPTIONS_AUTOFIRE_TOGGLE, TextKey.OPTIONS_AUTOFIRE_TOGGLE_DESC));
            this.addOptionAndPosition(new KeyMapper("toggleHPBar", TextKey.OPTIONS_TOGGLE_HPBAR, TextKey.OPTIONS_TOGGLE_HPBAR_DESC));
            this.addOptionAndPosition(new KeyMapper("resetToDefaultCameraAngle", TextKey.OPTIONS_RESET_CAMERA, TextKey.OPTIONS_RESET_CAMERA_DESC));
            this.addOptionAndPosition(new KeyMapper("togglePerformanceStats", TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS, TextKey.OPTIONS_TOGGLE_PERFORMANCE_STATS_DESC));
            this.addOptionAndPosition(new KeyMapper("toggleCentering", TextKey.OPTIONS_TOGGLE_CENTERING, TextKey.OPTIONS_TOGGLE_CENTERING_DESC));
            this.addOptionAndPosition(new KeyMapper("interact", TextKey.OPTIONS_INTERACT_OR_BUY, TextKey.OPTIONS_INTERACT_OR_BUY_DESC));
            this.addOptionAndPosition(makeClickForGold());
            this.addOptionAndPosition(makePotionBuy());
        }

        private function makeAllowCameraRotation():ChoiceOption
        {
            return (new ChoiceOption("allowRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_ROTATION, TextKey.OPTIONS_ALLOW_ROTATION_DESC, this.onAllowRotationChange));
        }

        private function makeAllowMiniMapRotation():ChoiceOption
        {
            return (new ChoiceOption("allowMiniMapRotation", makeOnOffLabels(), [true, false], TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION, TextKey.OPTIONS_ALLOW_MINIMAP_ROTATION_DESC, null));
        }

        private function onAllowRotationChange():void
        {
            var _local_2:KeyMapper;
            var _local_1:int;
            while (_local_1 < this.options_.length)
            {
                _local_2 = (this.options_[_local_1] as KeyMapper);
                if (_local_2 != null)
                {
                    if (((_local_2.paramName_ == "rotateLeft") || (_local_2.paramName_ == "rotateRight")))
                    {
                        _local_2.setDisabled((!(Parameters.data_.allowRotation)));
                    }
                }
                _local_1++;
            }
        }

        private function addHotKeysOptions():void
        {
            this.addOptionAndPosition(new KeyMapper("useHealthPotion", TextKey.OPTIONS_USE_BUY_HEALTH, TextKey.OPTIONS_USE_BUY_HEALTH_DESC));
            this.addOptionAndPosition(new KeyMapper("useMagicPotion", TextKey.OPTIONS_USE_BUY_MAGIC, TextKey.OPTIONS_USE_BUY_MAGIC_DESC));
            this.addInventoryOptions();
            this.addOptionAndPosition(new KeyMapper("miniMapZoomIn", TextKey.OPTIONS_MINI_MAP_ZOOM_IN, TextKey.OPTIONS_MINI_MAP_ZOOM_IN_DESC));
            this.addOptionAndPosition(new KeyMapper("miniMapZoomOut", TextKey.OPTIONS_MINI_MAP_ZOOM_OUT, TextKey.OPTIONS_MINI_MAP_ZOOM_OUT_DESC));
            this.addOptionAndPosition(new KeyMapper("escapeToNexus", TextKey.OPTIONS_ESCAPE_TO_NEXUS, TextKey.OPTIONS_ESCAPE_TO_NEXUS_DESC));
            this.addOptionAndPosition(new KeyMapper("options", TextKey.OPTIONS_SHOW_OPTIONS, TextKey.OPTIONS_SHOW_OPTIONS_DESC));
            this.addOptionAndPosition(new KeyMapper("switchTabs", TextKey.OPTIONS_SWITCH_TABS, TextKey.OPTIONS_SWITCH_TABS_DESC));
            this.addOptionAndPosition(new KeyMapper("GPURenderToggle", TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_TITLE, TextKey.OPTIONS_HARDWARE_ACC_HOTKEY_DESC));
            this.addOptionsChoiceOption();
            if (this.isAirApplication())
            {
                this.addOptionAndPosition(new KeyMapper("toggleFullscreen", TextKey.OPTIONS_TOGGLE_FULLSCREEN, TextKey.OPTIONS_TOGGLE_FULLSCREEN_DESC));
            }
        }

        public function isAirApplication():Boolean
        {
            return (Capabilities.playerType == "Desktop");
        }

        public function addOptionsChoiceOption():void
        {
            var _local_1:String = ((Capabilities.os.split(" ")[0] == "Mac") ? "Command" : "Ctrl");
            var _local_2:ChoiceOption = new ChoiceOption("inventorySwap", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK, "", null);
            _local_2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_SWITCH_ITEM_IN_BACKPACK_DESC, {"key":_local_1}));
            this.addOptionAndPosition(_local_2);
        }

        public function addInventoryOptions():void
        {
            var _local_2:KeyMapper;
            var _local_1:int = 1;
            while (_local_1 <= 8)
            {
                _local_2 = new KeyMapper(("useInvSlot" + _local_1), "", "");
                _local_2.setDescription(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N, {"n":_local_1}));
                _local_2.setTooltipText(new LineBuilder().setParams(TextKey.OPTIONS_INVENTORY_SLOT_N_DESC, {"n":_local_1}));
                this.addOptionAndPosition(_local_2);
                _local_1++;
            }
        }

        private function addChatOptions():void
        {
            this.addOptionAndPosition(new KeyMapper(CHAT, TextKey.OPTIONS_ACTIVATE_CHAT, TextKey.OPTIONS_ACTIVATE_CHAT_DESC));
            this.addOptionAndPosition(new KeyMapper(CHAT_COMMAND, TextKey.OPTIONS_START_CHAT, TextKey.OPTIONS_START_CHAT_DESC));
            this.addOptionAndPosition(new KeyMapper(TELL, TextKey.OPTIONS_BEGIN_TELL, TextKey.OPTIONS_BEGIN_TELL_DESC));
            this.addOptionAndPosition(new KeyMapper(GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT, TextKey.OPTIONS_BEGIN_GUILD_CHAT_DESC));
            this.addOptionAndPosition(new ChoiceOption("filterLanguage", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FILTER_OFFENSIVE_LANGUAGE, TextKey.OPTIONS_FILTER_OFFENSIVE_LANGUAGE_DESC, null));
            this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP, TextKey.OPTIONS_SCROLL_CHAT_UP_DESC));
            this.addOptionAndPosition(new KeyMapper(SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN, TextKey.OPTIONS_SCROLL_CHAT_DOWN_DESC));
            this.addOptionAndPosition(new ChoiceOption("forceChatQuality", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FORCE_CHAT_QUALITY, TextKey.OPTIONS_FORCE_CHAT_QUALITY_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("hidePlayerChat", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HIDE_PLAYER_CHAT, TextKey.OPTIONS_HIDE_PLAYER_CHAT_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("chatStarRequirement", makeStarSelectLabels(), [0, 1, 2, 3, 5, 10], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_CHAT_STAR_REQ_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("chatAll", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_ALL, TextKey.OPTIONS_CHAT_ALL_DESC, this.onAllChatEnabled));
            this.addOptionAndPosition(new ChoiceOption("chatWhisper", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_WHISPER, TextKey.OPTIONS_CHAT_WHISPER_DESC, this.onAllChatDisabled));
            this.addOptionAndPosition(new ChoiceOption("chatGuild", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_GUILD, TextKey.OPTIONS_CHAT_GUILD_DESC, this.onAllChatDisabled));
            this.addOptionAndPosition(new ChoiceOption("chatTrade", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_TRADE, TextKey.OPTIONS_CHAT_TRADE_DESC, null));
        }

        private function onAllChatDisabled():void
        {
            var _local_2:ChoiceOption;
            Parameters.data_.chatAll = false;
            var _local_1:int;
            while (_local_1 < this.options_.length)
            {
                _local_2 = (this.options_[_local_1] as ChoiceOption);
                if (_local_2 != null)
                {
                    switch (_local_2.paramName_)
                    {
                        case "chatAll":
                            _local_2.refreshNoCallback();
                            break;
                    }
                }
                _local_1++;
            }
        }

        private function onAllChatEnabled():void
        {
            var _local_2:ChoiceOption;
            Parameters.data_.hidePlayerChat = false;
            Parameters.data_.chatWhisper = true;
            Parameters.data_.chatGuild = true;
            Parameters.data_.chatFriend = false;
            var _local_1:int;
            while (_local_1 < this.options_.length)
            {
                _local_2 = (this.options_[_local_1] as ChoiceOption);
                if (_local_2 != null)
                {
                    switch (_local_2.paramName_)
                    {
                        case "hidePlayerChat":
                        case "chatWhisper":
                        case "chatGuild":
                        case "chatFriend":
                            _local_2.refreshNoCallback();
                            break;
                    }
                }
                _local_1++;
            }
        }

        private function addExperimentalOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("disableEnemyParticles", makeOnOffLabels(), [true, false], "Disable Enemy Particles", "Disable enemy hit and death particles.", null));
            this.addOptionAndPosition(new ChoiceOption("disableAllyShoot", makeAllyShootLabels(), [0, 1, 2], "Disable Ally Shoot", "Disable showing shooting animations and projectiles shot by allies or only projectiles.", null));
            this.addOptionAndPosition(new ChoiceOption("disablePlayersHitParticles", makeOnOffLabels(), [true, false], "Disable Players Hit Particles", "Disable player and ally hit particles.", null));
            this.addOptionAndPosition(new ChoiceOption("toggleToMaxText", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_TOMAXTEXT, TextKey.OPTIONS_TOGGLE_TOMAXTEXT_DESC, onToMaxTextToggle));
            this.addOptionAndPosition(new ChoiceOption("newMiniMapColors", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TOGGLE_NEWMINIMAPCOLORS, TextKey.OPTIONS_TOGGLE_NEWMINIMAPCOLORS_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("noParticlesMaster", makeOnOffLabels(), [true, false], "Disable Particles Master", "Disable all nonessential particles besides enemy and ally hits. Throw, Area and certain other effects will remain.", null));
            this.addOptionAndPosition(new ChoiceOption("noAllyNotifications", makeOnOffLabels(), [true, false], "Disable Ally Notifications", "Disable text notifications above allies.", null));
            this.addOptionAndPosition(new ChoiceOption("noEnemyDamage", makeOnOffLabels(), [true, false], "Disable Enemy Damage Text", "Disable damage from other players above enemies.", null));
            this.addOptionAndPosition(new ChoiceOption("noAllyDamage", makeOnOffLabels(), [true, false], "Disable Ally Damage Text", "Disable damage above allies.", null));
            this.addOptionAndPosition(new ChoiceOption("forceEXP", makeForceExpLabels(), [0, 1, 2], "Always Show EXP", "Show EXP notifications even when level 20.", null));
            this.addOptionAndPosition(new ChoiceOption("showFameGain", makeOnOffLabels(), [true, false], "Show Fame Gain", "Shows notifications for each fame gained.", null));
            this.addOptionAndPosition(new ChoiceOption("curseIndication", makeOnOffLabels(), [true, false], "Curse Indication", "Makes enemies inflicted by Curse glow red.", null));
        }

        private function addHackOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("autoNexus", autoNexusValues(), this.autoNexusArray, "Auto Nexus", "Not an invitation to play like an idiot.", null));
            //this.addOptionAndPosition(new ChoiceOption("autoAim", makeOnOffLabels(), [true, false], "Auto Aim", "Automatically aim and shoot at enemies.", null));
            this.addOptionAndPosition(new ChoiceOption("lockFilter", makeOnOffLabels(), [true, false], "Lock Filter", "Don't render unlocked players when enabled.", null, ((Parameters.data_.lockFilter) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("petFilter", makeOnOffLabels(), [true, false], "Pet Filter", "Don't render other players' pets when enabled.", null, ((Parameters.data_.petFilter) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("noConfuse", makeOnOffLabels(), [true, false], "No Confuse", "Blocks the confuse status effect when enabled.", null));
            this.addOptionAndPosition(new ChoiceOption("noDrunk", makeOnOffLabels(), [true, false], "No Drunk", "Blocks the drunk status effect when enabled.", null, ((Parameters.data_.noDrunk) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("noHallucinate", makeOnOffLabels(), [true, false], "No Hallucinate", "Blocks the hallucinate status effect when enabled.", null, ((Parameters.data_.noHallucinate) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("noBlind", makeOnOffLabels(), [true, false], "No Blind", "Blocks the blind status effect when enabled.", null, ((Parameters.data_.noBlind) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("noDarkness", makeOnOffLabels(), [true, false], "No Darkness", "Blocks the darkness status effect as much as possible when enabled.", null, ((Parameters.data_.noDarkness) ? 0xFF0000 : 0xFFFFFF), true));
            this.addOptionAndPosition(new ChoiceOption("noUnstableAbility", makeOnOffLabels(), [true, false], "No Unstable Ability", "Blocks the unstable status effect from affecting abilities when enabled.", null, ((Parameters.data_.noUnstableAbility) ? 0xFF0000 : 0xFFFFFF), true));
        }

        private function addHackOptionOptions():void
        {
            ///this.addOptionAndPosition(new ChoiceOption("autoAimExtraRange", autoAimRangeValues(), [-.5, 0, .5, 1], "Auto Aim Extra Range", "Makes Auto Aim shoot when enemies are closer or farther than your weapon's range.", null));
            //this.addOptionAndPosition(new ChoiceOption("autoAimReactionMinMS", makeAimReactionLabels(), [-1, 0, 5, 10, 15, 20], "Aim Reaction (ms)", "Time range in milliseconds that it will take auto aim to react to events.", null))
            this.addOptionAndPosition(new ChoiceOption("confuseRecoveryMinMS", makeConfuseRecoveryLabels(), [-1, 0, 3, 5, 10], "Confuse Recovery (ms)", "Time range in milliseconds that it will take to recover from confuse controls.", null));
            this.addOptionAndPosition(new ChoiceOption("connectCommand", makeConnectLabels(), ["/con", "/conn"], "Connect Command", "Use /conn instead of /con to avoid conflict while using a proxy.", null));
            this.addOptionAndPosition(new ChoiceOption("autoNexusDebug", makeOnOffLabels(), [true, false], "Auto Nexus Debug", "Give debug information to diagnose autonexus.", null));
            this.addOptionAndPosition(new ChoiceOption("showEnemyID", makeOnOffLabels(), [true, false], "Show Enemy ID", "Show enemy name and ID for use with auto aim lists.", this.showEnemyID_));
            this.addOptionAndPosition(new ChoiceOption("quickSwap", makeOnOffLabels(), [true, false], "Quick Swap", "Enables swapping equipment with inventory hotkeys.", null));
            this.addOptionAndPosition(new ChoiceOption("unsafeHackKeys", makeOnOffLabels(), [true, false], "Unsafe Hack Keys", "Register hack keybinds when hacks are hidden.", null));
            this.addOptionAndPosition(new ChoiceOption("vaultOnNewGame", makeOnOffLabels(), [true, false], "Vault Start", "Start the game in your vault.", null));
        }

        private function addHackKeyOptions():void
        {
            this.addOptionAndPosition(new KeyMapper(Parameters.data_.autoAimToggle, "Toggle Auto Aim", "Key to toggle Auto Aim."));
        }

        private function addGraphicsOptions():void
        {
            var _local_1:String;
            var _local_2:Number;
            this.addOptionAndPosition(new ChoiceOption("defaultCameraAngle", makeDegreeOptions(), [((7 * Math.PI) / 4), 0], TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE, TextKey.OPTIONS_DEFAULT_CAMERA_ANGLE_DESC, onDefaultCameraAngleChange));
            this.addOptionAndPosition(new ChoiceOption("centerOnPlayer", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CENTER_ON_PLAYER, TextKey.OPTIONS_CENTER_ON_PLAYER_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("showQuestPortraits", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_QUEST_PORTRAITS, TextKey.OPTIONS_SHOW_QUEST_PORTRAITS_DESC, this.onShowQuestPortraitsChange));
            this.addOptionAndPosition(new ChoiceOption("showProtips", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TIPS, TextKey.OPTIONS_SHOW_TIPS_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("drawShadows", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_SHADOWS, TextKey.OPTIONS_DRAW_SHADOWS_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("textBubbles", makeOnOffLabels(), [true, false], TextKey.OPTIONS_DRAW_TEXT_BUBBLES, TextKey.OPTIONS_DRAW_TEXT_BUBBLES_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("showTradePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL, TextKey.OPTIONS_SHOW_TRADE_REQUEST_PANEL_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("showGuildInvitePopup", makeOnOffLabels(), [true, false], TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL, TextKey.OPTIONS_SHOW_GUILD_INVITE_PANEL_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("cursorSelect", makeCursorSelectLabels(), [MouseCursor.AUTO, "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"], "Custom Cursor", "Click here to change the mouse cursor. May help with aiming.", refreshCursor));
            if (!Parameters.GPURenderError)
            {
                _local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC;
                _local_2 = 0xFFFFFF;
            }
            else
            {
                _local_1 = TextKey.OPTIONS_HARDWARE_ACC_DESC_ERROR;
                _local_2 = 16724787;
            }
            this.addOptionAndPosition(new ChoiceOption("GPURender", makeOnOffLabels(), [true, false], TextKey.OPTIONS_HARDWARE_ACC_TITLE, _local_1, null, _local_2));
            if (Capabilities.playerType == "Desktop")
            {
                this.addOptionAndPosition(new ChoiceOption("fullscreenMode", makeOnOffLabels(), [true, false], TextKey.OPTIONS_FULLSCREEN_MODE, TextKey.OPTIONS_FULLSCREEN_MODE_DESC, this.onFullscreenChange));
            }
            this.addOptionAndPosition(new ChoiceOption("toggleBarText", makeBarTextLabels(), [0, 1, 2, 3], "Toggle Fame and HP/MP Text", "Always show text value for Fame, remaining HP/MP, or both", onBarTextToggle));
            this.addOptionAndPosition(new ChoiceOption("particleEffect", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT, TextKey.OPTIONS_TOGGLE_PARTICLE_EFFECT_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("uiQuality", makeHighLowLabels(), [true, false], TextKey.OPTIONS_TOGGLE_UI_QUALITY, TextKey.OPTIONS_TOGGLE_UI_QUALITY_DESC, onUIQualityToggle));
            this.addOptionAndPosition(new ChoiceOption("HPBar", makeHpBarLabels(), [0, 1, 2, 3, 4, 5], TextKey.OPTIONS_HPBAR, TextKey.OPTIONS_HPBAR_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("showTierTag", makeOnOffLabels(), [true, false], "Show Tier level", "Show Tier level on gear", this.onToggleTierTag));
            this.addOptionAndPosition(new KeyMapper("toggleProjectiles", "Toggle Ally Projectiles", "This key will toggle rendering of friendly projectiles"));
            this.addOptionAndPosition(new KeyMapper("toggleMasterParticles", "Toggle Particles", "This key will toggle rendering of nonessential particles (Particles Master option)"));
        }

        private function onToggleTierTag():void
        {
            StaticInjectorContext.getInjector().getInstance(ToggleShowTierTagSignal).dispatch(Parameters.data_.showTierTag);
        }

        private function onShowQuestPortraitsChange():void
        {
            if (((((!(this.gs_ == null)) && (!(this.gs_.map == null))) && (!(this.gs_.map.partyOverlay_ == null))) && (!(this.gs_.map.partyOverlay_.questArrow_ == null))))
            {
                this.gs_.map.partyOverlay_.questArrow_.refreshToolTip();
            }
        }

        private function onFullscreenChange():void
        {
            stage.displayState = ((Parameters.data_.fullscreenMode) ? "fullScreenInteractive" : StageDisplayState.NORMAL);
        }

        private function addSoundOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("playMusic", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_MUSIC, TextKey.OPTIONS_PLAY_MUSIC_DESC, this.onPlayMusicChange));
            this.addOptionAndPosition(new SliderOption("musicVolume", this.onMusicVolumeChange), -120, 15);
            this.addOptionAndPosition(new ChoiceOption("playSFX", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_SOUND_EFFECTS, TextKey.OPTIONS_PLAY_SOUND_EFFECTS_DESC, this.onPlaySoundEffectsChange));
            this.addOptionAndPosition(new SliderOption("SFXVolume", this.onSoundEffectsVolumeChange), -120, 34);
            this.addOptionAndPosition(new ChoiceOption("playPewPew", makeOnOffLabels(), [true, false], TextKey.OPTIONS_PLAY_WEAPON_SOUNDS, TextKey.OPTIONS_PLAY_WEAPON_SOUNDS_DESC, null));
        }

        private function addMiscOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_PRIVACY, TextKey.OPTIONS_LEGAL_PRIVACY_DESC, this.onLegalPrivacyClick));
            this.addOptionAndPosition(new NullOption());
            this.addOptionAndPosition(new ChoiceOption("showProtips", new <StringBuilder>[makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW), makeLineBuilder(TextKey.OPTIONS_LEGAL_VIEW)], [Parameters.data_.showProtips, Parameters.data_.showProtips], TextKey.OPTIONS_LEGAL_TOS, TextKey.OPTIONS_LEGAL_TOS_DESC, this.onLegalTOSClick));
            this.addOptionAndPosition(new NullOption());
        }

        private function addFriendOptions():void
        {
            this.addOptionAndPosition(new ChoiceOption("tradeWithFriends", makeOnOffLabels(), [true, false], TextKey.OPTIONS_TRADE_FRIEND, TextKey.OPTIONS_TRADE_FRIEND_DESC, this.onPlaySoundEffectsChange));
            this.addOptionAndPosition(new KeyMapper("friendList", TextKey.OPTIONS_SHOW_FRIEND_LIST, TextKey.OPTIONS_SHOW_FRIEND_LIST_DESC));
            this.addOptionAndPosition(new ChoiceOption("chatFriend", makeOnOffLabels(), [true, false], TextKey.OPTIONS_CHAT_FRIEND, TextKey.OPTIONS_CHAT_FRIEND_DESC, null));
            this.addOptionAndPosition(new ChoiceOption("friendStarRequirement", makeStarSelectLabels(), [0, 1, 2, 3, 5, 10], TextKey.OPTIONS_STAR_REQ, TextKey.OPTIONS_FRIEND_STAR_REQ_DESC, null));
        }

        private function onPlayMusicChange():void
        {
            Music.setPlayMusic(Parameters.data_.playMusic);
            if (Parameters.data_.playMusic)
            {
                Music.setMusicVolume(1);
            }
            else
            {
                Music.setMusicVolume(0);
            }
            this.refresh();
        }

        private function onPlaySoundEffectsChange():void
        {
            SFX.setPlaySFX(Parameters.data_.playSFX);
            if (((Parameters.data_.playSFX) || (Parameters.data_.playPewPew)))
            {
                SFX.setSFXVolume(1);
            }
            else
            {
                SFX.setSFXVolume(0);
            }
            this.refresh();
        }

        private function onMusicVolumeChange(_arg_1:Number):void
        {
            Music.setMusicVolume(_arg_1);
        }

        private function onSoundEffectsVolumeChange(_arg_1:Number):void
        {
            SFX.setSFXVolume(_arg_1);
        }

        private function onLegalPrivacyClick():void
        {
            var _local_1:URLRequest = new URLRequest();
            _local_1.url = Parameters.PRIVACY_POLICY_URL;
            _local_1.method = URLRequestMethod.GET;
            navigateToURL(_local_1, "_blank");
        }

        private function onLegalTOSClick():void
        {
            var _local_1:URLRequest = new URLRequest();
            _local_1.url = Parameters.TERMS_OF_USE_URL;
            _local_1.method = URLRequestMethod.GET;
            navigateToURL(_local_1, "_blank");
        }

        private function addOptionAndPosition(option:Option, offsetX:Number=0, offsetY:Number=0):void
        {
            var positionOption:Function;
            positionOption = function ():void
            {
                option.x = ((((options_.length % 2) == 0) ? 20 : 415) + offsetX);
                option.y = (((int((options_.length / 2)) * 44) + 122) + offsetY);
            };
            option.textChanged.addOnce(positionOption);
            this.addOption(option);
        }

        private function addOption(_arg_1:Option):void
        {
            addChild(_arg_1);
            _arg_1.addEventListener(Event.CHANGE, this.onChange);
            this.options_.push(_arg_1);
        }

        private function onChange(_arg_1:Event):void
        {
            this.refresh();
        }

        private function refresh():void
        {
            var _local_2:BaseOption;
            var _local_1:int;
            while (_local_1 < this.options_.length)
            {
                _local_2 = (this.options_[_local_1] as BaseOption);
                if (_local_2 != null)
                {
                    _local_2.refresh();
                }
                _local_1++;
            }
        }


    }
}//package com.company.assembleegameclient.ui.options

