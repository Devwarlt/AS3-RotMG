﻿// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//kabam.rotmg.account.web.view.WebChangePasswordMediatorForced

package kabam.rotmg.account.web.view
{
import kabam.rotmg.account.core.Account;
import kabam.rotmg.account.web.signals.WebChangePasswordSignal;
import kabam.rotmg.appengine.api.AppEngineClient;
import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.core.signals.TaskErrorSignal;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;
import kabam.rotmg.dialogs.control.OpenDialogSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class WebChangePasswordMediatorForced extends Mediator
    {

        [Inject]
        public var view:WebChangePasswordDialogForced;
        [Inject]
        public var change:WebChangePasswordSignal;
        [Inject]
        public var openDialog:OpenDialogSignal;
        [Inject]
        public var closeDialogs:CloseDialogsSignal;
        [Inject]
        public var loginError:TaskErrorSignal;
        [Inject]
        public var account:Account;
        private var newPassword:String;


        override public function initialize():void
        {
            this.view.change.add(this.onChange);
            this.loginError.add(this.onError);
        }

        override public function destroy():void
        {
            this.view.change.remove(this.onChange);
            this.loginError.remove(this.onError);
        }

        private function onChange():void
        {
            var _local_2:AppEngineClient;
            var _local_1:Object;
            if ((((this.isCurrentPasswordValid()) && (this.isNewPasswordValid())) && (this.isNewPasswordVerified())))
            {
                this.view.clearError();
                this.view.disable();
                _local_2 = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
                _local_1 = {};
                _local_1.password = this.view.password_.text();
                this.newPassword = this.view.newPassword_.text();
                _local_1.newPassword = this.view.newPassword_.text();
                _local_1.guid = this.account.getUserId();
                _local_2.sendRequest("/account/changePassword", _local_1);
                _local_2.complete.addOnce(this.onComplete);
            }
        }

        private function isCurrentPasswordValid():Boolean
        {
            var _local_1:* = (this.view.password_.text().length >= 5);
            if ((!(_local_1)))
            {
                this.view.password_.setError("WebChangePasswordDialog.Incorrect");
            }
            return (_local_1);
        }

        private function isNewPasswordValid():Boolean
        {
            var _local_1:* = (this.view.newPassword_.text().length >= 10);
            if ((!(_local_1)))
            {
                this.view.newPassword_.setError("RegisterWebAccountDialog.shortError");
            }
            return (_local_1);
        }

        private function isNewPasswordVerified():Boolean
        {
            var _local_1:* = (this.view.newPassword_.text() == this.view.retypeNewPassword_.text());
            if ((!(_local_1)))
            {
                this.view.retypeNewPassword_.setError("RegisterWebAccountDialog.matchError");
            }
            return (_local_1);
        }

        private function onComplete(_arg_1:Boolean, _arg_2:*):void
        {
            if ((!(_arg_1)))
            {
                this.onError(_arg_2);
            }
            else
            {
                this.account.updateUser(this.account.getUserId(), this.newPassword, this.account.getToken(), this.account.getSecret());
                this.closeDialogs.dispatch();
            }
        }

        private function onError(_arg_1:String):void
        {
            this.view.newPassword_.setError(_arg_1);
            this.view.enable();
        }


    }
}//package kabam.rotmg.account.web.view

