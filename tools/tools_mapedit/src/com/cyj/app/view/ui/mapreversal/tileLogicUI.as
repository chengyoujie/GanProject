/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	import com.cyj.app.view.tile.logic.TileLogicItem;
	public class tileLogicUI extends View {
		public var listLogic:List = null;
		public var btnAddLogic:Button = null;
		public var btnRemoveLogic:Button = null;
		public var conLogicInfo:Box = null;
		public var txtLogicName:Label = null;
		public var combLogicValue:ComboBox = null;
		public var imgCurColor:Image = null;
		protected static var uiXML:XML =
			<View width="250" height="200">
			  <Label text="逻辑类型" x="2" y="2" color="0xffff00" width="243" height="18" align="center"/>
			  <List x="1" y="27" repeatY="3" vScrollBarSkin="png.guidecomp.vscroll" width="247" height="91" var="listLogic">
			    <tileLogicItem name="render" runtime="com.cyj.app.view.tile.logic.TileLogicItem"/>
			  </List>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="6" y="134" label="+" var="btnAddLogic"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="32" y="134" label="-" var="btnRemoveLogic"/>
			  <Box x="3" y="177" var="conLogicInfo">
			    <Label text="当前逻辑:" y="4" color="0x99ff00" width="57" height="18" align="center"/>
			    <Label text="行走" x="60" y="4" color="0x99ff00" width="72" height="18" align="center" var="txtLogicName"/>
			    <Label text="值" x="143" y="2" color="0x99ff00" width="18" height="18" align="center"/>
			    <ComboBox skin="png.guidecomp.combobox" x="169" var="combLogicValue" width="48" height="23" visibleNum="15" scrollBarSkin="png.guidecomp.vscroll" itemColors="0x262626,0xffe0ce,0xff861a,0x885202,0x3d3d3d" labelColors="0xf4a339,0xfedcaf,0xe0e0e0" labels="真,假" selectedIndex="0"/>
			    <Image skin="png.comp.blank" x="222" y="1" width="20" height="19" var="imgCurColor"/>
			  </Box>
			</View>;
		public function tileLogicUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.tile.logic.TileLogicItem"] = TileLogicItem;
			super.createChildren();
			createView(uiXML);
		}
	}
}