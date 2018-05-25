/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	import com.cyj.app.view.tile.layer.TileLayerItem;
	public class tileLayerListUI extends View {
		public var btnAddLayer:Button = null;
		public var btnRemoveLayer:Button = null;
		public var btnLockLayer:Button = null;
		public var btnVisibleLayer:Button = null;
		public var listTileLayer:List = null;
		protected static var uiXML:XML =
			<View width="250" height="230">
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="9" y="205" label="+" var="btnAddLayer"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="35" y="205" label="-" var="btnRemoveLayer"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="24" x="63" y="205" label="锁" var="btnLockLayer"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="24" x="92" y="205" label="见" var="btnVisibleLayer"/>
			  <Label text="图层" x="4" y="1" color="0xffff00" width="243" height="18" align="center"/>
			  <List x="-1" y="21" repeatY="6" vScrollBarSkin="png.guidecomp.vscroll" width="247" height="180" var="listTileLayer">
			    <tileLayerItem name="render" runtime="com.cyj.app.view.tile.layer.TileLayerItem"/>
			  </List>
			</View>;
		public function tileLayerListUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.tile.layer.TileLayerItem"] = TileLayerItem;
			super.createChildren();
			createView(uiXML);
		}
	}
}