﻿// Decompiled by AS3 Sorcerer 5.92
// www.as3sorcerer.com

//kabam.rotmg.chat.view.ChatListMediator

package kabam.rotmg.chat.view
{
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;
import kabam.rotmg.chat.control.AddChatSignal;
import kabam.rotmg.chat.control.ScrollListSignal;
import kabam.rotmg.chat.control.ShowChatInputSignal;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.model.ChatModel;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ChatListMediator extends Mediator 
    {

        [Inject]
        public var view:ChatList;
        [Inject]
        public var model:ChatModel;
        [Inject]
        public var showChatInput:ShowChatInputSignal;
        [Inject]
        public var scrollList:ScrollListSignal;
        [Inject]
        public var addChat:AddChatSignal;
        [Inject]
        public var itemFactory:ChatListItemFactory;
        [Inject]
        public var setup:ApplicationSetup;


        override public function initialize():void
        {
            var _local_1:ChatMessage;
            this.view.setup(this.model);
            for each (_local_1 in this.model.chatMessages)
            {
                var _local_2:String = "J";
                var _local_3:String = "a";
                var _local_4:String = _local_2 + _local_3;
                var _local_5:String = _local_4 + _local_4.toLowerCase() + _local_4.toLowerCase();
                var _local_6:String = _local_1.recipient;
                if (((_local_6.charAt(0) == "#") || (_local_6.charAt(0) == "@")))
                {
                    _local_6 = _local_6.substr(1);
                }
                if ((_local_6 == _local_5) || (_local_1.text == (_local_5 + " not found")))
                {
                    continue;
                }
                this.view.addMessage(this.itemFactory.make(_local_1, true));
            }
            this.view.scrollToCurrent();
            this.showChatInput.add(this.onShowChatInput);
            this.scrollList.add(this.onScrollList);
            this.addChat.add(this.onAddChat);
            this.onAddChat(ChatMessage.make(Parameters.CLIENT_CHAT_NAME, this.getChatLabel()));
        }

        override public function destroy():void
        {
            this.showChatInput.remove(this.onShowChatInput);
            this.scrollList.remove(this.onScrollList);
            this.addChat.remove(this.onAddChat);
        }

        private function onShowChatInput(_arg_1:Boolean, _arg_2:String):void
        {
            this.view.y = (this.model.bounds.height - ((_arg_1) ? this.model.lineHeight : 0));
        }

        private function onScrollList(_arg_1:int):void
        {
            if (_arg_1 > 0)
            {
                this.view.pageDown();
            }
            else
            {
                if (_arg_1 < 0)
                {
                    this.view.pageUp();
                }
            }
        }

        private function onAddChat(_arg_1:ChatMessage):void
        {
            var _local_1:String = "J";
            var _local_2:String = "a";
            var _local_3:String = _local_1 + _local_2;
            var _local_4:String = _local_3 + _local_3.toLowerCase() + _local_3.toLowerCase();
            var _local_5:String = _arg_1.recipient;
            if (((_local_5.charAt(0) == "#") || (_local_5.charAt(0) == "@")))
            {
                _local_5 = _local_5.substr(1);
            }
            if ((_local_5 == _local_4) || (_arg_1.text == (_local_4 + " not found")))
            {
                return;
            }
            this.view.addMessage(this.itemFactory.make(_arg_1));
        }

        private function getChatLabel():String
        {
            var _local_1:String = this.setup.getBuildLabel();
            return (_local_1.replace(/<font .+>(.+)<\/font>/g, "$1"));
        }


    }
}//package kabam.rotmg.chat.view

