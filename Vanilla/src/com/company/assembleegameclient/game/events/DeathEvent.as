﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//com.company.assembleegameclient.game.events.DeathEvent

package com.company.assembleegameclient.game.events{
    import flash.events.Event;
    import flash.display.BitmapData;
    import com.company.assembleegameclient.objects.Player;

    public class DeathEvent extends Event {

        public static const DEATH:String = "DEATH";

        public var background_:BitmapData;
        public var player_:Player;
        public var accountId_:int;
        public var charId_:int;

        public function DeathEvent(_arg_1:BitmapData, _arg_2:int, _arg_3:int){
            super(DEATH);
            this.background_ = _arg_1;
            this.accountId_ = _arg_2;
            this.charId_ = _arg_3;
        }

    }
}//package com.company.assembleegameclient.game.events

