﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//io.decagames.rotmg.pets.components.tooltip.PetTooltipMediator

package io.decagames.rotmg.pets.components.tooltip
{
import robotlegs.bender.bundles.mvcs.Mediator;

public class PetTooltipMediator extends Mediator
    {

        [Inject]
        public var view:PetTooltip;


        override public function initialize():void
        {
            this.view.init();
        }


    }
}//package io.decagames.rotmg.pets.components.tooltip

