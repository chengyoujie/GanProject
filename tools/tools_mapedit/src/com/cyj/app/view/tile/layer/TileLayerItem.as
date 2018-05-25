package com.cyj.app.view.tile.layer
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.TileLayerData;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.ui.mapreversal.tileLayerItemUI;
	
	import morn.core.handlers.Handler;
	
	public class TileLayerItem extends tileLayerItemUI
	{
		private var _data:TileLayerData;
		
		public function TileLayerItem()
		{
			super();
			initEvent();
		}
		
		private function initEvent():void
		{
			btnLayerLock.clickHandler = new Handler(handleLayerLock);
			btnLayerVisible.clickHandler = new Handler(handleLayerVisible);
			btnTileDele.clickHandler = new Handler(handleLayerDel);
		}
		
		override public function set dataSource(value:Object):void
		{
			if(!(value is TileLayerData))return;
			_data = value as TileLayerData;
			txtLayerName.text = _data.name;
			refushState();
		}
		
		public function refushState():void
		{
			if(_data == null)return;
			btnLayerLock.label = _data.lock?"锁":"开";
			btnLayerVisible.label = _data.visible?"显":"隐";
			
		}
		
		public function get data():TileLayerData
		{
			return _data;
		}
		
		private function handleLayerLock():void
		{
			if(_data)
			{
				_data.lock = !_data.lock;
				btnLayerLock.label = _data.lock?"锁":"开";
			}
		}
		private function handleLayerVisible():void
		{
			if(_data)
			{
				_data.visible = !_data.visible;
				btnLayerVisible.label = _data.visible?"显":"隐";
			}
		}
		private function handleLayerDel():void
		{
			if(_data)
				ToolsApp.view.tileMain.viewTileLayerList.removeLayer(_data);
			else
				Alert.show("删除失败，图层无数据");
			
		}
		
	}
}