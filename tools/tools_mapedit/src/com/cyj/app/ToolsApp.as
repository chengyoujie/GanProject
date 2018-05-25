package com.cyj.app
{
	import com.cyj.app.data.LocalConfig;
	import com.cyj.app.data.ProjectConfig;
	import com.cyj.app.data.TileImgData;
	import com.cyj.app.data.TileLayerData;
	import com.cyj.app.data.TileLogicData;
	import com.cyj.app.data.ToolsConfig;
	import com.cyj.app.view.ToolsView;
	import com.cyj.app.view.common.Alert;
	import com.cyj.app.view.ui.common.AlertUI;
	import com.cyj.utils.Log;
	import com.cyj.utils.XML2Obj;
	import com.cyj.utils.cmd.CMDManager;
	import com.cyj.utils.cmd.CMDStringParser;
	import com.cyj.utils.file.CSVFile;
	import com.cyj.utils.file.FileManager;
	import com.cyj.utils.ftp.SimpleFTP;
	import com.cyj.utils.load.LoaderManager;
	import com.cyj.utils.load.ResData;
	import com.cyj.utils.load.ResLoader;
	import com.cyj.utils.md5.MD5;
	
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeDragManager;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import morn.core.events.UIEvent;

	/**
	 * 应用入口
	 * @author cyj
	 * 
	 */	
	public class ToolsApp
	{
		public static var view:ToolsView;
		public static var loader:LoaderManager = new LoaderManager();
		public static var file:FileManager = new FileManager();
		public static var config:ToolsConfig;
		public static var event:EventDispatcher = new EventDispatcher();
		public static var project:ProjectConfig;
		public static var projectPath:String;
		public static var localCfg:LocalConfig = new LocalConfig();
		
		public static var VERSION:String = "1.0.1";
		
		public function ToolsApp()
		{
			
		}
		
		
//		private static function handleParserJson(res:ResData):void
//		{
//			var txt:String= res.data;
//			var obj:Object = JSON.parse(txt);
//			for(var fname:String in obj)
//			{
////				ToolsApp.loader.loadSingleRes("https://resh5.zzcq.lzgame.top/h10/0/"+fname, ResLoader.BYT, handleSaveLoaded, null, null, fname);
//				doSaveJson(fname, obj[fname]);
//			}
//		}
//		
//		private static function handleSaveLoaded(res:ResData):void
//		{
//			ToolsApp.file.saveByteFile("C:/Users/admin/Desktop/资源/resh5.zzcq.lzgame.top/CYJ_DOWN/"+res.param, res.data);
//		}
//		
//		private static function isArray(obj:Object):Boolean
//		{
//			var isFirst:Boolean = false;
//			for(var id:String in obj)
//			{
//				if(int(id) == 0)
//				{
//					if(isFirst)
//						return false;
//					isFirst = true;
//				}
//			}
//			return true;
//		}
//		
//		private static function doSaveJson(fname:String, data:Object):void
//		{
////			var itemIndex:Object = {};
////			var item:Object;
////			var index:int = 0;
//			var arr:Array = [];
////			var arrIndex:int = 0;
//			var itemIndex:Object = spaderArr(arr, data);
//			
//			var titlearr:Array = [];
//			for(var pr:String in itemIndex)
//			{
//				if(pr.indexOf("__CUR__")!=-1)continue;
//				titlearr[itemIndex[pr]] = pr;	
//			}
//			arr.unshift(titlearr);
////			file.saveFile("C:/Users/admin/Desktop/资源/cdn.7yao.top/m2/56/resource/cfg/parser/"+fname.replace("Config", "")+".csv", CSVFile.write(arr), false, "gb2312");
////			file.saveFile("C:/Users/admin/Desktop/资源/tp2-xkx-hf.hgame.com/temp/parser/"+fname.replace("map", "")+".csv", CSVFile.write(arr), false, "gb2312");
//			file.saveFile("C:/Users/admin/Desktop/资源/resh5.zzcq.lzgame.top/CYJ_DOWN/resource/cfg/parser/"+fname.replace("map", "")+".csv", CSVFile.write(arr), false, "gb2312");
//			
//		}
//		
//		private static function spaderArr(arr,data, itemIndexObj:Object=null):Object
//		{
//			var itemIndex:Object = itemIndexObj==null?{__CUR__index:0, __CUR__arrIndex:0}:itemIndexObj;
//			
//			var find:Boolean = isArray(data);
//			if(find==false)
//			{
//				arr.push(parserItem(data, itemIndex));
//			}else{
//				for(var id:String in data)
//				{
//					spaderArr(arr, data[id], itemIndex);
//				}
//			}
//			
//			return itemIndex;
//		}
//		
//		private static function parserItem(item:Object, itemIndex:Object):Array
//		{
//			var arr:Array = [];
//			for(var prop:String in item)
//			{
//				if(itemIndex[prop] == undefined)
//				{
//					itemIndex[prop] = itemIndex.__CUR__index;
//					itemIndex.__CUR__index ++;
//				}
//				arr[itemIndex[prop]] = item[prop];
//			}
//			return arr;
//		}
		
		
		public static function start():void
		{
			loader.loadManyRes(["res/comp.swf", "res/guidecomp.swf"], handleSwfLoaded, null, handleLoadError);
		}
		
		private static function handleSwfLoaded():void
		{
			view = new ToolsView();
			App.stage.addChild(view);
			startDoDrag();
			exitAppEvent();
			loader.loadSingleRes("res/config.xml", ResLoader.TXT, handleConfigLoaded, null, handleLoadError);
		}
		
		
		private static function handleConfigLoaded(res:ResData):void
		{
			XML2Obj.registerClass("toolsconfig", ToolsConfig);
			XML2Obj.registerClass("project", ProjectConfig);
			XML2Obj.registerClass("local", LocalConfig);
			XML2Obj.registerClass("tileimg", TileImgData);
			XML2Obj.registerClass("tileLayer", TileLayerData);
			XML2Obj.registerClass("tileLogic", TileLogicData);
			config = XML2Obj.readXml(res.data) as ToolsConfig;
			VERSION = config.version;
			loader.loadSingleRes("res/local.xml", ResLoader.TXT, handleLocalConfigLoaded, null, handleLoadError);
			App.stage.nativeWindow.title = config.title+"@"+VERSION;
			
			Log.initLabel(view.txtLog);
			view.initView();
			Log.log("系统启动成功");
			loader.loadSingleRes(config.versionconfig, ResLoader.TXT, handleVersionConfigLoaded, null, null);
			
		}
		
		public static function changeProject(projectpath:String):void
		{
			loader.loadSingleRes(projectpath+"/project.tile", ResLoader.TXT, handleProjectConfigLoaded, null, handleProjectError, projectpath);
		}
		private static function handleProjectError(res:ResData, msg:*):void
		{
			Alert.show("请检查项目路径是否正确, 没有找到 project.tile 文件");
		}
		
		private static function handleProjectConfigLoaded(res:ResData):void
		{
			projectPath = res.param;
			project = XML2Obj.readXml(res.data) as ProjectConfig;
			App.stage.nativeWindow.title = config.title+"@"+VERSION+"_"+project.name;
			view.changeProject();
		}
		
		private static function handleLocalConfigLoaded(res:ResData):void
		{
			localCfg = XML2Obj.readXml(res.data) as LocalConfig;
			changeProject(localCfg.projectpath);
		}
		
		private static function handleVersionConfigLoaded(res:ResData):void
		{
			var versiontxt:String = res.data;
			var versionReg:RegExp = /[\n\r]*\[(.*?)\][\n\r]*/gi;
			var obj:Object= {};
			var arr:Array= versionReg.exec(versiontxt);
			var lastIndex:int = 0;
			var lastProp:String;
			while(arr)
			{
				if(lastProp)
				{
					obj[lastProp] = versiontxt.substring(lastIndex, versionReg.lastIndex-arr[0].length);
					lastIndex = versionReg.lastIndex;
				}
				lastProp = arr[1];
				lastIndex = versionReg.lastIndex;
				arr = versionReg.exec(versiontxt);
			}
			if(lastProp)
			{
				obj[lastProp] = versiontxt.substring(lastIndex, versiontxt.length);
			}
			if(obj.version != VERSION)
			{
				Alert.show("<font color='#FF0000'>当前版本<font color='#00FF00'>"+VERSION+"</font>最新版本:<font color='#00FF00'>"+obj.version+"</font></font>\n<p align='left'><font color='#FFFF00'>更新内容</font>\n"+obj.desc.replace(/\r\n/gi, "\n")+"</p>", "更新提醒");
			}
			
			//test
//			loader.loadSingleRes("res/config.json", ResLoader.TXT, handleParserJson);
//			loader.loadSingleRes("res/xkx.json", ResLoader.TXT, handleParserJson);
//			loader.loadSingleRes("res/329.json", ResLoader.TXT, handleParserJson);
		}
		
		
		
		public static function getLenStr(str:String, len:int, addstr:String="0", endstr:String=""):String
		{
			if(!addstr)
				addstr = " ";
			for(var i:int=str.length; i<len; i++)
			{
				str = addstr+str+endstr;
			}
			return str;
		}
		
		
		
		public static function cmdOper(oper:String, endTag:String=null, isClear:Boolean=true):void
		{
			if(oper)
			{
				CMDManager.runStringCmd(oper);;
			}
			if(endTag)
				CMDManager.runStringCmd("|TAG|"+endTag+"|TAG|");
			if(isClear)
				cmdClear();
		}
		
		public static function cmdClear():void
		{
			CMDManager.runStringCmd("cls");
		}
		
		
		
		 
		private static function handleGetFtpList(res:*, msg:*):void
		{
			Log.log(res);
		}
		
		
		public static function handleLoadError(res:ResData, msg:*):void
		{
			Alert.show("资源加载错误"+res.resPath+"\nerror : "+msg, "加载错误");
		}
		
		private static function startDoDrag():void
		{
			App.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, handleDragEnter);
			App.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, handleDropEvent);
			App.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, handleDropExit);
		}
		
		private static function handleDragEnter(e:NativeDragEvent):void
		{
			var clipBoard:Clipboard = e.clipboard;
			if(clipBoard.hasFormat(ClipboardFormats.FILE_LIST_FORMAT))   
			{
				NativeDragManager.acceptDragDrop(App.stage);
			}
		}
		
		private static  function handleDropEvent(e:NativeDragEvent):void
		{
			var clip:Clipboard = e.clipboard;
			if(clip.hasFormat(ClipboardFormats.FILE_LIST_FORMAT))
			{
				var arr:Array = clip.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
				var file:File;
				for(var i:int=0; i<arr.length; i++)
				{
					file = arr[i];
					if(file.isDirectory==false)
					{
						var type:String = file.name.substr(file.name.lastIndexOf("."));
						if(type == ".dat")
						{
							
						}
					}
				}
			}
		}
		
		private static  function handleDropExit(e:NativeDragEvent):void
		{
			//trace("Exit Drop");
		}
		
		private static function exitAppEvent():void
		{
			App.stage.nativeWindow.addEventListener(Event.CLOSING, handleCloseApp);
		}
		
		private static function handleCloseApp(e:Event):void
		{
			Log.log("退出系统");
			Log.refushLog();
			file.saveFile(File.applicationDirectory.nativePath+"/res/local.xml", XML2Obj.readObj(localCfg, "local"));
			//取消默认关闭
//			e.preventDefault();
//			NativeApplication.nativeApplication.activeWindow.visible = true;
			//关闭
			App.stage.nativeWindow.close();
		}
		
		
	}
}