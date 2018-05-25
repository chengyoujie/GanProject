/**
    黑暗下点亮灯光效果类
	Made by cyj   
	2018.04.16
**/
module cyj {
	export class LightMask extends egret.Sprite{
		
		private cirleLight:egret.Shape;
		private lightMatrix:egret.Matrix;

		public constructor() {
			super();
			this.blendMode = egret.BlendMode.ERASE;
			this.graphics.beginFill(0xcc00cc);
			this.graphics.drawRect(0, 0, 500, 500);
			this.graphics.endFill();

			this.lightMatrix = new egret.Matrix();

			this.cirleLight = new egret.Shape();
			this.cirleLight.blendMode = egret.BlendMode.ERASE;
			this.addChild(this.cirleLight);
		}

		//设置光圈的位置
		public setLightPos(posx:number, posy:number)
		{
			this.cirleLight.x = posx;
			this.cirleLight.y = posy;
		}
		//设置背景框的大小
		public setMaskSize(maskW:number, maskH:number)
		{
			this.graphics.clear();
			this.graphics.beginFill(0xcc00cc);
			this.graphics.drawRect(0, 0, maskW, maskH);
			this.graphics.endFill();
		}
		//设置光圈的大小
		public setLightValue(light:number)
		{
			this.lightMatrix.createGradientBox(light*2, light*2, 0, -light, -light);
			this.cirleLight.graphics.clear();
			this.cirleLight.graphics.beginGradientFill(egret.GradientType.RADIAL, [0xffffff, 0xd3d3d3,0x888888, 0x000000], [1,0.9, 0.2,0],[0, 50, 180, 255], this.lightMatrix)
			//this.cirleLight.graphics.beginFill(0x00cc00);
			this.cirleLight.graphics.drawCircle(0, 0, light);
			this.cirleLight.graphics.endFill();
		}

	}
}