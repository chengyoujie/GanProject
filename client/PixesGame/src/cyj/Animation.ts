module cyj {
	export class Animation extends egret.Sprite implements IRender{
		
		private _playIndex:number = 0;
		protected _imageVec:Array<egret.RenderTexture>;
		private _playFrom:number = 0;
		private _playTo:number = 0;
		private _frameGapTime:number = 0.2;
		private _lastRenderTime:number = 0;
		private _pause:boolean = false;
		private _image:egret.Bitmap;

		public constructor(frameRate:number=8) {
			super();
			this._frameGapTime = 1000/frameRate;
			this.initView();
			
		}

		private initView()
		{
			this._image = new egret.Bitmap();
			this.addChild(this._image);
		}

		protected init()
		{
			this._imageVec = new Array<egret.RenderTexture>();
		}


		
		/** 设置播放 开始结束帧*/
		public setPlayIndex(from:number, to:number)
		{
			this._playFrom = from;
			this._playTo = to;
			this._playIndex = from;
			this.renderFrame();
		}
		/** 设置播放帧频 */
		public setFrameRate(frameRate:number)
		{
			this._frameGapTime = 1000/frameRate;
		}
		/** 播放暂停 */
		public pause()
		{
			this._pause = true;
		}
		/** 继续播放 */
		public play()
		{
			this._pause = false;
		}
		/** 跳转到某一帧 并暂停 */
		public gotoAndStop(index:number)
		{
			if(index>=0 && index<this._imageVec.length)
			{
				this._pause = true;
				this._playIndex = index;
				this.renderFrame();
			}
		}
		/** 跳转到某一帧 并播放 （帧索引需要在设置的播放区间内） */
		public gotoAndPlay(index:number)
		{
			if(index>=this._playFrom && index<=this._playTo)
			{
				this._pause = false;
				this._playIndex = index;
				this.renderFrame();
			}
		}
		/** 渲染当前帧 */
		public renderFrame()
		{
			var img = this._imageVec[this._playIndex];
			this._image.texture = img;
			this._image.x = -img.textureWidth/2;
			this._image.y = -img.textureHeight;
		}

		public render()
		{
			if(this._pause)return;
			if(egret.getTimer()<this._lastRenderTime+this._frameGapTime)	
				return;
			this._lastRenderTime = egret.getTimer();
			this._playIndex ++;
			if(this._playIndex>this._playTo)
				this._playIndex = this._playFrom;
			this.renderFrame();
		}


	}
}