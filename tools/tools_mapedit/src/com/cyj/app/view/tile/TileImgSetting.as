package com.cyj.app.view.tile
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.TileImgData;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.compont.AbstractPanel;
	import com.cyj.app.view.ui.mapreversal.tileImgSettingUI;
	import com.cyj.utils.Log;
	
	import flash.events.Event;
	import flash.events.FocusEvent;
	
	import morn.core.handlers.Handler;
	import com.cyj.app.view.tile.imglist.TileListItem;
	
	public class TileImgSetting extends AbstractPanel
	{
		public var ui:tileImgSettingUI = new tileImgSettingUI();
		private var _item:TileListItem;
		
		public function TileImgSetting()
		{
			super();
		}
		
		
		override protected function initView():void
		{
			super.initView();
			_dragImg = ui.bg;
			_closeBtn = ui.btnClose;
			addChild(ui);
		}
		override protected function initEvent():void
		{
			super.initEvent();
			ui.btnOK.clickHandler = new Handler(handleSaveData);
			ui.btnCancle.clickHandler = new Handler(close);
			
			ui.inputCellH.addEventListener(FocusEvent.FOCUS_OUT, handleSizeChange);
			ui.inputCellW.addEventListener(FocusEvent.FOCUS_OUT, handleSizeChange);
			ui.inputSpaceX.addEventListener(FocusEvent.FOCUS_OUT, handleSizeChange);
			ui.inputSpaceY.addEventListener(FocusEvent.FOCUS_OUT, handleSizeChange);
			ui.inputStartX.addEventListener(FocusEvent.FOCUS_OUT, handleSizeChange);
			ui.inputStartY.addEventListener(FocusEvent.FOCUS_OUT, handleSizeChange);
			
			ui.inputNumX.addEventListener(FocusEvent.FOCUS_OUT, handleNumChange);
			ui.inputNumY.addEventListener(FocusEvent.FOCUS_OUT, handleNumChange);
			
		}
		
		
		private function handleSizeChange(e:Event):void
		{
			if(_item==null)return;
			var itemw:int = int(ui.inputCellW.text);
			var itemh:int = int(ui.inputCellH.text);
			var spacex:int = int(ui.inputSpaceX.text);
			var spacey:int = int(ui.inputSpaceY.text);
			var startx:int = int(ui.inputStartX.text);
			var starty:int = int(ui.inputStartY.text);
			var alertStr:String;
			if(itemw>_item.bitmapData.width)
			{
				itemw = _item.bitmapData.width;
				ui.inputCellW.text = itemw+"";
				if(!alertStr)
					alertStr = "格子宽超过图片宽，图片宽"+_item.bitmapData.width;
			}else if(itemw <=0)
			{
				itemw = ToolsApp.project.itemw>_item.bitmapData.width?_item.bitmapData.width:ToolsApp.project.itemw;
				ui.inputCellW.text = itemw+"";
				if(!alertStr)
					alertStr ="格子宽低于0，系统自动设置 格子宽为"+itemw;
			}
			if(itemh >_item.bitmapData.height)
			{
				itemh = _item.bitmapData.height;
				ui.inputCellH.text = itemh+"";
				if(!alertStr)
					alertStr = "格子高超过图片宽，图片高"+_item.bitmapData.height;
			}else if(itemh <= 0)
			{
				itemh = ToolsApp.project.itemh>_item.bitmapData.height?_item.bitmapData.height:ToolsApp.project.itemh;
				ui.inputCellH.text = itemh+"";
				if(!alertStr)
					alertStr = "格子高低于0，系统自动设置 格子高为"+itemh;
			}
			if(spacex >= _item.bitmapData.width)
			{
				spacex = 0;
				ui.inputSpaceX.text = spacex+"";
				if(!alertStr)
					alertStr = "设置横向(X)的间隔大于图片宽度"+_item.bitmapData.width;
			}
			if(spacey >= _item.bitmapData.height)
			{
				spacey = 0;
				ui.inputSpaceY.text = spacey+"";
				if(!alertStr)
					alertStr = "设置竖向(Y)的间隔大于图片高度"+_item.bitmapData.height;
			}
			if(startx >= _item.bitmapData.width)
			{
				startx = 0;
				ui.inputSpaceX.text = startx+"";
				if(!alertStr)
					alertStr = "设置横向(X)的开始位置大于图片宽度"+_item.bitmapData.width;
			}
			if(starty >= _item.bitmapData.height)
			{
				starty = 0;
				ui.inputSpaceY.text = starty+"";
				if(!alertStr)
					alertStr = "设置纵向(X)的开始位置大于图片高度"+_item.bitmapData.height;
			}
			if(startx + spacex >= _item.bitmapData.width)
			{
				if(e.target == ui.inputSpaceX)
				{
					spacex = 0;
					ui.inputSpaceX.text = spacex+"";
				}else{
					startx = 0;
					ui.inputStartX.text = startx+"";
				}
				if(!alertStr)
					alertStr = "设置横向(X)的（开始位置+间隔大小）大于图片高度"+(startx+spacex)+">"+_item.bitmapData.width;
			}
			if(starty + spacey >= _item.bitmapData.height)
			{
				if(e.target == ui.inputSpaceY)
				{
					spacey = 0;
					ui.inputSpaceY.text = spacey+"";
				}else{
					starty = 0;
					ui.inputStartY.text = starty+"";
				}
				if(!alertStr)
					alertStr = "设置纵向(X)的（开始位置+间隔大小）大于图片高度"+(starty + spacey)+">"+_item.bitmapData.height;
			}
			if(alertStr)
			{
				Log.log(alertStr);
				Alert.show(alertStr);
			}

			
			var numx:int = Math.max((_item.bitmapData.width-startx)/(itemw+spacex), 1);
			var numy:int = Math.max((_item.bitmapData.height-starty)/(itemh+spacey), 1);
			ui.inputNumX.text = numx+"";
			ui.inputNumY.text = numy+"";
			
		}
		private function handleNumChange(e:Event):void
		{
			if(_item==null)return;
			var numx:int = int(ui.inputNumX.text);
			var numy:int = int(ui.inputNumY.text);
			
			var spacex:int = int(ui.inputSpaceX.text);
			var spacey:int = int(ui.inputSpaceY.text);
			var startx:int = int(ui.inputStartX.text);
			var starty:int = int(ui.inputStartY.text);
			var alertStr:String;
			if(numx>_item.bitmapData.width)
			{
				numx = 1;
				ui.inputNumX.text = numx+"";
				if(!alertStr)
					alertStr = "当前设置的切片数大于图片宽度"+_item.bitmapData.width;
			}
			if(numy>_item.bitmapData.height)
			{
				numy = 1;
				ui.inputNumY.text = numy+"";
				if(!alertStr)
					alertStr = "当前设置的切片数大于图片高度"+_item.bitmapData.height;
			}
			if(alertStr)
			{
				Log.log(alertStr);
				Alert.show(alertStr);
			}
			var itemw:int = (_item.bitmapData.width-startx)/numx - spacex;
			var itemh:int = (_item.bitmapData.height-starty)/numy - spacey;
			ui.inputCellW.text = itemw+"";
			ui.inputCellH.text = itemh+"";
		}
		
		
		public function show(item:TileListItem):void
		{
			if(item.isReady==false)
				return;
			_item = item;
			ToolsApp.view.popContain.addChild(this);
			this.x = (App.stage.stageWidth-this.width)/2;
			this.y = (App.stage.stageHeight-this.height)/2;
			ui.txtImgInfo.text = item.bitmapData.width+"X"+item.bitmapData.height;
			ui.inputCellW.text = item.data.itemw+"";
			ui.inputCellH.text = item.data.itemh+"";
			ui.inputSpaceX.text = item.data.spacex+"";
			ui.inputSpaceY.text = item.data.spacey+"";
			ui.inputStartX.text = item.data.startx+"";
			ui.inputStartY.text = item.data.starty+"";
			ui.inputNumX.text = item.data.numx+"";
			ui.inputNumY.text = item.data.numy+"";
			ui.imgPre.width = item.bitmapData.width;
			ui.imgPre.height = item.bitmapData.height;
			ui.imgPre.bitmapData = item.bitmapData;
		}
		
		private function  handleSaveData():void
		{
			_item.data.itemw = int(ui.inputCellW.text);
			_item.data.itemh = int(ui.inputCellH.text);
			_item.data.spacex = int(ui.inputSpaceX.text);
			_item.data.spacey = int(ui.inputSpaceY.text);
			_item.data.startx = int(ui.inputStartX.text);
			_item.data.starty = int(ui.inputStartY.text);
			_item.data.numx = int(ui.inputNumX.text);
			_item.data.numy = int(ui.inputNumY.text);
			_item.itemDataChange();
			close();
		}
		
		
	}
}