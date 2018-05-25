package com.cyj.app.view.tile.imglist
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.TileImgData;
	import com.cyj.app.view.ui.mapreversal.tileListItemUI;
	import com.cyj.utils.XML2Obj;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	
	import morn.core.handlers.Handler;

	public class TileListItem extends tileListItemUI
	{
		public static const EVENT_REMOVE:String = "EVNET_REMOVE_TileListItem";
		public static const EVENT_SETTING:String = "EVENT_SETTING_TileListItem";
		public static const EVENT_DATA_CHANGE:String = "EVENT_DATA_CHANGE_TileListItem";
		private var _imgFile:File;
		private var _dataFile:File;
		private var _bd:BitmapData;
		private var _data:TileImgData;
		private var _isReady:Boolean = false;
		
		
		public function TileListItem()
		{
			super();
			initEvent();
		}
		
		private function initEvent():void
		{
			btnTileDele.clickHandler = new Handler(handleDel);
			btnTileSetting.clickHandler = new Handler(handleSetting);
		}
		
		private function handleDel():void
		{ 
			if(_imgFile.exists)
				_imgFile.deleteFile();
			if(_dataFile.exists)
				_dataFile.deleteFile();
			dispatchEvent(new Event(EVENT_REMOVE,true));
		}
		private function handleSetting():void
		{
			dispatchEvent(new Event(EVENT_SETTING,true));   
		}
		
		
		override public function set dataSource(value:Object):void
		{
			var file:File = value as File;
			if(file == null)
			{
				txtTileName.text = "数据错误";
				return;
			}
			_isReady = false;
			_imgFile= file;
			ToolsApp.loader.loadSingleRes(_imgFile.url, ResLoader.IMG, handleImgLoaded);
			_dataFile = new File(_imgFile.parent.nativePath+"/"+_imgFile.name+".tileimg");
			txtTileName.text = _imgFile.name;
			txtTileName.color = 0xff0000;
			if(_dataFile.exists)
			{
				ToolsApp.loader.loadSingleRes(_dataFile.url, ResLoader.TXT, handleDataLoaded);
			}else{
				_data = new TileImgData();
			}
		}
		
		
		private function handleImgLoaded(res:ResData):void
		{
			_bd = res.data;
			if(_dataFile.exists==false)
			{
				_data.imgw= _bd.width;
				_data.imgh = _bd.height;
				_data.spacex = 0;
				_data.spacey = 0;
				_data.itemw = ToolsApp.project.itemw;
				_data.itemh = ToolsApp.project.itemh;
				_data.numx = Math.ceil(_data.imgw/_data.itemw);
				_data.numy = Math.ceil(_data.imgh/_data.itemh);
				ToolsApp.file.saveFile(_dataFile.nativePath, XML2Obj.readObj(_data, "tileimg"));
			}
			txtTileInfo.text = _bd.width+"x"+_bd.height;
			checkLoadComplete();
		}
		
		private function handleDataLoaded(res:ResData):void
		{
			_data = XML2Obj.readXml(res.data) as TileImgData;
			checkLoadComplete();
		}
		
		private function checkLoadComplete():void
		{
			if(_bd && _data)
			{
				_isReady = true;
				txtTileName.color = 0x00ff00;
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function get bitmapData():BitmapData
		{
			return _bd;
		}
		public function get data():TileImgData
		{
			return _data;
		}
		public function get isReady():Boolean
		{
			return _isReady;
		}
		
		
		public function itemDataChange():void
		{
			if(_data == null)return;
			ToolsApp.file.saveFile(_dataFile.nativePath, XML2Obj.readObj(_data, "tileimg"));
			dispatchEvent(new Event(EVENT_DATA_CHANGE,true));
		}
		
		
	}
}