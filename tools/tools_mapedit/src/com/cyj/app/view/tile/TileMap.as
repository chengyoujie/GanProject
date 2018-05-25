package com.cyj.app.view.tile
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ProjectConfig;
	import com.cyj.app.data.TileLayerData;
	import com.cyj.app.data.ToolsConfig;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.tile.cell.TileCellBase;
	import com.cyj.app.view.tile.cell.TileCellBg;
	import com.cyj.app.view.tile.cell.TileCellDraw;
	import com.cyj.app.view.tile.cell.TileCellImg;
	import com.cyj.app.view.tile.layer.TileLayer;
	import com.cyj.app.view.ui.mapreversal.tileMapUI;
	import com.cyj.utils.Log;
	import com.cyj.utils.ObjectUtils;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;

	public class TileMap extends tileMapUI
	{
		private var _content:Sprite;
		private var _mouse:Bitmap;
		private var _layerContent:Sprite;
		private var _popContent:Sprite;
		
		public function TileMap()
		{
			super();
			init();
		}
		
		private function init():void
		{
			_content = new Sprite();
			this.addChild(_content);
			_layerContent = new Sprite();
			this.addChild(_layerContent);
			
			_popContent = new Sprite();
			this.addChild(_popContent);
			
			_mouse = new Bitmap();
			this.addChild(_mouse);
			
			this.addEventListener(MouseEvent.ROLL_OVER, handelMouseEnter);
			this.addEventListener(MouseEvent.ROLL_OUT, handleMouseOut);
			this.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			this.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, handleRightMouseDown);
			this.addEventListener(MouseEvent.RIGHT_MOUSE_UP, handleRightMouseUp);
			
			for(var i:int=0; i<19; i++)
			{
				for(var j:int=0; j<19; j++)
				{
					var cell:TileCellBg = new TileCellBg(32, 32,i+j* 32, TileLayerData.TYPE_BG);
					cell.x = j*32;
					cell.y = i*32;
					_content.addChild(cell);
				}
			}
			resize();
		}
		
		public function initProject():void
		{
			ObjectUtils.removeAllChild(_content);
			ObjectUtils.removeAllChild(_layerContent);
			var project:ProjectConfig = ToolsApp.project;
			if(project == null)return;
			for(var i:int=0; i<project.numy; i++)
			{
				for(var j:int=0; j<project.numx; j++)
				{
					var cell:TileCellBg = new TileCellBg(project.itemw, project.itemh,project.getIndex(i,j), TileLayerData.TYPE_BG);
					cell.x = j*project.itemw;
					cell.y = i* project.itemh;
					_content.addChild(cell);
				}
			}
			resize();
		}
		
		
//图层相关Begin
		public function addLayer(layer:TileLayerData, index:int):void
		{
//			var lay:TileLayer = new TileLayer(layer);
			//_layerContent.addChildAt(lay, index);
			sortLayer();
		}
		public function removeLayer(layer:TileLayerData):void
		{
			var lay:TileLayer = layer.getLayer();
			if(lay && _layerContent.contains(lay))
			{
				_layerContent.removeChild(lay); 
			}
		}
		
		public function sortLayer():void
		{
			ObjectUtils.removeAllChild(_layerContent);
			var list:Array = ToolsApp.view.tileMain.viewTileLayerList.layerList;
			var lay:TileLayerData;
			for(var i:int=list.length-1; i>=0; i--)
			{
				lay = list[i];
				if(lay.getLayer()==null)continue;
				_layerContent.addChild(lay.getLayer());
			}
		}
		
//图层相关End
		private function handleRightMouseDown(e:MouseEvent):void
		{
			tempMousePos.x = e.stageX;
			tempMousePos.y = e.stageY;
		}
		private function handleRightMouseUp(e:MouseEvent):void
		{
			if(Math.abs(e.stageX-tempMousePos.x)<=10 && Math.abs(e.stageY-tempMousePos.y)<=10)
			{
				ToolsApp.view.tileMain.curUseTile.clipData = null;
			}
		}
		
		
		private function handelMouseEnter(e:MouseEvent=null):void
		{
//			if(ToolsApp.view.tileMain.curUseTile.haveData)
//			{
//				Mouse.hide();
				this.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
//				this._mouse.bitmapData= ToolsApp.view.tileMain.curUseTile.bitmapData;
//			}
				refushMouseClip();
		}
		
		public function refushMouseClip():void
		{
//			if(ToolsApp.view.tileMain.curUseTile.haveData)
//			{
				//				Mouse.hide();
//				this.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
				this._mouse.bitmapData= ToolsApp.view.tileMain.curUseTile.bitmapData;
//			}
		}
		
		private function handleMouseOut(e:MouseEvent):void
		{
			this._mouse.bitmapData=  null;
			this.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
//			Mouse.show();
		}
		
		private var tempMousePos:Point = new Point();
		private function handleMouseMove(e:MouseEvent):void{
			var tile:TileCellBase = e.target as TileCellBase;
			if(tile)
			{
				this._mouse.x = tile.x;
				this._mouse.y = tile.y;
			}else{
				tempMousePos.x = e.stageX;
				tempMousePos.y = e.stageY;
				tempMousePos= this.globalToLocal(tempMousePos);
				this._mouse.x = tempMousePos.x;
				this._mouse.y = tempMousePos.y;
			}
		}
		
		
//绘制图片
//鼠标按下  移动时绘制		
		private var tempMouseClickPos:Point = new Point();
		private var tempMouseClickRect:Rectangle = new Rectangle();
		private var tempSelectArr:Array = [];
		private function handleMouseDown(e:MouseEvent):void
		{
			if(ToolsApp.view.tileMain.curOperLayer==null)
			{
				Alert.show("当前没有选择图层，无法完成操作");
				return;
			}
			if(canDraw()==false)return;
			Log.log("当前正在绘制到："+ToolsApp.view.tileMain.curOperLayer.data.name);
			//绘制到逻辑层
			var tile:TileCellDraw;
			if(ToolsApp.view.tileMain.curOperLayer.data.type == TileLayerData.TYPE_LOGIC)
			{
				
				if(ToolsApp.view.tileMain.curUseTile.haveData)
				{
					tile = e.target as TileCellDraw;
					if(tile)
					{
						ToolsApp.view.tileMain.curOperLayer.fillCell(tile.index, ToolsApp.view.tileMain.curUseTile.clipData);
					}
				}else{
					tempMouseClickPos.x = e.stageX;
					tempMouseClickPos.y = e.stageY;
					tempMouseClickPos= this.globalToLocal(tempMouseClickPos);
				}
			}else
			{
				if(ToolsApp.view.tileMain.curUseTile.haveData)
				{
					tile = e.target as TileCellDraw;
					if(tile)
					{
						ToolsApp.view.tileMain.curOperLayer.fillCell(tile.index, ToolsApp.view.tileMain.curUseTile.clipData);
					}
				}else{
					tempMouseClickPos.x = e.stageX;
					tempMouseClickPos.y = e.stageY;
					tempMouseClickPos= this.globalToLocal(tempMouseClickPos);
				}
			}
			
			this.addEventListener(MouseEvent.MOUSE_OVER, handleMoveDraw);
			this.addEventListener(MouseEvent.MOUSE_UP, handleStopDraw);
		}
		
		private function canDraw():Boolean
		{
			var layerData:TileLayerData = ToolsApp.view.tileMain.curOperLayer.data;
			var data:Object = ToolsApp.view.tileMain.curUseTile.clipData;
			if(layerData.lock)
			{
				Alert.show("图层已经锁了, 无法操作");
				return false;
			}
			if(layerData.visible==false)
			{
				Alert.show("图层隐藏了, 无法操作");
				return false;
			}
			if(layerData.type == TileLayerData.TYPE_LOGIC)
			{
				if(data && !(data is Array)&& !(data is Number))
				{
					Alert.show("逻辑层不能绘制图片");
					return false;
				}
			}else if(layerData.type == TileLayerData.TYPE_DRAW)
			{
				if(data is Number)
				{
					Alert.show("绘制层不能绘制逻辑数据");
					return false;
				}
			}
			return true;
		}
		
		private function handleMoveDraw(e:MouseEvent):void
		{
			if(ToolsApp.view.tileMain.curOperLayer==null)
			{
//				Alert.show("当前没有选择图层，无法完成操作");
				return;
			}
			if(ToolsApp.view.tileMain.curUseTile.haveData)
			{
				var tile:TileCellDraw = e.target as TileCellDraw;
				if(tile)
				{
					ToolsApp.view.tileMain.curOperLayer.fillCell(tile.index, ToolsApp.view.tileMain.curUseTile.clipData);
				}
			}else{//选择一定范围的内容
				tempMousePos.x = e.stageX;
				tempMousePos.y = e.stageY;
				tempMousePos= this.globalToLocal(tempMousePos);
				_popContent.graphics.clear();
				_popContent.graphics.lineStyle(1, 0xff0000, 0.8);
				tempMouseClickRect.left = Math.min(tempMouseClickPos.x, tempMousePos.x);
				tempMouseClickRect.top = Math.min(tempMouseClickPos.y, tempMousePos.y);
				tempMouseClickRect.width = Math.abs(tempMouseClickPos.x-tempMousePos.x);
				tempMouseClickRect.height = Math.abs(tempMouseClickPos.y-tempMousePos.y);
				_popContent.graphics.drawRect(tempMouseClickRect.x, tempMouseClickRect.y,tempMouseClickRect.width, tempMouseClickRect.height); 
				_popContent.graphics.endFill();
				var cell:TileCellBase;
				if(tempSelectArr.length>0)
				{
					
					for(var i:int=0; i<tempSelectArr.length; i++)
					{
						cell = tempSelectArr[i];
						if(cell)
							cell.select = false;
					}
					tempSelectArr.length = 0;
				}
				var project:ProjectConfig = ToolsApp.project;
				var w:int =project.itemw;
				var h:int = project.itemh;
				var numx:int = project.numx;
				var numy:int = project.numy;
				if(ToolsApp.view.tileMain.curOperLayer.data.type==TileLayerData.TYPE_LOGIC)
				{
					w = project.logicw;
					h = project.logich;
					numx = Math.ceil((project.numx*project.itemw)/project.logicw);
					numy = Math.ceil((project.numy*project.itemh)/project.logich);
				}
				if(tempMouseClickRect.width>10 && tempMouseClickRect.height>10)
				{
					var endx:int = Math.ceil(tempMouseClickRect.right/w);
					var endy:int = Math.ceil(tempMouseClickRect.bottom/h);
					endx = Math.min(numx, endx);
					endy = Math.min(numy, endy);
					Log.log("当前选择区域 x:"+tempMouseClickRect.x+", y:"+tempMouseClickRect.y+" w:"+tempMouseClickRect.width+", h:"+tempMouseClickRect.height);
					tempSelectArr.len = Math.abs(endx-Math.floor(tempMouseClickRect.x/w));
					for(var sx:int = Math.floor(tempMouseClickRect.x/w); sx<endx; sx++)
					{
						for(var sy:int=Math.floor(tempMouseClickRect.y/h); sy<endy; sy++)
						{
							cell = ToolsApp.view.tileMain.curOperLayer.getCell(project.getIndex(sx, sy));
							if(cell)
							{
								cell.select=true;
								tempSelectArr.push(cell);
							}
						}
					}
				}
			}
		}
		private function handleStopDraw(e:MouseEvent):void
		{
			_popContent.graphics.clear();
			var cell:TileCellBase;
			if(tempSelectArr.length>0)
			{
				for(var i:int=0; i<tempSelectArr.length; i++)
				{
					cell = tempSelectArr[i];
					if(cell)
						cell.select = false;
				}
			}
			if(ToolsApp.view.tileMain.curUseTile.haveData == false)
			{
				if(tempSelectArr.length>1)
				{
					ToolsApp.view.tileMain.curUseTile.clipData = tempSelectArr;
				}else if(tempSelectArr.length == 1)
				{
					ToolsApp.view.tileMain.curUseTile.clipData = tempSelectArr[0];
				}
			}
			tempSelectArr.length = 0;
			
			this.removeEventListener(MouseEvent.MOUSE_OVER, handleMoveDraw);
			this.removeEventListener(MouseEvent.MOUSE_UP, handleStopDraw);
		}
		
//尺寸信息		
		override public function get height():Number
		{
			return _content.height;
		}
		
		
		override public function get width():Number
		{
			return _content.width;
		}
		
		private function resize():void
		{
			this.dispatchEvent(new Event(Event.RESIZE));
		}
		
		
	}
}