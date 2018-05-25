module cyj {
    export interface INetHandler{
        
        initSock(sock:egret.WebSocket);
        onConnect();
        onDisconnect();
        recv(data:egret.ByteArray);
    }

}