module cyj {
	export class ClipAnimation extends Animation {

		private _bmd:egret.BitmapData;
		private _row:number = 1;
		private _col:number = 1;
		//private _imageVec:Array<egret.RenderTexture>;

		public constructor(bmd:egret.BitmapData, row:number, col:number, frameRate:number=2) {
			super(frameRate);
			this._bmd = bmd;
			this._row = row;
			this._col = col;
			this.init();
		}

		protected init()
		{
			var wsize:number = this._bmd.width/this._row;
			var hsize:number = this._bmd.height/this._col;
			var rect:egret.Rectangle = new egret.Rectangle();
			var txture:egret.Texture = new egret.Texture();
			txture.bitmapData = this._bmd;
			var tempbd:egret.Bitmap = new egret.Bitmap(txture);
			this._imageVec = new Array<egret.RenderTexture>();
			
			for(var i:number=0; i<this._row; i++)
			{
				for(var j:number=0; j<this._col; j++)
				{
					var img:egret.RenderTexture = new egret.RenderTexture();
					rect.x = j*wsize;
					rect.y = i*hsize;
					rect.width = wsize;
					rect.height = hsize;
					img.drawToTexture(tempbd, rect,1);	
					this._imageVec.push(img);
				}
			}

			this.graphics.clear();
			this.graphics.beginFill(0xcc0000, 1);
			this.graphics.drawRect(0, 0, 5, 5);
			this.graphics.endFill();
		}


	}
}