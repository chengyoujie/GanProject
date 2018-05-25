package com.cyj.app
{
	import flash.events.Event;
	
	public class SimpleEvent extends Event
	{
		public var data:Object;
		public function SimpleEvent(type:String, $data:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = $data;
			super(type, bubbles, cancelable);
		}
	}
}