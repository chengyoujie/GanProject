package com.cyj.app.data
{
	public class TileLogicData
	{
		
//		public static const  TYPE_BOOL:int = 0;
//		public static const TYPE_INT:int = 1;
//		public static const TYPE_NUMBER:int = 2;
//		public static const TYPE_STRING:int = 3;
		
		
		public var name:String;
		private var _color:String;
		private var _colorArr:Array;
		public var valuetype:int;
		private var _curUseColor:int;
		private var _curUseValue:Boolean;
		
		public function TileLogicData()
		{
		}
		/***true|flase   0x格式的颜色**/
		public function set color(value:String):void
		{
			_color = value;
			var arr:Array = _color!=null?_color.split("|"):[];
			if(arr.length==0)
			{
				arr[0] = 0xff0000;
				arr[1] = 0x00ff00;
			}else if(arr.length ==1)
			{
				arr[1] = ~arr[0];
			}
			_colorArr = arr;
		}
		
		public function get color():String
		{
			return _color;
		}
								  
		public function set curUseValue(value:Boolean):void
		{
			_curUseValue = value;
			_curUseColor = getColorByType(value);
		}
		
		public function get curUseValue():Boolean
		{
			return _curUseValue;
		}
		
		public function get curUseColor():int
		{
			return _curUseColor;
		}
		
		public function getColorByType(value:*):int
		{
			if(value)
				return _colorArr[0];
			return _colorArr[1];
		}
	}
}