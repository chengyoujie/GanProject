//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (c) 2014-present, Egret Technology.
//  All rights reserved.
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in the
//       documentation and/or other materials provided with the distribution.
//     * Neither the name of the Egret nor the
//       names of its contributors may be used to endorse or promote products
//       derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY EGRET AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
//  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
//  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL EGRET AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
//  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;LOSS OF USE, DATA,
//  OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
//  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
//  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//////////////////////////////////////////////////////////////////////////////////////

class Main extends egret.DisplayObjectContainer {
 

    
    public constructor() {
        super();
        if(this.stage==null)
        {
            this.addEventListener(egret.Event.ADDED_TO_STAGE, this.onAddToStage, this);
        }else{
            this.onAddToStage();
        }

    }

    private onAddToStage(event?: egret.Event) {

        // this.bg = new egret.Bitmap();
        // this.addChild(this.bg);

    //    var imgloader:egret.ImageLoader = new egret.ImageLoader();
    //    imgloader.addEventListener(egret.Event.COMPLETE, this.handleImageLoaded, this);
    //    imgloader.load("resource/images/test.png");
    //    this.stage.addEventListener(egret.TouchEvent.TOUCH_MOVE, this.handleTouchMove, this);

    //    var imgloader:egret.ImageLoader = new egret.ImageLoader();
    //    imgloader.addEventListener(egret.Event.COMPLETE, this.handleBgImageLoaded, this);
    //    imgloader.load("resource/images/bg.png");


        //初始化Resource资源加载库
        RES.addEventListener(RES.ResourceEvent.CONFIG_COMPLETE, this.onConfigComplete, this);
        RES.loadConfig("resource/default.res.json", "resource/");
    }


    private onConfigComplete(event:RES.ResourceEvent):void {
        RES.removeEventListener(RES.ResourceEvent.CONFIG_COMPLETE, this.onConfigComplete, this);
        RES.addEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
        RES.addEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR, this.onResourceLoadError, this);
        RES.addEventListener(RES.ResourceEvent.GROUP_PROGRESS, this.onResourceProgress, this);
        RES.addEventListener(RES.ResourceEvent.ITEM_LOAD_ERROR, this.onItemLoadError, this);
        RES.loadGroup("preload");
    }

    private onResourceLoadComplete(event:RES.ResourceEvent):void {
        if (event.groupName == "preload") {
            RES.removeEventListener(RES.ResourceEvent.GROUP_COMPLETE, this.onResourceLoadComplete, this);
            RES.removeEventListener(RES.ResourceEvent.GROUP_LOAD_ERROR, this.onResourceLoadError, this);
            RES.removeEventListener(RES.ResourceEvent.GROUP_PROGRESS, this.onResourceProgress, this);
            RES.removeEventListener(RES.ResourceEvent.ITEM_LOAD_ERROR, this.onItemLoadError, this);
        }
    }
    /**
     * 资源组加载出错
     * Resource group loading failed
     */
    private onResourceLoadError(event:RES.ResourceEvent):void {
        //TODO
        console.warn("Group:" + event.groupName + " has failed to load");
        //忽略加载失败的项目
        //ignore loading failed projects
        this.onResourceLoadComplete(event);
    }
     /**
     * 资源组加载出错
     *  The resource group loading failed
     */
    private onItemLoadError(event:RES.ResourceEvent):void {
        console.warn("Url:" + event.resItem.url + " has failed to load");
    }
    /**
     * preload资源组加载进度
     * loading process of preload resource
     */
    private onResourceProgress(event:RES.ResourceEvent):void {
        if (event.groupName == "preload") {
            console.log(event.itemsLoaded, event.itemsTotal);
            game.GameApp.start(this.stage);
        }
    } 

    // private bg:egret.Bitmap;
    // private handleBgImageLoaded(event:egret.Event)
    // {
    //      var imgload:egret.ImageLoader = event.currentTarget;
    //     var bmd:egret.BitmapData = imgload.data;
    //     var txture:egret.Texture = new egret.Texture();
    //     txture.bitmapData = bmd;
    //     this.bg.$setBitmapData(txture);
    // }

    // private handleImageLoaded(event:egret.Event)
    // {
    //     var imgload:egret.ImageLoader = event.currentTarget;
    //     var bmd:egret.BitmapData = imgload.data;
    //     var ani:cyj.Animation = new cyj.ClipAnimation(bmd, 4, 4, 5);
    //     this.addChild(ani);
    //     ani.setPlayIndex(0, 3);
    //     this._renderList.push(ani);
    //     ani.x = 250;
    //     ani.y = 250;

    //     //var mask:cyj.LightMask = new cyj.LightMask();
    //     this.maskLight.setMaskSize(this.stage.stageWidth, this.stage.stageHeight);
    //     this.maskLight.setLightValue(200);
    //     this.addChild(this.maskLight);
    //     this.maskLight.x = 0;
    //     this.maskLight.y = 0;
    // }
    // private maskLight:cyj.LightMask = new cyj.LightMask();
    // private handleTouchMove(e:egret.TouchEvent)
    // {
    //     // this.maskLight.x = e.stageX;
    //     // this.maskLight.y = e.stageY; 
    //     this.maskLight.setLightPos(e.stageX, e.stageY);
    // }

 



   
}


