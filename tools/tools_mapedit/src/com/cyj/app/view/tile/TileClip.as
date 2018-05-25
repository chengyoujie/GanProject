package com.cyj.app.view.tile
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.TileImgData;
	import com.cyj.app.data.TileLayerData;
	import com.cyj.app.view.tile.cell.TileCellImg;
	import com.cyj.app.view.tile.imglist.TileListItem;
	import com.cyj.app.view.ui.mapreversal.tileClipUI;
	import com.cyj.utils.ObjectUtils;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	

	public class TileClip extends tileClipUI
	{
		private var _content:Sprite;
		private var _bd:BitmapData;
		private var _data:TileImgData;
		private var _item:TileListItem;
		
		public function TileClip()
		{
			super();
			init();
		}
		
		
		private function init():void
		{
			_content = new Sprite();
			this.addChild(_content);
			_content.addEventListener(MouseEvent.CLICK, handleSetTile);
			
			
		}
		
		private function handleItemReaded(e:Event):void
		{
			_item.removeEventListener(Event.COMPLETE, handleItemReaded);
			setTileClip(_item);
		}
		
		public function setTileClip(item:TileListItem):void
		{
			if(item == null)return;
			if(_item)
			{
				_item.removeEventListener(Event.COMPLETE, handleItemReaded);
				clearn();
			}
			_item = item;
			if(item.isReady==false)
			{
				item.addEventListener(Event.COMPLETE, handleItemReaded);
				return;
			}
			_bd = item.bitmapData;
			_data = item.data;
			initCell();
			for(var i:int=0; i<_content.numChildren; i++)
			{
				var cell:TileCellImg =_content.getChildAt(i) as TileCellImg;
				if(cell==null)continue;
				var d:BitmapData = new BitmapData(cell.width, cell.height, true, 0);
				d.copyPixels(_bd, new Rectangle(cell.x, cell.y, _data.itemw, _data.itemh), new Point(0, 0));
				cell.setImage(d);
			}
		}
		
		private function handleSetTile(e:MouseEvent):void
		{
			var cell:TileCellImg = e.target as TileCellImg;
			if(cell==null)return;
			if(cell.bitmapData)
				ToolsApp.view.tileMain.curUseTile.clipData = cell;
		}
		
		private function initCell():void
		{
			if(_data == null)return;
			clearn();
			for(var i:int=0; i<_data.numx; i++)
			{
				for(var j:int=0; j<_data.numy; j++)
				{
					var cell:TileCellImg = new TileCellImg(_data.itemw, _data.itemh, i*_data.itemw+j*_data.itemh, TileLayerData.TYPE_BG);
					cell.x = i*(_data.itemw+_data.spacex)+_data.startx;
					cell.y = j*(_data.itemh+_data.spacey)+_data.starty;
					_content.addChild(cell);
				}
			}
			resize();
		}
		
		public function clearn():void
		{
			ObjectUtils.removeAllChild(_content);
		}
		
		
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
