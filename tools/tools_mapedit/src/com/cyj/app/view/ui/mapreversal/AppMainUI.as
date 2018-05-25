/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	import com.cyj.app.view.tile.TileMain;
	public class AppMainUI extends View {
		public var appName:Label = null;
		public var txtLog:Label = null;
		public var tileMain:TileMain = null;
		protected static var uiXML:XML =
			<View width="1200" height="800">
			  <Image skin="png.comp.blank" x="0" y="0" width="1200" height="800"/>
			  <Label text="应用界面" x="0" y="3" color="0xff9900" stroke="0" width="1200" height="32" align="center" size="18" var="appName"/>
			  <Label text="日志" x="7" y="759" width="1018" height="37" color="0x33ff00" var="txtLog" wordWrap="true"/>
			  <Label text="made by cyj 2018" x="1077" y="773" color="0x666666"/>
			  <tileMain x="0" y="54" runtime="com.cyj.app.view.tile.TileMain" var="tileMain"/>
			</View>;
		public function AppMainUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.tile.TileMain"] = TileMain;
			super.createChildren();
			createView(uiXML);
		}
	}
}