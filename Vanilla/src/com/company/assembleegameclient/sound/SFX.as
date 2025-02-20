﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//com.company.assembleegameclient.sound.SFX

package com.company.assembleegameclient.sound{
    import flash.media.SoundTransform;
    import com.company.assembleegameclient.parameters.Parameters;
    import kabam.rotmg.core.StaticInjectorContext;
    import kabam.rotmg.core.service.GoogleAnalytics;

    public class SFX {

        private static var sfxTrans_:SoundTransform;


        public static function load():void{
            sfxTrans_ = new SoundTransform(((Parameters.data_.playSFX) ? 1 : 0));
        }

        public static function setPlaySFX(_arg_1:Boolean):void{
            var _local_2:GoogleAnalytics = StaticInjectorContext.getInjector().getInstance(GoogleAnalytics);
            if (_local_2)
            {
            };
            Parameters.data_.playSFX = _arg_1;
            Parameters.save();
            SoundEffectLibrary.updateTransform();
        }

        public static function setSFXVolume(_arg_1:Number):void{
            Parameters.data_.SFXVolume = _arg_1;
            Parameters.save();
            SoundEffectLibrary.updateVolume(_arg_1);
        }


    }
}//package com.company.assembleegameclient.sound

