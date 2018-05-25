package com.cyj.app.data
{
	import com.cyj.app.view.tile.layer.TileLayer;

	public class TileLayerData
	{
		public var name:String;
		public static const TYPE_BG:int = -1;
		public static const TYPE_DRAW:int = 0;
		public static const TYPE_LOGIC:int = 1;
		/**0  普通可绘制图层， 1 逻辑数据层**/
		public var type:int;
		private var _data:Array;
		private var _lock:Boolean = false;
		private var _visible:Boolean = true;
		private var _layer:TileLayer;
		
		public function TileLayerData()
		{
		}
		
		public function set datastr(value:String):void
		{
			_data = value.split(",");
		}
		public function get datastr():String
		{
			return _data==null?"":_data.join(",");
		}
		
		public function set lock(value:Boolean):void
		{
			_lock = value;
			if(_layer)
				_layer.refushLock();
		}
		public function get lock():Boolean
		{
			return _lock;
		}
		public function set visible(value:Boolean):void
		{
			_visible = value;
			if(_layer)
				_layer.refushVisible();
		}
		public function get visible():Boolean
		{
			return _visible;
		}
		
		public function bindLayer(layer:TileLayer):void
		{
			_layer = layer;
		}
		public function getLayer():TileLayer
		{
			return _layer;
		}
	}
}