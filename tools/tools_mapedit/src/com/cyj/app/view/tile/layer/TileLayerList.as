package com.cyj.app.view.tile.layer
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ProjectConfig;
	import com.cyj.app.data.TileLayerData;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.ui.mapreversal.tileLayerListUI;
	import com.cyj.utils.Log;
	
	import flash.display.Sprite;
	
	import morn.core.handlers.Handler;
	
	public class TileLayerList extends tileLayerListUI
	{
		private var _layerList:Array = [];
		
		private var _layerName:String = "图层";
		private var _layerIndex:int = 0;
		
		public function TileLayerList()
		{
			super();
			initView();
			initEvent();
		}
		
		private function initView():void
		{
			listTileLayer.dataSource = _layerList;
		}
		
		private function initEvent():void
		{
			btnAddLayer.clickHandler = new Handler(handleAddLayer);
			btnLockLayer.clickHandler = new Handler(handleLockAllLayer);
			btnRemoveLayer.clickHandler = new Handler(handleRemoveLayer);
			btnVisibleLayer.clickHandler = new Handler(handleVisibleAllLayer);
			listTileLayer.selectHandler = new Handler(handleSelectChange);
		}
		
		public function initProject():void
		{
			var project:ProjectConfig= ToolsApp.project;
			if(project==null)return;
			var layer:TileLayerData;
			var index:int;
			_layerList = [];
			_layerIndex = 0;
			for(var i:int=0; i<project.tileLayer.length; i++)
			{
				layer = project.tileLayer[i];
				if(layer == null)continue;
				index = int(layer.name.replace(_layerName, ""));
				if(index>_layerIndex)
				{
					_layerIndex = index;
				}
				addLayer(layer);
//				_layerList.push(layer);
			}
			listTileLayer.selectedIndex= 0;
			handleSelectChange(listTileLayer.selectedIndex);
//			listTileLayer.dataSource = _layerList;
		}
		
		
		private function handleAddLayer():void
		{
			_layerIndex ++;
			var layer:TileLayerData = new TileLayerData();
			layer.name = _layerName+_layerIndex;
			addLayer(layer);
		}
		
		private function handleLockAllLayer():void
		{
			var havelock:Boolean = false;
			var layer:TileLayerData;
			var i:int;
			for(i=0; i<_layerList.length; i++)
			{
				layer = _layerList[i];
				if(layer.lock)
				{
					havelock = true;
					break;
				}
			}
			var item:TileLayerItem;
			for(i=0; i<_layerList.length; i++)
			{
				layer = _layerList[i];
				layer.lock = !havelock;
				item = listTileLayer.getCell(i) as TileLayerItem;
				if(item)
					item.refushState();
			}
			btnLockLayer.label = havelock?"开":"锁";
		}
		private function handleRemoveLayer():void
		{
			var layeritem:TileLayerItem = listTileLayer.selection as TileLayerItem;
			if(layeritem)
			{
				removeLayer(layeritem.data);
			}
		}
		private function handleVisibleAllLayer():void
		{
			var haveVisible:Boolean = false;
			var layer:TileLayerData;
			var i:int;
			for(i=0; i<_layerList.length; i++)
			{
				layer = _layerList[i];
				if(layer.visible)
				{
					haveVisible = true;
					break;
				}
			}
			var item:TileLayerItem;
			for(i=0; i<_layerList.length; i++)
			{
				layer = _layerList[i];
				layer.visible = !haveVisible;
				item = listTileLayer.getCell(i) as TileLayerItem;
				if(item)
					item.refushState();
			}
			btnVisibleLayer.label = haveVisible?"隐":"显";
		}
		/**添加图层**/
		public function addLayer(layer:TileLayerData):void
		{
			if(layer== null)return;
			var selectIndex:int = listTileLayer.selectedIndex;
			if(selectIndex>=0)
			{
				_layerList.splice(selectIndex, 0, layer);
			}else{
				_layerList.push(layer);
			}
			var lay:TileLayer = new TileLayer(layer);
			listTileLayer.dataSource = _layerList;
			
			if(selectIndex<0)
				selectIndex = 0;
			listTileLayer.selectedIndex = selectIndex;
			ToolsApp.view.tileMain.viewTileMap.addLayer(layer, selectIndex);
			handleSelectChange(listTileLayer.selectedIndex);
		}
		/**删除图层**/
		public function removeLayer(layer:TileLayerData):void
		{
			if(layer== null)return;
			if(_layerList.length<=1)return;
			var index:int = _layerList.indexOf(layer);
			if(index == -1)
			{
				Alert.show("删除图层失败"+layer.name+"不再列表中");
				return;
			}
			var selectIndex:int = listTileLayer.selectedIndex;
			_layerList.splice(index, 1);
			listTileLayer.dataSource = _layerList;
			if(selectIndex>index)
				selectIndex= selectIndex-1;
			if(selectIndex<0)
				selectIndex = 0;
			else if(selectIndex>=_layerList.length)
				selectIndex = _layerList.length-1;
			listTileLayer.selectedIndex = selectIndex;
			handleSelectChange(listTileLayer.selectedIndex);
			ToolsApp.view.tileMain.viewTileMap.removeLayer(layer);
		}
		 
		public function get layerList():Array
		{
			return _layerList;
		}
		
		private function handleSelectChange(index:int):void
		{
			if(index>=0 && index<_layerList.length)
			{
				var layer:TileLayerData = _layerList[index];
				if(layer && layer.getLayer())
				{
					ToolsApp.view.tileMain.curOperLayer = layer.getLayer();
					var laydata:TileLayerData;
					for(var i:int=0; i<_layerList.length; i++)
					{
						laydata = _layerList[i];
						laydata.getLayer().refushLock();
						laydata.getLayer().showBorder = (layer==laydata);
					}
					Log.log("当前选择图层:"+layer.name);
				}
			}
		}
		
	}
}