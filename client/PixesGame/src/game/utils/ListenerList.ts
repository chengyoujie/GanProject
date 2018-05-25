module game{
    export class ListenerList{
        private _listDic:object = {};
        
        public addListener(key:any, listenerFun:Function, thisp:any, priority?:number)
        {
            if(this._listDic[key] == undefined)
            {
                this._listDic[key] = new Array<ListenerItemData>();
            }
            let arr:Array<ListenerItemData> = this._listDic[key];
            let data:ListenerItemData = new ListenerItemData(listenerFun,thisp, priority);
            if(priority==undefined || arr.length==0)
            {
                arr.push(data);
            }else{
                for(let i:number=0; i<arr.length; i++)
                {
                    if(arr[i].priority<priority)
                    {
                        arr.splice(i, 0, data);
                        break;
                    }
                }
            }
        }


        public removeListener(key:any, listenerFun:Function, thisp:any, priority?:number)
        {
            if(this._listDic[key] == undefined)return;
            let arr:Array<ListenerItemData> = this._listDic[key];
            for(let i:number=0; i<arr.length; i++)
            {
                if(arr[i].fun == listenerFun && arr[i].priority==priority && arr[i].thisp == thisp)
                {
                    arr.splice(i, 1);
                    break;
                }
            }
        }

        public removeAllByKey(key:string)
        {
            if(this._listDic[key] == undefined)return;
            let arr:Array<ListenerItemData> = this._listDic[key];
           arr.length  = 0;
        }

        public exec(key:any,...arg)
        {
            if(this._listDic[key] == undefined)return;
            let arr:Array<ListenerItemData> = this._listDic[key];
            for(let i:number=0; i<arr.length; i++)
            {
                arr[i].exec(arg);
            }
        }

    }


    class ListenerItemData{
        public priority:number;
        public fun:Function;
        public thisp:any;
        public constructor(listenerFun:Function, thisp:any, priority?:number) {
            this.priority = priority;
            this.fun = listenerFun;
            this.thisp = thisp;
        }

        public exec(arg)
        {
            this.fun.apply(this.thisp, arg);
        }
    }
}