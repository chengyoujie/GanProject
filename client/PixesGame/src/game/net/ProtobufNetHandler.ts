module game{
    export class ProtobufNetHandler extends egret.EventDispatcher implements cyj.INetHandler
    {
        private _sock:egret.WebSocket;
        private _protobuf:dcodeIO.ProtoBuf.Builder;
        private _PBClsDic:Object = {};
        private _listener:ListenerList = new ListenerList();

        public static EVENT_SOCK_CONNECT:string = "EVENT_SOCK_CONNECT";

        public initSock(sock:egret.WebSocket)
        {
            this._sock = sock;
            this._protobuf = dcodeIO.ProtoBuf.loadProto(RES.getRes("msg.proto"));
        }
        public onConnect()
        {
            this.dispatchEvent(new egret.Event(ProtobufNetHandler.EVENT_SOCK_CONNECT));
        }
        public onDisconnect()
        {
            
        }

        public regListenerCmd(cmd:NetCMD, fun:Function, thisp:any, pritiory  ?:number)
        {
            this._listener.addListener(cmd, fun, thisp, pritiory);
        }

        public unregListenerCmd(cmd:NetCMD, fun:Function, thisp:any, pritiory  ?:number)
        {
            this._listener.removeListener(cmd, fun, thisp, pritiory);
        }


        public recv(data:egret.ByteArray)
        {
            let cmd = data.readInt();
            let bytes:egret.ByteArray = new egret.ByteArray();
            bytes.writeBytes(data);
            let cls = this.getPBCls(PBD[cmd]);
            if(cls == null)
            {
                console.log("发送消息失败，没有找到对应的proto文件"+PBD[cmd]);
                return;
            }
            var dedata = cls.decode(bytes.buffer);
            console.log("接收数据：", cmd, dedata);
            this._listener.exec(cmd, dedata);
            data.clear();
            data = null;
            bytes.clear();
            bytes = null;
        }


        public send(cmd:NetCMD, data:any)
        {
            if(this._sock.connected==false)return;
            let cls = this.getPBCls(PBD[cmd]);
            if(cls == null)
            {
                console.log("发送消息失败，没有找到对应的proto文件"+PBD[cmd]);
                return;
            }
            let ins = new cls(data);
            var bytebuff = ins.toArrayBuffer();
            var bs:egret.ByteArray = new egret.ByteArray();
            bs.writeInt(cmd);
            bs.writeBytes(new egret.ByteArray(bytebuff));
            this._sock.writeBytes(bs);
            this._sock.flush();
            bs.clear();
            bs = null;
            console.log("发送数据：",cmd, data)
        }

        private getPBCls(name:string)
        {
            if(!name)return null;
            if(this._PBClsDic[name] == undefined)
            {
                this._PBClsDic[name] = this._protobuf.build(name);
            }
            return this._PBClsDic[name];
        }
    }

}