﻿// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//kabam.rotmg.account.web.WebAccount

package kabam.rotmg.account.web
{
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.util.GUID;

import flash.external.ExternalInterface;
import flash.net.SharedObject;

import kabam.rotmg.account.core.Account;

public class WebAccount implements Account 
    {

        public static const NETWORK_NAME:String = "rotmg";
        private static const WEB_USER_ID:String = "";
        private static const WEB_PLAY_PLATFORM_NAME:String = "rotmg";

        private var userId:String = "";
        private var password:String;
        private var secret:String = "";
        private var token:String = "";
        private var entryTag:String = "";
        private var isVerifiedEmail:Boolean;
        private var platformToken:String;
        private var _userDisplayName:String = "";
        private var _rememberMe:Boolean = true;
        private var _paymentProvider:String = "";
        private var _paymentData:String = "";
        public var signedRequest:String;
        public var kabamId:String;

        public function WebAccount()
        {
            try
            {
                this.entryTag = ExternalInterface.call("rotmg.UrlLib.getParam", "entrypt");
            }
            catch(error:Error)
            {
            }
        }

        public function getUserName():String
        {
            return (this.userId);
        }

        public function getUserId():String
        {
            var _local_1:* = ((this.userId) || (GUID.create()));
            this.userId = _local_1;
            return (_local_1);
        }

        public function getPassword():String
        {
            return ((this.password) || (""));
        }

        public function getToken():String
        {
            return ("");
        }

        public function getCredentials():Object
        {
            if (this.getSecret() != "")
            {
                return ({
                    "guid":this.getUserId(),
                    "secret":this.getSecret()
                });
            }
            return ({
                "guid":this.getUserId(),
                "password":this.getPassword()
            });
        }

        public function isRegistered():Boolean
        {
            return ((!(this.getPassword() == "")) || (!(this.getSecret() == "")));
        }

        public function updateUser(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):void
        {
            var _local_5:SharedObject;
            this.userId = _arg_1;
            this.password = _arg_2;
            this.secret = _arg_4;
            this.token = _arg_3;
            try
            {
                if (this._rememberMe)
                {
                    _local_5 = SharedObject.getLocal("RotMG", "/");
                    _local_5.data["GUID"] = _arg_1;
                    _local_5.data["Token"] = _arg_3;
                    _local_5.data["Password"] = _arg_2;
                    _local_5.data["Secret"] = _arg_4;
                    _local_5.flush();
                }
            }
            catch(error:Error)
            {
            }
        }

        public function clear():void
        {
            this._rememberMe = true;
            this.updateUser(GUID.create(), null, null, null);
            Parameters.sendLogin_ = true;
            Parameters.data_.charIdUseMap = {};
            Parameters.save();
        }

        public function reportIntStat(_arg_1:String, _arg_2:int):void
        {
        }

        public function getRequestPrefix():String
        {
            return ("/credits");
        }

        public function gameNetworkUserId():String
        {
            return ("");
        }

        public function gameNetwork():String
        {
            return ("rotmg");
        }

        public function playPlatform():String
        {
            return ("rotmg");
        }

        public function getEntryTag():String
        {
            return ((this.entryTag) || (""));
        }

        public function getSecret():String
        {
            return ((this.secret) || (""));
        }

        public function verify(_arg_1:Boolean):void
        {
            this.isVerifiedEmail = _arg_1;
        }

        public function isVerified():Boolean
        {
            return (this.isVerifiedEmail);
        }

        public function getPlatformToken():String
        {
            return ((this.platformToken) || (""));
        }

        public function setPlatformToken(_arg_1:String):void
        {
            this.platformToken = _arg_1;
        }

        public function getMoneyAccessToken():String
        {
            return (this.signedRequest);
        }

        public function getMoneyUserId():String
        {
            return (this.kabamId);
        }

        public function get userDisplayName():String
        {
            return (this._userDisplayName);
        }

        public function set userDisplayName(_arg_1:String):void
        {
            this._userDisplayName = _arg_1;
        }

        public function set rememberMe(_arg_1:Boolean):void
        {
            this._rememberMe = _arg_1;
        }

        public function get rememberMe():Boolean
        {
            return (this._rememberMe);
        }

        public function set paymentProvider(_arg_1:String):void
        {
            this._paymentProvider = _arg_1;
        }

        public function get paymentProvider():String
        {
            return (this._paymentProvider);
        }

        public function set paymentData(_arg_1:String):void
        {
            this._paymentData = _arg_1;
        }

        public function get paymentData():String
        {
            return (this._paymentData);
        }


    }
}//package kabam.rotmg.account.web

