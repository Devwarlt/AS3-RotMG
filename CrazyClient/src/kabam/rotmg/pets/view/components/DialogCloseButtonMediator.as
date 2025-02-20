﻿// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//kabam.rotmg.pets.view.components.DialogCloseButtonMediator

package kabam.rotmg.pets.view.components
{
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DialogCloseButtonMediator extends Mediator
    {

        [Inject]
        public var view:DialogCloseButton;
        [Inject]
        public var closeDialogSignal:CloseDialogsSignal;


        override public function initialize():void
        {
            this.view.clicked.addOnce(this.closeDialog);
        }

        private function closeDialog():void
        {
            this.closeDialogSignal.dispatch();
        }


    }
}//package kabam.rotmg.pets.view.components

