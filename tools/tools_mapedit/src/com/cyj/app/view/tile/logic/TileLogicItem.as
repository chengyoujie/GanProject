package com.cyj.app.view.tile.logic
{
	import com.cyj.app.data.TileLogicData;
	import com.cyj.app.view.ui.mapreversal.tileLogicItemUI;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import morn.core.handlers.Handler;
	
	public class TileLogicItem extends tileLogicItemUI
	{
		private var _data:TileLogicData;
		
		public static const EVENT_VALUE_CHANGE:String = "EVENT_VALUE_CHANGE";
		
		public function TileLogicItem()
		{
			super();
			initEvent();
		}
		
		private function initEvent():void
		{
			btnRemove.clickHandler = new Handler(handleRemove);
//			btnTrue.addEventListener(MouseEvent.CLICK, hanldeClickChangeColor);
//			btnFalse.addEventListener(MouseEvent.CLICK, hanldeClickChangeColor);
			
			btnTrue.clickHandler = new Handler(handleChangeColor, [true]);
			btnFalse.clickHandler = new Handler(handleChangeColor, [false]);
		}
		
		override public function set dataSource(value:Object):void
		{
			if(!(value is TileLogicData))return;
			_data = value as TileLogicData;
			txtLogicName.text = _data.name;
			imgColorTrue.graphics.clear();
			imgColorTrue.graphics.beginFill(_data.getColorByType(true));
			imgColorTrue.graphics.drawRect(0, 0, imgColorTrue.width, imgColorTrue.height);
			imgColorTrue.graphics.endFill();
			
			
			imgColorFalse.graphics.clear();
			imgColorFalse.graphics.beginFill(_data.getColorByType(false));
			imgColorFalse.graphics.drawRect(0, 0, imgColorFalse.width, imgColorFalse.height);
			imgColorFalse.graphics.endFill();
			
			_data.curUseValue = _data.curUseValue;
			btnTrue.selected = _data.curUseValue;
			btnFalse.selected = !_data.curUseValue;
			
		}
		
		
		private function handleRemove():void
		{
			
		}
		
//		private function hanldeClickChangeColor(e:Event):void
//		{
//			var value:Boolean = false;
//			if(e.target == btnTrue)
//			{
//				btnTrue.selected = !btnTrue.selected;
//				btnFalse.selected = !btnTrue.selected;
//			}else{
//				btnFalse.selected = !btnFalse.selected;
//				btnTrue.selected = !btnFalse.selected;
//			}
//			handleChangeColor(btnTrue.selected);
//		}
		
		private function handleChangeColor(value:Boolean):void
		{
			btnTrue.selected = value;
			btnFalse.selected = !value;
			_data.curUseValue = value;
			dispatchEvent(new Event(EVENT_VALUE_CHANGE));
			
		}
		
	}
}