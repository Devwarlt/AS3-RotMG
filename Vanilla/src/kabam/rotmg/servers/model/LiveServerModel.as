﻿// Decompiled by AS3 Sorcerer 5.94
// www.as3sorcerer.com

//kabam.rotmg.servers.model.LiveServerModel

package kabam.rotmg.servers.model{
    import kabam.rotmg.servers.api.ServerModel;
    import __AS3__.vec.Vector;
    import kabam.rotmg.servers.api.Server;
    import kabam.rotmg.core.model.PlayerModel;
    import kabam.rotmg.servers.api.LatLong;
    import com.company.assembleegameclient.parameters.Parameters;
    import __AS3__.vec.*;

    public class LiveServerModel implements ServerModel {

        private const servers:Vector.<Server> = new Vector.<Server>(0);

        [Inject]
        public var model:PlayerModel;
        private var _descendingFlag:Boolean;


        public function setServers(_arg_1:Vector.<Server>):void{
            var _local_2:Server;
            this.servers.length = 0;
            for each (_local_2 in _arg_1)
            {
                this.servers.push(_local_2);
            };
            this._descendingFlag = false;
            this.servers.sort(this.compareServerName);
        }

        public function getServers():Vector.<Server>{
            return (this.servers);
        }

        public function getServer():Server{
            var _local_6:Server;
            var _local_7:int;
            var _local_8:Number;
            var _local_1:Boolean = this.model.isAdmin();
            var _local_2:LatLong = this.model.getMyPos();
            var _local_3:Server;
            var _local_4:Number = Number.MAX_VALUE;
            var _local_5:int = int.MAX_VALUE;
            for each (_local_6 in this.servers)
            {
                if (!((_local_6.isFull()) && (!(_local_1))))
                {
                    if (_local_6.name == Parameters.data_.preferredServer)
                    {
                        return (_local_6);
                    };
                    _local_7 = _local_6.priority();
                    _local_8 = LatLong.distance(_local_2, _local_6.latLong);
                    if (((_local_7 < _local_5) || ((_local_7 == _local_5) && (_local_8 < _local_4))))
                    {
                        _local_3 = _local_6;
                        _local_4 = _local_8;
                        _local_5 = _local_7;
                        Parameters.data_.bestServer = _local_3.name;
                        Parameters.save();
                    };
                };
            };
            return (_local_3);
        }

        public function getServerNameByAddress(_arg_1:String):String{
            var _local_2:Server;
            for each (_local_2 in this.servers)
            {
                if (_local_2.address == _arg_1)
                {
                    return (_local_2.name);
                };
            };
            return ("");
        }

        public function isServerAvailable():Boolean{
            return (this.servers.length > 0);
        }

        private function compareServerName(_arg_1:Server, _arg_2:Server):int{
            if (_arg_1.name < _arg_2.name)
            {
                return ((this._descendingFlag) ? -1 : 1);
            };
            if (_arg_1.name > _arg_2.name)
            {
                return ((this._descendingFlag) ? 1 : -1);
            };
            return (0);
        }


    }
}//package kabam.rotmg.servers.model

