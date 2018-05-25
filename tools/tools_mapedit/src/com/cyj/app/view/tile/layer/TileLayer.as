package com.cyj.app.view.tile.layer
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ProjectConfig;
	import com.cyj.app.data.TileLayerData;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.tile.TileSelectClip;
	import com.cyj.app.view.tile.cell.TileCellBase;
	import com.cyj.app.view.tile.cell.TileCellDraw;
	
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class TileLayer extends Sprite
	{
		private var _data:TileLayerData;
		private var _content:Sprite;
		private var _cellDic:Dictionary = new Dictionary();
		private var _showBorder:Boolean = true;
		
		public function TileLayer(layerData:TileLayerData)
		{
			_data = layerData;
			super();
			_data.bindLayer(this);
			initView();
		}
		
		
		public function refushLock():void
		{
			var islock:Boolean = _data.lock;
			if(islock == false)
				islock = ToolsApp.view.tileMain.curOperLayer != this;
			this.mouseEnabled = this.mouseChildren= !islock;
		}
		public function refushVisible():void
		{
			this.visible = _data.visible;
		}
		
		public function set showBorder(value:Boolean):void
		{
			if(_showBorder == value)return;
			var cell:TileCellBase;
			_showBorder = value;
			for(var index:String in _cellDic)
			{
				cell = _cellDic[index];
				if(cell)
					cell.showBorder = value;
			}
		}
		public function get showBorder():Boolean
		{
			return _showBorder;
		}
								   
		
		private function initView():void
		{
			_content = new Sprite();
			this.addChild(_content);
			
			var project:ProjectConfig = ToolsApp.project;
			if(project == null)return;
			_cellDic = new Dictionary();
			var w:int =project.itemw;
			var h:int = project.itemh;
			var numx:int = project.numx;
			var numy:int = project.numy;
			if(_data.type==TileLayerData.TYPE_LOGIC)
			{
				w = project.logicw;
				h = project.logich;
				numx = Math.ceil((project.numx*project.itemw)/itemW);
				numy = Math.ceil((project.numy*project.itemh)/itemH);
			}
			for(var i:int=0; i<numx; i++)
			{
				for(var j:int=0; j<numy; j++)
				{
					var cell:TileCellDraw = new TileCellDraw(w, h, project.getIndex(i,j),_data.type);
					cell.x = i*w;
					cell.y = j*h;
					_cellDic[cell.index] = cell;
					_content.addChild(cell);
				}
			}
		}
		
		public function fillCell(index:int, fillData:*):void
		{
			if(_data==null || _data.lock || _data.visible==false)return;
			var cell:TileCellDraw = _cellDic[index];
			if(cell==null)
			{
				Alert.show("额， 索引超过了当前格子的范围");
				return;
			}
			if(ToolsApp.view.tileMain.curUseTile.oper == TileSelectClip.OPER_FILL)
			{
				var fills:Array = [];
				searchForFill(cell, cell, [], fills);
				var c:TileCellBase;
//				fills.sortOn("index", Array.NUMERIC);
				for(var i:int=0; i<fills.length; i++)
				{
					c = fills[i];
					fillOneCell(c, fillData, c.index-cell.index);
				}
			}else{
				fillOneCell(cell, fillData);
				
			}
		}
		
		
		private function fillOneCell(cell:TileCellBase, fillData:*, offsetIndex:int=0):void
		{
			if(fillData == null)
			{
				cell.clearn();
			}
			else if(fillData is Number)
			{
				cell.setImage(fillData);
			}else if(fillData is TileCellBase)
			{
				cell.setImage(TileCellBase(fillData).bitmapData);
			}else if(fillData is Array)
			{
				//ToDo 多选的情况
				if(fillData.length==0)return;
				else if(fillData.length == 1)cell.setImage(TileCellBase(fillData[0]).bitmapData);
				else if(ToolsApp.view.tileMain.curUseTile.oper == TileSelectClip.OPER_FILL)
				{
					var index:int = (offsetIndex%fillData.length);
					if(index<0)
						index = (index+fillData.length)%fillData.length;
					var startfillcell:TileCellBase = fillData[index];
					cell.setImage(startfillcell.bitmapData);
				}else {
					var startcell:TileCellBase = fillData[0];
					var tempcell:TileCellBase;
					var drawcell:TileCellBase;
					var project:ProjectConfig = ToolsApp.project;
					if(project==null)return;
					var w:int = itemW;
					var h:int = itemH;
					for(var i:int=0; i<fillData.length; i++)
					{
						tempcell = fillData[i];
						if(tempcell)
						{
							//							drawcell = getCell(cell.index+(tempcell.index-startcell.index));
							var sx:int = Math.ceil((cell.x + tempcell.x - startcell.x)/w);
							var sy:int= Math.ceil((cell.y + tempcell.y - startcell.y)/h);
							if(sx >= project.numx || sy >= project.numy)continue;
							drawcell = getCell(cell.index+(tempcell.index-startcell.index));
							if(drawcell)
								drawcell.setImage(tempcell.bitmapData);
						}
					}
				}
				
			}
		}
		
		
		private function searchForFill(cell:TileCellBase,startCell:TileCellBase, findedArr:Array, fillArr:Array):void
		{
			var curcell:TileCellBase;
			var project:ProjectConfig = ToolsApp.project;
			if(project==null)return;
			
			
			var w:int = itemW;
			var h:int = itemH;
			var sx:int = Math.floor(cell.x/w);
			var sy:int = Math.floor(cell.y/h);
			
			for(var i:int=-1; i<=1; i++)
			{
				for(var j:int=-1; j<=1; j++)
				{
//					if(i==0 && j==0)continue;
					if(i!=0 && j!=0)continue;//斜方向不去填充
					if(sx+i >=project.numx || sy+j>=project.numy)continue;
					curcell = getCell(project.getIndex(sx+i, sy+j));
					if(curcell && findedArr.indexOf(curcell)==-1 && curcell.bitmapData == startCell.bitmapData)
					{
						findedArr.push(curcell);
						fillArr.push(curcell);
						searchForFill(curcell, startCell, findedArr, fillArr);
					}else{
						findedArr.push(curcell);
					}
				}
			}
		}
		
		public function get itemW():int
		{
			var project:ProjectConfig = ToolsApp.project;
			if(project==null)1;
			return _data.type==TileLayerData.TYPE_LOGIC?project.logicw:project.itemw;
		}
		
		public function get itemH():int
		{
			var project:ProjectConfig = ToolsApp.project;
			if(project==null)1;
			return _data.type==TileLayerData.TYPE_LOGIC?project.logich:project.itemh
		}
		
		
		public function getCell(index:int):TileCellDraw
		{
			return _cellDic[index];
		}
		
		
		public function get data():TileLayerData
		{
			return _data;
		}
		
		
	}
}