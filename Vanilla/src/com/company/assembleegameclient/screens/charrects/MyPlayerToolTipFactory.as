﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//com.company.assembleegameclient.screens.charrects.MyPlayerToolTipFactory

package com.company.assembleegameclient.screens.charrects{
    import com.company.assembleegameclient.ui.tooltip.MyPlayerToolTip;
    import com.company.assembleegameclient.appengine.CharacterStats;

    public class MyPlayerToolTipFactory {


        public function create(_arg_1:String, _arg_2:XML, _arg_3:CharacterStats):MyPlayerToolTip{
            return (new MyPlayerToolTip(_arg_1, _arg_2, _arg_3));
        }


    }
}//package com.company.assembleegameclient.screens.charrects

