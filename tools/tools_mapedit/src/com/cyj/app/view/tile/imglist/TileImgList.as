package com.cyj.app.view.tile.imglist
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.view.ui.mapreversal.tileImgListUI;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import morn.core.handlers.Handler;
	
	public class TileImgList extends tileImgListUI
	{
		public function TileImgList()
		{
			super();
			initEvent();
		}
		
		
		private function initEvent():void
		{
			listTile.selectHandler = new Handler(handleListSelectChange);
			listTile.addEventListener(TileListItem.EVENT_REMOVE, handleRemoveListItem);
			listTile.addEventListener(TileListItem.EVENT_SETTING, handleSettingListItem);
			listTile.addEventListener(TileListItem.EVENT_DATA_CHANGE, handleDataChangeListItem);
		}
		private function handleDataChangeListItem(e:Event):void
		{
			var item:TileListItem = e.target as TileListItem;
			if(item  && item == listTile.selection)
			{
				ToolsApp.view.tileMain.viewTileClip.setTileClip(item);
			}
		}
		private function handleSettingListItem(e:Event):void
		{
			var item:TileListItem = e.target as TileListItem;
			if(item)
				ToolsApp.view.tileMain.tileSetting.show(item);
		}
		private function handleRemoveListItem(e:Event):void
		{
			var item:TileListItem = e.target as TileListItem;
			if(item)
			{
				refushList();
			}
		}
		
		public function initPorject():void
		{
			refushList();
		}
		
		private function refushList():void
		{
			var file:File = new File(ToolsApp.projectPath+"/tile/Images");
			var lastSelect:int = listTile.selectedIndex;
			if(file.exists && file.isDirectory)
			{
				var arr:Array = file.getDirectoryListing();
				var f:File;
				var datasource:Array = [];
				for(var i:int=0; i<arr.length; i++)
				{
					f = arr[i];
					if(f.isDirectory==false && ToolsApp.file.isImage(f.name))
					{
						datasource.push(f);
					}
				}
				listTile.dataSource = datasource;
			}else{
				listTile.dataSource = [];
			}
			if(listTile.dataSource.length>0)
			{
				if(lastSelect>0 && lastSelect<listTile.dataSource.length)
					listTile.selectedIndex = lastSelect;
				else
					listTile.selectedIndex = 0;
			}
			if(listTile.selection is TileListItem)
				ToolsApp.view.tileMain.viewTileClip.setTileClip(listTile.selection as TileListItem);
		}
		
		
		private function handleListSelectChange(index:int):void
		{
			ToolsApp.view.tileMain.viewTileClip.setTileClip(listTile.selection as TileListItem);
		}
	}
}