package com.cyj.app.view.tile.logic
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ProjectConfig;
	import com.cyj.app.data.TileLogicData;
	import com.cyj.app.view.ui.mapreversal.tileLogicUI;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class TileLogic extends tileLogicUI
	{
		private var _data:Array;
		
		public function TileLogic()
		{
			super();
			initEvent();
		}
		
		private function initEvent():void
		{
			listLogic.addEventListener(MouseEvent.CLICK, handleChangeSelect);
			listLogic.addEventListener(TileLogicItem.EVENT_VALUE_CHANGE, handleItemValueChange);
		}
		
		
		public function initPorject():void
		{
			var project:ProjectConfig= ToolsApp.project;
			if(project==null)return;
			_data = project.tileLogic;
			if(_data == null)_data = [];
			listLogic.dataSource = _data;
			listLogic.selectedIndex = 0;
			initInfo(listLogic.selectedIndex);
		}
		
		
		private function handleChangeSelect(e:MouseEvent):void
		{
			var index:int = listLogic.selectedIndex;
			var selectData:TileLogicData = listLogic.selectedItem as TileLogicData;
			if(selectData)
			{
				ToolsApp.view.tileMain.curUseTile.clipData = selectData.curUseColor;
			}else{
				ToolsApp.view.tileMain.curUseTile.clipData = null;
			}
			initInfo(listLogic.selectedIndex);
		}
		
		
		private function initInfo(index:int):void
		{
			var selectData:TileLogicData = listLogic.selectedItem as TileLogicData;
			if(selectData)
			{
				conLogicInfo.visible = true;
				txtLogicName.text = selectData.name;
				combLogicValue.selectedIndex = selectData.curUseValue?0:1;
				imgCurColor.graphics.clear();
				imgCurColor.graphics.beginFill(selectData.curUseColor);
				imgCurColor.graphics.drawRect(0, 0, imgCurColor.width, imgCurColor.height);
				imgCurColor.graphics.endFill();
			}else{
				conLogicInfo.visible = false;
			}
		}
		
		private function handleItemValueChange(e:Event):void
		{
			initInfo(listLogic.selectedIndex);
		}
		
		
	}
}