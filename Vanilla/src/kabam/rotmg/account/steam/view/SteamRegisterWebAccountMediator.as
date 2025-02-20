﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.account.steam.view.SteamRegisterWebAccountMediator

package kabam.rotmg.account.steam.view{
    import robotlegs.bender.bundles.mvcs.Mediator;
    import kabam.rotmg.account.core.view.RegisterWebAccountDialog;
    import kabam.rotmg.account.core.signals.RegisterAccountSignal;
    import kabam.rotmg.dialogs.control.CloseDialogsSignal;
    import kabam.rotmg.account.web.model.AccountData;

    public class SteamRegisterWebAccountMediator extends Mediator {

        [Inject]
        public var view:RegisterWebAccountDialog;
        [Inject]
        public var register:RegisterAccountSignal;
        [Inject]
        public var closeDialogsSignal:CloseDialogsSignal;


        override public function initialize():void{
            this.view.register.add(this.onRegister);
            this.view.cancel.add(this.onClose);
        }

        override public function destroy():void{
            this.view.register.remove(this.onRegister);
        }

        private function onRegister(_arg_1:AccountData):void{
            this.register.dispatch(_arg_1);
        }

        private function onClose():void{
            this.closeDialogsSignal.dispatch();
        }


    }
}//package kabam.rotmg.account.steam.view

