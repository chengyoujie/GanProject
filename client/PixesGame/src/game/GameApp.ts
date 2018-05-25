module game{
    export class GameApp
    {
        private static _stage:egret.DisplayObject;

        private static _renderList:Array<cyj.IRender>;
        private static _sock:cyj.GameSocket;
        private static _netHandler:ProtobufNetHandler;

        public constructor() {
            console.log("应用启动中");
        }

        public static start(stage:egret.DisplayObject)
        {
            this._renderList = new Array<cyj.IRender>();
            this._sock= new cyj.GameSocket();
            //开始连接socket
            this._netHandler = new  ProtobufNetHandler();
            this._netHandler.addEventListener(ProtobufNetHandler.EVENT_SOCK_CONNECT, this.handleSocketLinked, this);
             this._sock.init("192.168.2.61", 8893, this._netHandler);
            this._stage = stage;
            this._stage.addEventListener(egret.Event.ENTER_FRAME, this.handleRender, this);
        }

        // public get stage()
        // {
        //     return this._stage;
        // }


        private static handleRender(e:egret.Event)
        {
            for(var i:number=0; i<this._renderList.length; i++)
            {
                this._renderList[i].render();
            }
        }

        public static get net():ProtobufNetHandler
        {
            return this._netHandler;
        }


        private static handleSocketLinked(e:egret.Event)
        {
            this._netHandler.regListenerCmd(NetCMD.CMD_MOVE_C, this.handleGetData, this);
            this._netHandler.send(NetCMD.CMD_MOVE_C, {x:23, y:32});
        }

        private static  handleGetData(data:any)
        {
            console.log("Get The Data:", data);
            console.log("This is :", this);
        }

    }
}