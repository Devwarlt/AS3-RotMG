﻿// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//kabam.rotmg.ui.view.StatMetersMediator

package kabam.rotmg.ui.view
{
import com.company.assembleegameclient.objects.Player;

import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.signals.UpdateHUDSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class StatMetersMediator extends Mediator
    {

        [Inject]
        public var view:StatMetersView;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var updateHUD:UpdateHUDSignal;


        override public function initialize():void
        {
            this.updateHUD.add(this.onUpdateHUD);
        }

        override public function destroy():void
        {
            this.updateHUD.add(this.onUpdateHUD);
        }

        private function onUpdateHUD(_arg_1:Player):void
        {
            if (this.view.myPlayer == false)
            {
                return;
            }
            this.view.update(_arg_1);
        }


    }
}//package kabam.rotmg.ui.view

