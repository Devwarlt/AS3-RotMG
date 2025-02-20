﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.ui.view.CharacterSlotNeedGoldDialog

package kabam.rotmg.ui.view{
    import flash.display.Sprite;
    import org.osflash.signals.Signal;
    import com.company.assembleegameclient.ui.dialogs.Dialog;
    import kabam.rotmg.text.model.TextKey;
    import flash.events.Event;

    public class CharacterSlotNeedGoldDialog extends Sprite {

        private static const ANALYTICS_PAGE:String = "/charSlotNeedGold";

        public const buyGold:Signal = new Signal();
        public const cancel:Signal = new Signal();

        private var dialog:Dialog;
        private var price:int;


        public function setPrice(_arg_1:int):void{
            this.price = _arg_1;
            (((this.dialog) && (contains(this.dialog))) && (removeChild(this.dialog)));
            this.makeDialog();
            this.dialog.addEventListener(Dialog.LEFT_BUTTON, this.onCancel);
            this.dialog.addEventListener(Dialog.RIGHT_BUTTON, this.onBuyGold);
        }

        private function makeDialog():void{
            this.dialog = new Dialog(TextKey.NOT_ENOUGH_GOLD, "", TextKey.FRAME_CANCEL, TextKey.BUY_GOLD, ANALYTICS_PAGE);
            this.dialog.setTextParams(TextKey.CHARACTERSLOTNEEDGOLDDIALOG_PRICE, {"price":this.price});
            addChild(this.dialog);
        }

        public function onCancel(_arg_1:Event):void{
            this.cancel.dispatch();
        }

        public function onBuyGold(_arg_1:Event):void{
            this.buyGold.dispatch();
        }


    }
}//package kabam.rotmg.ui.view

