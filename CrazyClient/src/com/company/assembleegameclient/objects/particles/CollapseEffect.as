﻿// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//com.company.assembleegameclient.objects.particles.CollapseEffect

package com.company.assembleegameclient.objects.particles
{
import com.company.assembleegameclient.objects.GameObject;

import flash.geom.Point;

import kabam.rotmg.messaging.impl.data.WorldPosData;

public class CollapseEffect extends ParticleEffect
    {

        public var center_:Point;
        public var edgePoint_:Point;
        public var color_:int;

        public function CollapseEffect(_arg_1:GameObject, _arg_2:WorldPosData, _arg_3:WorldPosData, _arg_4:int)
        {
            this.center_ = new Point(_arg_2.x_, _arg_2.y_);
            this.edgePoint_ = new Point(_arg_3.x_, _arg_3.y_);
            this.color_ = _arg_4;
        }

        override public function runNormalRendering(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Number;
            var _local_4:Point;
            var _local_5:Particle;
            var _local_6:int;
            x_ = this.center_.x;
            y_ = this.center_.y;
            var _local_7:Number = Point.distance(this.center_, this.edgePoint_);
            var _local_8:* = 300;
            var _local_9:* = 200;
            var _local_10:int = 24;
            while (_local_6 < _local_10)
            {
                _local_3 = (((_local_6 * 2) * Math.PI) / _local_10);
                _local_4 = new Point((this.center_.x + (_local_7 * Math.cos(_local_3))), (this.center_.y + (_local_7 * Math.sin(_local_3))));
                _local_5 = new SparkerParticle(_local_8, this.color_, _local_9, _local_4, this.center_);
                map_.addObj(_local_5, x_, y_);
                _local_6++;
            }
            return (false);
        }

        override public function runEasyRendering(_arg_1:int, _arg_2:int):Boolean
        {
            var _local_3:Number;
            var _local_4:Point;
            var _local_5:Particle;
            var _local_6:int;
            x_ = this.center_.x;
            y_ = this.center_.y;
            var _local_7:Number = Point.distance(this.center_, this.edgePoint_);
            var _local_8:int = 50;
            var _local_9:* = 150;
            var _local_10:int = 8;
            while (_local_6 < _local_10)
            {
                _local_3 = (((_local_6 * 2) * Math.PI) / _local_10);
                _local_4 = new Point((this.center_.x + (_local_7 * Math.cos(_local_3))), (this.center_.y + (_local_7 * Math.sin(_local_3))));
                _local_5 = new SparkerParticle(_local_8, this.color_, _local_9, _local_4, this.center_);
                map_.addObj(_local_5, x_, y_);
                _local_6++;
            }
            return (false);
        }


    }
}//package com.company.assembleegameclient.objects.particles

