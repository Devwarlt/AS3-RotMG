﻿// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//com.company.assembleegameclient.util.TileRedrawer

package com.company.assembleegameclient.util
{
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.GroundProperties;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.Square;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
import com.company.util.ImageSet;
import com.company.util.PointUtil;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

public class TileRedrawer
    {

        private static const rect0:Rectangle = new Rectangle(0, 0, 4, 4);
        private static const p0:Point = new Point(0, 0);
        private static const rect1:Rectangle = new Rectangle(4, 0, 4, 4);
        private static const p1:Point = new Point(4, 0);
        private static const rect2:Rectangle = new Rectangle(0, 4, 4, 4);
        private static const p2:Point = new Point(0, 4);
        private static const rect3:Rectangle = new Rectangle(4, 4, 4, 4);
        private static const p3:Point = new Point(4, 4);
        private static const INNER:int = 0;
        private static const SIDE0:int = 1;
        private static const SIDE1:int = 2;
        private static const OUTER:int = 3;
        private static const INNERP1:int = 4;
        private static const INNERP2:int = 5;
        private static const mlist_:Vector.<Vector.<ImageSet>> = getMasks();
        private static var cache_:Vector.<Object> = new <Object>[null, {}];
        private static const RECT01:Rectangle = new Rectangle(0, 0, 8, 4);
        private static const RECT13:Rectangle = new Rectangle(4, 0, 4, 8);
        private static const RECT23:Rectangle = new Rectangle(0, 4, 8, 4);
        private static const RECT02:Rectangle = new Rectangle(0, 0, 4, 8);
        private static const RECT0:Rectangle = new Rectangle(0, 0, 4, 4);
        private static const RECT1:Rectangle = new Rectangle(4, 0, 4, 4);
        private static const RECT2:Rectangle = new Rectangle(0, 4, 4, 4);
        private static const RECT3:Rectangle = new Rectangle(4, 4, 4, 4);
        private static const POINT0:Point = new Point(0, 0);
        private static const POINT1:Point = new Point(4, 0);
        private static const POINT2:Point = new Point(0, 4);
        private static const POINT3:Point = new Point(4, 4);


        public static function redraw(_arg_1:Square, _arg_2:Boolean):BitmapData
        {
            var _local_3:Array;
            var _local_4:BitmapData;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_8:Boolean;
            if (Parameters.blendType_ == 0)
            {
                return (null);
            }
            if (_arg_1.tileType_ == 253)
            {
                _local_3 = getCompositeSig(_arg_1);
            }
            else
            {
                if (_arg_1.props_.hasEdge_)
                {
                    _local_3 = getEdgeSig(_arg_1);
                }
                else
                {
                    _local_3 = getSig(_arg_1);
                }
            }
            if (_local_3 == null)
            {
                return (null);
            }
            var _local_9:Object = cache_[Parameters.blendType_];
            if (_local_9.hasOwnProperty(_local_3))
            {
                return (_local_9[_local_3]);
            }
            if (_arg_1.tileType_ == 253)
            {
                _local_4 = buildComposite(_local_3);
                _local_9[_local_3] = _local_4;
                return (_local_4);
            }
            if (_arg_1.props_.hasEdge_)
            {
                _local_4 = drawEdges(_local_3);
                _local_9[_local_3] = _local_4;
                return (_local_4);
            }
            if (_local_3[1] != _local_3[4])
            {
                _local_5 = true;
                _local_6 = true;
            }
            if (_local_3[3] != _local_3[4])
            {
                _local_5 = true;
                _local_7 = true;
            }
            if (_local_3[5] != _local_3[4])
            {
                _local_6 = true;
                _local_8 = true;
            }
            if (_local_3[7] != _local_3[4])
            {
                _local_7 = true;
                _local_8 = true;
            }
            if (((!(_local_5)) && (!(_local_3[0] == _local_3[4]))))
            {
                _local_5 = true;
            }
            if (((!(_local_6)) && (!(_local_3[2] == _local_3[4]))))
            {
                _local_6 = true;
            }
            if (((!(_local_7)) && (!(_local_3[6] == _local_3[4]))))
            {
                _local_7 = true;
            }
            if (((!(_local_8)) && (!(_local_3[8] == _local_3[4]))))
            {
                _local_8 = true;
            }
            if (((((!(_local_5)) && (!(_local_6))) && (!(_local_7))) && (!(_local_8))))
            {
                _local_9[_local_3] = null;
                return (null);
            }
            var _local_10:BitmapData = GroundLibrary.getBitmapData(_arg_1.tileType_);
            if (_arg_2)
            {
                _local_4 = _local_10.clone();
            }
            else
            {
                _local_4 = new BitmapDataSpy(_local_10.width, _local_10.height, true, 0);
            }
            if (_local_5)
            {
                redrawRect(_local_4, rect0, p0, mlist_[0], _local_3[4], _local_3[3], _local_3[0], _local_3[1]);
            }
            if (_local_6)
            {
                redrawRect(_local_4, rect1, p1, mlist_[1], _local_3[4], _local_3[1], _local_3[2], _local_3[5]);
            }
            if (_local_7)
            {
                redrawRect(_local_4, rect2, p2, mlist_[2], _local_3[4], _local_3[7], _local_3[6], _local_3[3]);
            }
            if (_local_8)
            {
                redrawRect(_local_4, rect3, p3, mlist_[3], _local_3[4], _local_3[5], _local_3[8], _local_3[7]);
            }
            _local_9[_local_3] = _local_4;
            return (_local_4);
        }

        private static function redrawRect(_arg_1:BitmapData, _arg_2:Rectangle, _arg_3:Point, _arg_4:Vector.<ImageSet>, _arg_5:uint, _arg_6:uint, _arg_7:uint, _arg_8:uint):void
        {
            var _local_9:BitmapData;
            var _local_10:BitmapData;
            if (((_arg_5 == _arg_6) && (_arg_5 == _arg_8)))
            {
                _local_10 = _arg_4[OUTER].random();
                _local_9 = GroundLibrary.getBitmapData(_arg_7);
            }
            else
            {
                if (((!(_arg_5 == _arg_6)) && (!(_arg_5 == _arg_8))))
                {
                    if (_arg_6 != _arg_8)
                    {
                        _arg_1.copyPixels(GroundLibrary.getBitmapData(_arg_6), _arg_2, _arg_3, _arg_4[INNERP1].random(), p0, true);
                        _arg_1.copyPixels(GroundLibrary.getBitmapData(_arg_8), _arg_2, _arg_3, _arg_4[INNERP2].random(), p0, true);
                        return;
                    }
                    _local_10 = _arg_4[INNER].random();
                    _local_9 = GroundLibrary.getBitmapData(_arg_6);
                }
                else
                {
                    if (_arg_5 != _arg_6)
                    {
                        _local_10 = _arg_4[SIDE0].random();
                        _local_9 = GroundLibrary.getBitmapData(_arg_6);
                    }
                    else
                    {
                        _local_10 = _arg_4[SIDE1].random();
                        _local_9 = GroundLibrary.getBitmapData(_arg_8);
                    }
                }
            }
            _arg_1.copyPixels(_local_9, _arg_2, _arg_3, _local_10, p0, true);
        }

        private static function getSig(_arg_1:Square):Array
        {
            var _local_2:int;
            var _local_3:Square;
            var _local_4:Array = [];
            var _local_5:Map = _arg_1.map_;
            var _local_6:uint = _arg_1.tileType_;
            var _local_7:int = (_arg_1.y_ - 1);
            while (_local_7 <= (_arg_1.y_ + 1))
            {
                _local_2 = (_arg_1.x_ - 1);
                while (_local_2 <= (_arg_1.x_ + 1))
                {
                    if ((((((_local_2 < 0) || (_local_2 >= _local_5.width_)) || (_local_7 < 0)) || (_local_7 >= _local_5.height_)) || ((_local_2 == _arg_1.x_) && (_local_7 == _arg_1.y_))))
                    {
                        _local_4.push(_local_6);
                    }
                    else
                    {
                        _local_3 = _local_5.squares_[(_local_2 + (_local_7 * _local_5.width_))];
                        if (((_local_3 == null) || (_local_3.props_.blendPriority_ <= _arg_1.props_.blendPriority_)))
                        {
                            _local_4.push(_local_6);
                        }
                        else
                        {
                            _local_4.push(_local_3.tileType_);
                        }
                    }
                    _local_2++;
                }
                _local_7++;
            }
            return (_local_4);
        }

        private static function getMasks():Vector.<Vector.<ImageSet>>
        {
            var _local_1:Vector.<Vector.<ImageSet>> = new Vector.<Vector.<ImageSet>>();
            addMasks(_local_1, AssetLibrary.getImageSet("inner_mask"), AssetLibrary.getImageSet("sides_mask"), AssetLibrary.getImageSet("outer_mask"), AssetLibrary.getImageSet("innerP1_mask"), AssetLibrary.getImageSet("innerP2_mask"));
            return (_local_1);
        }

        private static function addMasks(_arg_1:Vector.<Vector.<ImageSet>>, _arg_2:ImageSet, _arg_3:ImageSet, _arg_4:ImageSet, _arg_5:ImageSet, _arg_6:ImageSet):void
        {
            var _local_7:int;
            for each (_local_7 in [-1, 0, 2, 1])
            {
                _arg_1.push(new <ImageSet>[rotateImageSet(_arg_2, _local_7), rotateImageSet(_arg_3, (_local_7 - 1)), rotateImageSet(_arg_3, _local_7), rotateImageSet(_arg_4, _local_7), rotateImageSet(_arg_5, _local_7), rotateImageSet(_arg_6, _local_7)]);
            }
        }

        private static function rotateImageSet(_arg_1:ImageSet, _arg_2:int):ImageSet
        {
            var _local_3:BitmapData;
            var _local_4:ImageSet = new ImageSet();
            for each (_local_3 in _arg_1.images_)
            {
                _local_4.add(BitmapUtil.rotateBitmapData(_local_3, _arg_2));
            }
            return (_local_4);
        }

        private static function getCompositeSig(_arg_1:Square):Array
        {
            var _local_2:Square;
            var _local_3:Square;
            var _local_4:Square;
            var _local_5:Square;
            var _local_6:Array = [];
            _local_6.length = 4;
            var _local_7:Map = _arg_1.map_;
            var _local_8:int = _arg_1.x_;
            var _local_9:int = _arg_1.y_;
            var _local_10:Square = _local_7.lookupSquare(_local_8, (_local_9 - 1));
            var _local_11:Square = _local_7.lookupSquare((_local_8 - 1), _local_9);
            var _local_12:Square = _local_7.lookupSquare((_local_8 + 1), _local_9);
            var _local_13:Square = _local_7.lookupSquare(_local_8, (_local_9 + 1));
            var _local_14:int = ((_local_10 != null) ? _local_10.props_.compositePriority_ : -1);
            var _local_15:int = ((_local_11 != null) ? _local_11.props_.compositePriority_ : -1);
            var _local_16:int = ((_local_12 != null) ? _local_12.props_.compositePriority_ : -1);
            var _local_17:int = ((_local_13 != null) ? _local_13.props_.compositePriority_ : -1);
            if (((_local_14 < 0) && (_local_15 < 0)))
            {
                _local_2 = _local_7.lookupSquare((_local_8 - 1), (_local_9 - 1));
                _local_6[0] = (((_local_2 == null) || (_local_2.props_.compositePriority_ < 0)) ? 0xFF : _local_2.tileType_);
            }
            else
            {
                if (_local_14 < _local_15)
                {
                    _local_6[0] = _local_11.tileType_;
                }
                else
                {
                    _local_6[0] = _local_10.tileType_;
                }
            }
            if (((_local_14 < 0) && (_local_16 < 0)))
            {
                _local_3 = _local_7.lookupSquare((_local_8 + 1), (_local_9 - 1));
                _local_6[1] = (((_local_3 == null) || (_local_3.props_.compositePriority_ < 0)) ? 0xFF : _local_3.tileType_);
            }
            else
            {
                if (_local_14 < _local_16)
                {
                    _local_6[1] = _local_12.tileType_;
                }
                else
                {
                    _local_6[1] = _local_10.tileType_;
                }
            }
            if (((_local_15 < 0) && (_local_17 < 0)))
            {
                _local_4 = _local_7.lookupSquare((_local_8 - 1), (_local_9 + 1));
                _local_6[2] = (((_local_4 == null) || (_local_4.props_.compositePriority_ < 0)) ? 0xFF : _local_4.tileType_);
            }
            else
            {
                if (_local_15 < _local_17)
                {
                    _local_6[2] = _local_13.tileType_;
                }
                else
                {
                    _local_6[2] = _local_11.tileType_;
                }
            }
            if (((_local_16 < 0) && (_local_17 < 0)))
            {
                _local_5 = _local_7.lookupSquare((_local_8 + 1), (_local_9 + 1));
                _local_6[3] = (((_local_5 == null) || (_local_5.props_.compositePriority_ < 0)) ? 0xFF : _local_5.tileType_);
            }
            else
            {
                if (_local_16 < _local_17)
                {
                    _local_6[3] = _local_13.tileType_;
                }
                else
                {
                    _local_6[3] = _local_12.tileType_;
                }
            }
            return (_local_6);
        }

        private static function buildComposite(_arg_1:Array):BitmapData
        {
            var _local_2:BitmapData;
            var _local_3:BitmapData = new BitmapDataSpy(8, 8, false, 0);
            if (_arg_1[0] != 0xFF)
            {
                _local_2 = GroundLibrary.getBitmapData(_arg_1[0]);
                _local_3.copyPixels(_local_2, RECT0, POINT0);
            }
            if (_arg_1[1] != 0xFF)
            {
                _local_2 = GroundLibrary.getBitmapData(_arg_1[1]);
                _local_3.copyPixels(_local_2, RECT1, POINT1);
            }
            if (_arg_1[2] != 0xFF)
            {
                _local_2 = GroundLibrary.getBitmapData(_arg_1[2]);
                _local_3.copyPixels(_local_2, RECT2, POINT2);
            }
            if (_arg_1[3] != 0xFF)
            {
                _local_2 = GroundLibrary.getBitmapData(_arg_1[3]);
                _local_3.copyPixels(_local_2, RECT3, POINT3);
            }
            return (_local_3);
        }

        private static function getEdgeSig(_arg_1:Square):Array
        {
            var _local_2:int;
            var _local_3:Square;
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:Array = [];
            var _local_7:Map = _arg_1.map_;
            var _local_8:Boolean = _arg_1.props_.sameTypeEdgeMode_;
            var _local_9:int = (_arg_1.y_ - 1);
            while (_local_9 <= (_arg_1.y_ + 1))
            {
                _local_2 = (_arg_1.x_ - 1);
                while (_local_2 <= (_arg_1.x_ + 1))
                {
                    _local_3 = _local_7.lookupSquare(_local_2, _local_9);
                    if (((_local_2 == _arg_1.x_) && (_local_9 == _arg_1.y_)))
                    {
                        _local_6.push(_local_3.tileType_);
                    }
                    else
                    {
                        if (_local_8)
                        {
                            _local_4 = ((_local_3 == null) || (_local_3.tileType_ == _arg_1.tileType_));
                        }
                        else
                        {
                            _local_4 = ((_local_3 == null) || (!(_local_3.tileType_ == 0xFF)));
                        }
                        _local_6.push(_local_4);
                        _local_5 = ((_local_5) || (!(_local_4)));
                    }
                    _local_2++;
                }
                _local_9++;
            }
            return ((_local_5) ? _local_6 : null);
        }

        private static function drawEdges(_arg_1:Array):BitmapData
        {
            var _local_2:BitmapData = GroundLibrary.getBitmapData(_arg_1[4]);
            var _local_3:BitmapData = _local_2.clone();
            var _local_4:GroundProperties = GroundLibrary.propsLibrary_[_arg_1[4]];
            var _local_5:Vector.<BitmapData> = _local_4.getEdges();
            var _local_6:Vector.<BitmapData> = _local_4.getInnerCorners();
            var _local_7:int = 1;
            while (_local_7 < 8)
            {
                if ((!(_arg_1[_local_7])))
                {
                    _local_3.copyPixels(_local_5[_local_7], _local_5[_local_7].rect, PointUtil.ORIGIN, null, null, true);
                }
                _local_7 = (_local_7 + 2);
            }
            if (_local_5[0] != null)
            {
                if ((((_arg_1[3]) && (_arg_1[1])) && (!(_arg_1[0]))))
                {
                    _local_3.copyPixels(_local_5[0], _local_5[0].rect, PointUtil.ORIGIN, null, null, true);
                }
                if ((((_arg_1[1]) && (_arg_1[5])) && (!(_arg_1[2]))))
                {
                    _local_3.copyPixels(_local_5[2], _local_5[2].rect, PointUtil.ORIGIN, null, null, true);
                }
                if ((((_arg_1[5]) && (_arg_1[7])) && (!(_arg_1[8]))))
                {
                    _local_3.copyPixels(_local_5[8], _local_5[8].rect, PointUtil.ORIGIN, null, null, true);
                }
                if ((((_arg_1[3]) && (_arg_1[7])) && (!(_arg_1[6]))))
                {
                    _local_3.copyPixels(_local_5[6], _local_5[6].rect, PointUtil.ORIGIN, null, null, true);
                }
            }
            if (_local_6 != null)
            {
                if (((!(_arg_1[3])) && (!(_arg_1[1]))))
                {
                    _local_3.copyPixels(_local_6[0], _local_6[0].rect, PointUtil.ORIGIN, null, null, true);
                }
                if (((!(_arg_1[1])) && (!(_arg_1[5]))))
                {
                    _local_3.copyPixels(_local_6[2], _local_6[2].rect, PointUtil.ORIGIN, null, null, true);
                }
                if (((!(_arg_1[5])) && (!(_arg_1[7]))))
                {
                    _local_3.copyPixels(_local_6[8], _local_6[8].rect, PointUtil.ORIGIN, null, null, true);
                }
                if (((!(_arg_1[3])) && (!(_arg_1[7]))))
                {
                    _local_3.copyPixels(_local_6[6], _local_6[6].rect, PointUtil.ORIGIN, null, null, true);
                }
            }
            return (_local_3);
        }


    }
}//package com.company.assembleegameclient.util

