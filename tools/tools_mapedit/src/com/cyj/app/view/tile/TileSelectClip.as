package com.cyj.app.view.tile
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ProjectConfig;
	import com.cyj.app.view.tile.cell.TileCellBase;
	import com.cyj.utils.ObjectUtils;
	
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class TileSelectClip
	{
		
		
		public static const OPER_NORMAL:String=  "OPER_NORMAL";
		public static const OPER_EARS:String = "OPER_EARS";
		public static const OPER_FILL:String = "OPER_FILL";
		
		public function TileSelectClip()
		{
		}
		/**如果是TileCellBase 则表示单个图块， 如果是Array[[tile0, tile1][tile2,tile3]] 则表示多个图块**/
		private var _clipData:*;
		private var _tempBd:BitmapData;
		private var _oper:String;
		private var _tempGraph:Shape = new Shape();
		
		public function get bitmapData():BitmapData
		{
			if(_clipData==null)return null;
			if(_tempBd)
			{
				return _tempBd;
			}
			if(_clipData is TileCellBase)
			{
				return getCellBitampData(TileCellBase(_clipData));
			}else if(_clipData is Array)
			{
				if(_clipData.length == 1)
				{
					return getCellBitampData(TileCellBase(_clipData[0]));
				}
				var startcell:TileCellBase = _clipData[0];
				var endcell:TileCellBase = _clipData[_clipData.length-1];
				_tempBd = new BitmapData(endcell.x-startcell.x+startcell.width, endcell.y-startcell.y+startcell.height, true, 0x2Fdcdcdc);
				var cell:TileCellBase;
				var rect:Rectangle = new Rectangle(0, 0, startcell.width, startcell.height);
//				var po:Point = new Point();
				var matr:Matrix = new Matrix();
				for(var i:int=0;i<_clipData.length; i++)
				{
					cell = _clipData[i];
					if(cell && cell.bitmapData)
					{
						rect.width = cell.width;
						rect.height = cell.height;
//						po.x = cell.x - startcell.x;
//						po.y = cell.y-startcell.y;
						matr.identity();
						matr.tx = (cell.x - startcell.x);
						matr.ty = (cell.y-startcell.y);
						rect.x = cell.x - startcell.x;
						rect.y = cell.y-startcell.y;
						_tempBd.draw(cell, matr, null, null, rect);
//						_tempBd.copyPixels(cell.bitmapData, rect, po);//, new Point(cell.x - startcell.x, cell.y-startcell.y));
					}
				}
				return _tempBd;
			}else if(_clipData is Number)
			{
				var cfg:ProjectConfig = ToolsApp.project;
				_tempGraph.graphics.clear();
				_tempGraph.graphics.beginFill(_clipData, 0.8);
				_tempGraph.graphics.drawRect(0,0, cfg.logicw, cfg.logich);
				_tempGraph.graphics.endFill();
				_tempBd =  new BitmapData( cfg.logicw, cfg.logich, true, 0);
				_tempBd.draw(_tempGraph);
				return _tempBd;
			}
			return null;
		}
		
		private function getCellBitampData(cell:TileCellBase):BitmapData
		{
			if(cell.bitmapData is BitmapData)	
			{
				return cell.bitmapData as BitmapData;
			}else if(cell.bitmapData)
			{
				_tempBd = new BitmapData(cell.width, cell.height, true, 0);
				_tempBd.draw(cell);
				return _tempBd;
			}
			return null;
		}
		
		public function set oper(value:String):void
		{
			_oper = value;
			if(_oper == OPER_EARS)
			{
				clipData = null;
				
			}else{
				
			}
		}
		public function get oper():String
		{
			return _oper;
		}
		
		public function get haveData():Boolean
		{
			return _clipData != null || _oper == OPER_EARS;
		}
		
		public function set clipData(value:*):void
		{
			if(_clipData)
			{
				clearData();
			}
			_clipData = cloneData(value);
			ToolsApp.view.tileMain.viewTileMap.refushMouseClip();
		}
		
		public function get clipData():*
		{
			return _clipData;
		}
		
		private function clearData():void
		{
			if(_clipData is TileCellBase)
			{
				TileCellBase(_clipData).dispose();
				_clipData = null;
			}else if(_clipData is Array)
			{
				var cell:TileCellBase;
				for(var i:int=0; i<_clipData.length; i++)
				{
					cell = _clipData[i];
					if(cell)
					{
						cell.dispose();
						cell = null;
					}
				}
				_clipData = null;
			}
			if(_tempBd)
			{
				_tempBd.dispose();
				_tempBd = null;
			}
		}
		
		
		private function cloneData(value:Object):Object
		{
			if(value is TileCellBase)
			{
				return TileCellBase(value).clone();
			}else if(value is Array)
			{
				var cell:TileCellBase;
				var arr:Array = [];
				for(var i:int=0; i<value.length; i++)
				{
					cell = value[i];
					if(cell)
					{
						arr.push(cell.clone());
					}
				}
				return arr;
			}
			return value;
		}
		
		
		
	}
}