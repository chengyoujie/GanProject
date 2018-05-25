module cyj {

    export class GameSocket{

        private _sock:egret.WebSocket;
        private _handler:INetHandler;

        public constructor()
        {
            this._sock= new egret.WebSocket();
            this._sock.addEventListener(egret.Event.CONNECT, this.handleSocketConnect, this);
            this._sock.addEventListener(egret.ProgressEvent.SOCKET_DATA, this.handleSocketRecv, this);
            this._sock.addEventListener(egret.IOErrorEvent.IO_ERROR, this.handleSocketIoError, this);
            this._sock.type = egret.WebSocket.TYPE_BINARY;
        }

        public init(ip:string, port:number, handler:INetHandler)
        {
            if(this._sock.connect)
                this._sock.close();
            // this._sock.connect(ip, port);
            this._handler = handler;
            this._handler.initSock(this._sock);
            this._sock.connectByUrl("ws://"+ip+":"+port+"/ws");
        }

        private handleSocketConnect():void
        {
            console.log("Socket 连接成功");
            this._handler.onConnect();
            // var msg = dcodeIO.ProtoBuf.loadProto(msgstr);
            // var person_cls = msg.build("move");
            // var person = new person_cls({
            //     "x":100,
            //     "y":200,
            // });
            // var bytes = person.toArrayBuffer();
            // var bs:egret.ByteArray = new egret.ByteArray(bytes);
            // this._sock.writeBytes(bs);
            // this._sock.flush();
        }
        private handleSocketRecv(e:egret.ProgressEvent):void
        {
            let bytes:egret.ByteArray = new egret.ByteArray();
            (this._sock.readBytes(bytes));
            this._handler.recv(bytes);
            bytes.clear();
            bytes = null;
            // var msg = dcodeIO.ProtoBuf.loadProto(RES.getRes("msg.proto"));
            // var person_cls = msg.build("move");
            // var decodePerson = person_cls.decode(bytes.buffer);
            // console.log("反序列化数据：", decodePerson);
        }
        private handleSocketIoError():void
        {
            console.log("Socket  IO错误");
            if(this._handler)
                this._handler.onDisconnect();
        }

    }
}