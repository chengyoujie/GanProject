package
{
	import com.cyj.app.ToolsApp;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	[SWF(width="1200", height="800", backgroundColor="#444444", frameRate="30")]
	public class tools_mapedit extends Sprite
	{
		public function tools_mapedit()
		{
			if(this.stage)
				initStage();
			else
				this.addEventListener(Event.ADDED_TO_STAGE, initStage);
		}
		
		private function initStage(e:Event=null):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			App.init(this);
			ToolsApp.start();
		}
	}
}