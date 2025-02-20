﻿// Decompiled by AS3 Sorcerer 5.48
// www.as3sorcerer.com

//com.company.assembleegameclient.ui.panels.mediators.ItemGridMediator

package com.company.assembleegameclient.ui.panels.mediators
{
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.Container;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.OneWayContainer;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.sound.SoundEffectLibrary;
import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileEvent;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.DisplayHierarchy;

import flash.utils.getTimer;

import io.decagames.rotmg.pets.data.PetsModel;

import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.constants.ItemConstants;
import kabam.rotmg.core.model.MapModel;
import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.game.model.PotionInventoryModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.view.components.TabStripView;
import kabam.rotmg.messaging.impl.GameServerConnection;
import kabam.rotmg.ui.model.HUDModel;
import kabam.rotmg.ui.model.TabStripModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ItemGridMediator extends Mediator
    {

        [Inject]
        public var view:ItemGrid;
        [Inject]
        public var mapModel:MapModel;
        [Inject]
        public var playerModel:PlayerModel;
        [Inject]
        public var potionInventoryModel:PotionInventoryModel;
        [Inject]
        public var hudModel:HUDModel;
        [Inject]
        public var tabStripModel:TabStripModel;
        [Inject]
        public var showToolTip:ShowTooltipSignal;
        [Inject]
        public var petsModel:PetsModel;
        [Inject]
        public var addTextLine:AddTextLineSignal;


        override public function initialize():void
        {
            this.view.addEventListener(ItemTileEvent.ITEM_MOVE, this.onTileMove);
            this.view.addEventListener(ItemTileEvent.ITEM_SHIFT_CLICK, this.onShiftClick);
            this.view.addEventListener(ItemTileEvent.ITEM_DOUBLE_CLICK, this.onDoubleClick);
            this.view.addEventListener(ItemTileEvent.ITEM_CTRL_CLICK, this.onCtrlClick);
            this.view.addToolTip.add(this.onAddToolTip);
        }

        private function onAddToolTip(_arg_1:ToolTip):void
        {
            this.showToolTip.dispatch(_arg_1);
        }

        override public function destroy():void
        {
            super.destroy();
        }

        private function onTileMove(_arg_1:ItemTileEvent):void
        {
            var _local_4:InteractiveItemTile;
            var _local_5:TabStripView;
            var _local_6:int;
            var _local_2:InteractiveItemTile = _arg_1.tile;
            if (this.swapTooSoon()){
                _local_2.resetItemPosition();
                return;
            }
            var _local_3:* = DisplayHierarchy.getParentWithTypeArray(_local_2.getDropTarget(), TabStripView, InteractiveItemTile, Map);
            if (((_local_2.getItemId() == PotionInventoryModel.HEALTH_POTION_ID) || (_local_2.getItemId() == PotionInventoryModel.MAGIC_POTION_ID)))
            {
                this.onPotionMove(_arg_1);
                return;
            }
            if ((_local_3 is InteractiveItemTile))
            {
                _local_4 = (_local_3 as InteractiveItemTile);
                if (this.view.curPlayer.lockedSlot[_local_4.tileId] == 0)
                {
                    if (this.canSwapItems(_local_2, _local_4))
                    {
                        this.swapItemTiles(_local_2, _local_4);
                    }
                }
                else
                {
                    this.addTextLine.dispatch(ChatMessage.make(Parameters.ERROR_CHAT_NAME, "You cannot put items into this slot right now."));
                }
            }
            else
            {
                if ((_local_3 is TabStripView))
                {
                    _local_5 = (_local_3 as TabStripView);
                    _local_6 = _local_2.ownerGrid.curPlayer.nextAvailableInventorySlot();
                    if (_local_6 != -1)
                    {
                        GameServerConnection.instance.invSwap(this.view.curPlayer, _local_2.ownerGrid.owner, _local_2.tileId, _local_2.itemSprite.itemId, this.view.curPlayer, _local_6, ItemConstants.NO_ITEM);
                        _local_2.setItem(ItemConstants.NO_ITEM);
                        _local_2.updateUseability(this.view.curPlayer);
                    }
                }
                else
                {
                    if (((_local_3 is Map) || (this.hudModel.gameSprite.map.mouseX < 300)))
                    {
                        this.dropItem(_local_2);
                    }
                }
            }
            _local_2.resetItemPosition();
        }

        private function petFoodCancel(itemSlot:InteractiveItemTile):Function
        {
            return (function ():void
            {
                itemSlot.blockingItemUpdates = false;
            });
        }

        private function onPotionMove(_arg_1:ItemTileEvent):void
        {
            var _local_2:InteractiveItemTile = _arg_1.tile;
            var _local_3:* = DisplayHierarchy.getParentWithTypeArray(_local_2.getDropTarget(), TabStripView, Map);
            if ((_local_3 is TabStripView))
            {
                this.addToPotionStack(_local_2);
            }
            else
            {
                if (((_local_3 is Map) || (this.hudModel.gameSprite.map.mouseX < 300)))
                {
                    this.dropItem(_local_2);
                }
            }
            _local_2.resetItemPosition();
        }

        private function addToPotionStack(_arg_1:InteractiveItemTile):void
        {
            if (((((!(GameServerConnection.instance)) || (!(this.view.interactive))) || (!(_arg_1))) || (this.potionInventoryModel.getPotionModel(_arg_1.getItemId()).maxPotionCount <= this.hudModel.gameSprite.map.player_.getPotionCount(_arg_1.getItemId()))))
            {
                return;
            }
            GameServerConnection.instance.invSwapPotion(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, this.view.curPlayer, PotionInventoryModel.getPotionSlot(_arg_1.getItemId()), ItemConstants.NO_ITEM);
            _arg_1.setItem(ItemConstants.NO_ITEM);
            _arg_1.updateUseability(this.view.curPlayer);
        }

        private function canSwapItems(_arg_1:InteractiveItemTile, _arg_2:InteractiveItemTile):Boolean
        {
            if (!_arg_1.canHoldItem(_arg_2.getItemId()))
            {
                return (false);
            }
            if (!_arg_2.canHoldItem(_arg_1.getItemId()))
            {
                return (false);
            }
            if ((ItemGrid(_arg_2.parent).owner is OneWayContainer))
            {
                return (false);
            }
            if (((_arg_1.blockingItemUpdates) || (_arg_2.blockingItemUpdates)))
            {
                return (false);
            }
            return (true);
        }

        private function dropItem(_arg_1:InteractiveItemTile):void
        {
            var _local_5:Container;
            var _local_6:Vector.<int>;
            var _local_7:int;
            var _local_8:int;
            var _local_2:Boolean = ObjectLibrary.isSoulbound(_arg_1.itemSprite.itemId);
            var _local_3:Boolean = ObjectLibrary.isDropTradable(_arg_1.itemSprite.itemId);
            var _local_4:Container = (this.view.owner as Container);
            if (((this.view.owner == this.view.curPlayer) || (((_local_4) && (_local_4.ownerId_ == this.view.curPlayer.accountId_)) && (!(_local_2)))))
            {
                _local_5 = (this.mapModel.currentInteractiveTarget as Container);
                if (((_local_5) && (!(((!(_local_5.canHaveSoulbound_)) && (!(_local_3))) || (((_local_5.canHaveSoulbound_) && (_local_5.isLoot_)) && (_local_3))))))
                {
                    _local_6 = _local_5.equipment_;
                    _local_7 = _local_6.length;
                    _local_8 = 0;
                    while (_local_8 < _local_7)
                    {
                        if (_local_6[_local_8] < 0) break;
                        _local_8++;
                    }
                    if (_local_8 < _local_7)
                    {
                        this.dropWithoutDestTile(_arg_1, _local_5, _local_8);
                    }
                    else
                    {
                        GameServerConnection.instance.invDrop(this.view.owner, _arg_1.tileId, _arg_1.getItemId());
                    }
                }
                else
                {
                    GameServerConnection.instance.invDrop(this.view.owner, _arg_1.tileId, _arg_1.getItemId());
                }
            }
            else
            {
                if ((((_local_4.canHaveSoulbound_) && (_local_4.isLoot_)) && (_local_3)))
                {
                    GameServerConnection.instance.invDrop(this.view.owner, _arg_1.tileId, _arg_1.getItemId());
                }
            }
            _arg_1.setItem(-1);
        }

        private function swapItemTiles(_arg_1:ItemTile, _arg_2:ItemTile):Boolean
        {
            if (((((!(GameServerConnection.instance)) || (!(this.view.interactive))) || (!(_arg_1))) || (!(_arg_2))))
            {
                return (false);
            }
            GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, _arg_2.ownerGrid.owner, _arg_2.tileId, _arg_2.itemSprite.itemId);
            var _local_3:int = _arg_1.getItemId();
            _arg_1.setItem(_arg_2.getItemId());
            _arg_2.setItem(_local_3);
            _arg_1.updateUseability(this.view.curPlayer);
            _arg_2.updateUseability(this.view.curPlayer);
            return (true);
        }

        private function dropWithoutDestTile(_arg_1:ItemTile, _arg_2:Container, _arg_3:int):void
        {
            if (((((!(GameServerConnection.instance)) || (!(this.view.interactive))) || (!(_arg_1))) || (!(_arg_2))))
            {
                return;
            }
            GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, _arg_2, _arg_3, -1);
            _arg_1.setItem(ItemConstants.NO_ITEM);
        }

        private function onShiftClick(_arg_1:ItemTileEvent):void
        {
            var _local_2:InteractiveItemTile = _arg_1.tile;
            if (((_local_2.ownerGrid is InventoryGrid) || (_local_2.ownerGrid is ContainerGrid)))
            {
                GameServerConnection.instance.useItem_new(_local_2.ownerGrid.owner, _local_2.tileId);
            }
        }

        private function onCtrlClick(_arg_1:ItemTileEvent):void
        {
            var _local_2:InteractiveItemTile;
            var _local_3:int;
            if (this.swapTooSoon()){
                return;
            }
            if (Parameters.data_.inventorySwap)
            {
                _local_2 = _arg_1.tile;
                if ((_local_2.ownerGrid is InventoryGrid))
                {
                    _local_3 = _local_2.ownerGrid.curPlayer.swapInventoryIndex(this.tabStripModel.currentSelection);
                    if (_local_3 != -1)
                    {
                        GameServerConnection.instance.invSwap(this.view.curPlayer, _local_2.ownerGrid.owner, _local_2.tileId, _local_2.itemSprite.itemId, this.view.curPlayer, _local_3, ItemConstants.NO_ITEM);
                        _local_2.setItem(ItemConstants.NO_ITEM);
                        _local_2.updateUseability(this.view.curPlayer);
                    }
                }
            }
        }

        private function onDoubleClick(_arg_1:ItemTileEvent):void
        {
            if (this.swapTooSoon()){
                return;
            }
            var _local_2:InteractiveItemTile = _arg_1.tile;
            if (this.isStackablePotion(_local_2))
            {
                this.addToPotionStack(_local_2);
            }
            else
            {
                if ((_local_2.ownerGrid is ContainerGrid))
                {
                    this.equipOrUseContainer(_local_2);
                }
                else
                {
                    this.equipOrUseInventory(_local_2);
                }
            }
            this.view.refreshTooltip();
        }

        private function isStackablePotion(_arg_1:InteractiveItemTile):Boolean
        {
            return ((_arg_1.getItemId() == PotionInventoryModel.HEALTH_POTION_ID) || (_arg_1.getItemId() == PotionInventoryModel.MAGIC_POTION_ID));
        }

        private function pickUpItem(_arg_1:InteractiveItemTile):void
        {
            var _local_2:int = this.view.curPlayer.nextAvailableInventorySlot();
            if (_local_2 != -1)
            {
                GameServerConnection.instance.invSwap(this.view.curPlayer, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, this.view.curPlayer, _local_2, ItemConstants.NO_ITEM);
            }
        }

        private function equipOrUseContainer(_arg_1:InteractiveItemTile):void
        {
            var _local_2:GameObject = _arg_1.ownerGrid.owner;
            var _local_3:Player = this.view.curPlayer;
            var _local_4:int = this.view.curPlayer.nextAvailableInventorySlot();
            if (_local_4 != -1)
            {
                GameServerConnection.instance.invSwap(_local_3, this.view.owner, _arg_1.tileId, _arg_1.itemSprite.itemId, this.view.curPlayer, _local_4, ItemConstants.NO_ITEM);
            }
            else
            {
                GameServerConnection.instance.useItem_new(_local_2, _arg_1.tileId);
            }
        }

        private function equipOrUseInventory(_arg_1:InteractiveItemTile):void
        {
            var _local_2:GameObject = _arg_1.ownerGrid.owner;
            var _local_3:Player = this.view.curPlayer;
            var _local_4:int = ObjectLibrary.getMatchingSlotIndex(_arg_1.getItemId(), _local_3);
            if (_local_4 != -1)
            {
                GameServerConnection.instance.invSwap(_local_3, _local_2, _arg_1.tileId, _arg_1.getItemId(), _local_3, _local_4, _local_3.equipment_[_local_4]);
            }
            else
            {
                GameServerConnection.instance.useItem_new(_local_2, _arg_1.tileId);
            }
        }

        private function swapTooSoon():Boolean{
            var _local_1:int = getTimer();
            if ((this.view.curPlayer.lastSwap_ + 600) > _local_1){
                SoundEffectLibrary.play("error");
                return (true);
            }
            this.view.curPlayer.lastSwap_ = _local_1;
            return (false);
        }

    }
}//package com.company.assembleegameclient.ui.panels.mediators

