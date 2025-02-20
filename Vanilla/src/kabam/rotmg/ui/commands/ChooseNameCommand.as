﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.ui.commands.ChooseNameCommand

package kabam.rotmg.ui.commands{
    import kabam.rotmg.account.core.Account;
    import kabam.rotmg.dialogs.control.OpenDialogSignal;
    import flash.display.Sprite;
    import com.company.assembleegameclient.account.ui.NewChooseNameFrame;
    import kabam.rotmg.ui.view.ChooseNameRegisterDialog;

    public class ChooseNameCommand {

        [Inject]
        public var account:Account;
        [Inject]
        public var openDialog:OpenDialogSignal;


        public function execute():void{
            var _local_1:Sprite;
            if (this.account.isRegistered())
            {
                _local_1 = new NewChooseNameFrame();
            }
            else
            {
                _local_1 = new ChooseNameRegisterDialog();
            };
            this.openDialog.dispatch(_local_1);
        }


    }
}//package kabam.rotmg.ui.commands

