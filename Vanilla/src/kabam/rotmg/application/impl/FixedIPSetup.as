﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.application.impl.FixedIPSetup

package kabam.rotmg.application.impl{
    import kabam.rotmg.application.api.ApplicationSetup;
    import com.company.assembleegameclient.parameters.Parameters;

    public class FixedIPSetup implements ApplicationSetup {

        private const SERVER:String = "test.realmofthemadgod.com";
        private const UNENCRYPTED:String = ("http://" + SERVER);
        private const ENCRYPTED:String = ("https://" + SERVER);
        private const ANALYTICS:String = "UA-99999999-1";
        private const BUILD_LABEL:String = "<font color='#9900FF'>{IP}</font> #{VERSION}";

        private var ipAddress:String;


        public function setAddress(_arg_1:String):FixedIPSetup{
            this.ipAddress = _arg_1;
            return (this);
        }

        public function getAppEngineUrl(_arg_1:Boolean=false):String{
            return ((_arg_1) ? this.UNENCRYPTED : this.ENCRYPTED);
        }

        public function getAnalyticsCode():String{
            return (this.ANALYTICS);
        }

        public function isServerLocal():Boolean{
            return (false);
        }

        public function getBuildLabel():String{
            var _local_1:String = ((Parameters.BUILD_VERSION + ".") + Parameters.MINOR_VERSION);
            return (this.BUILD_LABEL.replace("{IP}", this.ipAddress).replace("{VERSION}", _local_1));
        }

        public function useLocalTextures():Boolean{
            return (true);
        }

        public function isToolingEnabled():Boolean{
            return (true);
        }

        public function isGameLoopMonitored():Boolean{
            return (true);
        }

        public function useProductionDialogs():Boolean{
            return (false);
        }

        public function areErrorsReported():Boolean{
            return (false);
        }

        public function areDeveloperHotkeysEnabled():Boolean{
            return (true);
        }

        public function isDebug():Boolean{
            return (false);
        }

        public function getServerDomain():String{
            return (this.SERVER);
        }


    }
}//package kabam.rotmg.application.impl

