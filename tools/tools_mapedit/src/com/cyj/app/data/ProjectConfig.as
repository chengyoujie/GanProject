package com.cyj.app.data
{
	import com.cyj.utils.XML2Obj;

	public class ProjectConfig
	{
		
		public var name:String;
		public var itemw:int;
		public var itemh:int;
		public var numx:int;
		public var numy:int;
		public var logicw:int;
		public var logich:int;
		
		public var tileLayer:Array = [];
		
		public var tileLogic:Array = [];
		
		public function getIndex(x:int, y:int):int
		{
			return x+y*numx;
		}
		
		public function ProjectConfig()
		{
			
		}
	}
}