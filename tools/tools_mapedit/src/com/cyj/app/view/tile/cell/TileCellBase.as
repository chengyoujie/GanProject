package com.cyj.app.view.tile.cell
{
	import com.cyj.app.data.TileLayerData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.utils.getQualifiedClassName;
	
	public class TileCellBase extends Sprite
	{
		
		private var _bmp:Bitmap;
		private var _bd:Object;//BitmapData int(Color)
		private var _lightSp:Shape;
		private var _w:int;
		private var _h:int;
		private var _bordSp:Shape;
		private var _bg:Shape;
		private var _cellColor:Shape;
		
		private var _select:Boolean = false;
		private var _showBorder:Boolean= true;
		private var _bgAlpha:Number = 0.1;
		private var _index:int;
		private var _type:int;
		
		
		public function TileCellBase(w:int, h:int, $index:int, $type:int)
		{
			super();
			_w = w;
			_h = h;
			_index = $index;
			_type = $type;
			init();
			initEvent();
		}
		
		private function init():void
		{
			_bmp = new Bitmap();
			this.addChild(_bmp);
			
			_bg = new Shape();
			this.addChild(_bg);
			
			_bordSp = new Shape();
			this.addChild(_bordSp);
			
			_cellColor = new Shape();
			this.addChild(_cellColor);
			
			_lightSp = new Shape();
			this.addChild(_lightSp);
			_lightSp.visible = false;
			
			setImage(null);
			setSize(_w, _h);
			
		}
		protected function initEvent():void
		{
			this.addEventListener(MouseEvent.ROLL_OVER, handleMouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, handleMouseOut);
		}
		
		public function setSize(w:int, h:int):void
		{
			_w = w;
			_h = h;
			//背景
			_bg.graphics.clear();
			_bg.graphics.beginFill(0xf5f5f5, _bgAlpha);
			_bg.graphics.drawRect(0, 0, _w, _h);
			_bg.graphics.endFill();
			//边框
			if(_showBorder)
			{
				_bordSp.graphics.clear();
				_bordSp.graphics.lineStyle(1, 0x888888, 0.1);
				_bordSp.graphics.drawRect(0, 0, _w, _h);
				_bordSp.graphics.endFill();
			}else{
				_bordSp.graphics.clear();
			}
			//移入效果
			_lightSp.graphics.clear();
			_lightSp.graphics.beginFill(0xd3d3d3, 0.2);
			_lightSp.graphics.drawRect(0, 0, _w, _h);
			_lightSp.graphics.endFill();
		}
		
		
		public function setImage(bd:Object):void
		{
//			if(_type == TileLayerData.TYPE_DRAW && bd is bitmapData && 
			if(bd is Number)
			{
				if(_type != TileLayerData.TYPE_LOGIC)return;
			}else if(bd is BitmapData)
			{
				if(_type == TileLayerData.TYPE_LOGIC)return;
			}
			_bd = bd;
			_cellColor.graphics.clear();
			this._bmp.bitmapData = null;
			if(_bd is BitmapData)
			{
				this._bmp.bitmapData = _bd as BitmapData;	
			}
			if(bd is Number){
				_cellColor.graphics.beginFill(int(_bd), 0.5);
				_cellColor.graphics.drawRect(0, 0, _w, _h);
				_cellColor.graphics.endFill();
			}else {
				
			}
			if(_bd && _bd is BitmapData)
			{
				_lightSp.graphics.clear();
				_lightSp.graphics.beginFill(0xB8FFF0, 0.2);
				_lightSp.graphics.drawRect(0, 0, _bd.width, _bd.height);
				_lightSp.graphics.endFill();
			}else{
				_lightSp.graphics.clear();
				_lightSp.graphics.beginFill(0xB8FFF0, 0.2);
				_lightSp.graphics.drawRect(0, 0, _w, _h);
				_lightSp.graphics.endFill();
			}
		}
		
		public function clearn():void
		{
			setImage(null);
//			_cellColor.graphics.clear();
		}
		
		public function dispose():void
		{
			if(_bd)
			{
//				_bd.dispose();
				_bd = null;
			}
		}
		
		public function clone():TileCellBase
		{
			var cell:TileCellBase = new TileCellBase(_w, _h, index, _type);
//			if(_bd)
//			{
//				var bd:BitmapData = new BitmapData(_bd.width, _bd.height, true, 0);
//				bd.copyPixels(_bd, new Rectangle(0, 0, _bd.width, _bd.height), new Point());
//				cell.setImage(bd);
//			}
			cell.setImage(_bd);
			cell.x = this.x;
			cell.y = this.y;
			return cell;
		}
		
		public function get bitmapData():Object
		{
			return _bd;
		}
		public function get index():int
		{
			return _index;
		}
		
		
		private function handleMouseOver(e:MouseEvent):void
		{
			_lightSp.visible = true;
		}
		
		private function handleMouseOut(e:MouseEvent):void
		{
			if(_select==false)
				_lightSp.visible = false;
			
		}
		
		
		public function set select(value:Boolean):void
		{
			_select = value;
			_lightSp.visible = _select;
		}
		public function get select():Boolean
		{
			return _select;
		}
		public function set showBorder(value:Boolean):void
		{
			_showBorder = value;
			if(_showBorder)
			{
				_bordSp.graphics.clear();
				_bordSp.graphics.lineStyle(1, 0x888888, 0.1);
				_bordSp.graphics.drawRect(0, 0, _w, _h);
				_bordSp.graphics.endFill();
			}else{
				_bordSp.graphics.clear();
			}
		}
		
		public function set bgAlpha(value:Number):void
		{
			_bgAlpha = value;
			_bg.graphics.clear();
			_bg.graphics.beginFill(0xf5f5f5, _bgAlpha);
			_bg.graphics.drawRect(0, 0, _w, _h);
			_bg.graphics.endFill();
		}
		
	}
}