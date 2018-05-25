package com.cyj.app.view
{
	import com.cyj.app.SimpleEvent;
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.ProjectConfig;
	import com.cyj.app.data.ToolsConfig;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.ui.mapreversal.AppMainUI;
	import com.cyj.utils.Log;
	import com.cyj.utils.cmd.CMDManager;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	import com.cyj.utils.md5.MD5;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.flash_proxy;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import morn.core.components.TextInput;
	import morn.core.handlers.Handler;
	import morn.core.managers.TipManager;
	
	public class ToolsView extends AppMainUI
	{
		public var popContain:Sprite = new Sprite();
		
		public function ToolsView()
		{
			super();
			popContain = new Sprite();
			this.addChild(popContain);
			
			initEvent();
		}
		/** 初始化界面  **/		
		public function initView():void
		{
			appName.text = ToolsApp.config.appName;
			
			
		}
		/** 初始化事件 **/
		private function initEvent():void
		{
			
		}
		
		/**切换项目**/
		public function changeProject():void
		{
			tileMain.initPorject();
		}
		
	}
}

