/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	public class tileLayerItemUI extends View {
		public var txtLayerName:Label = null;
		public var btnTileDele:Button = null;
		public var btnLayerVisible:Button = null;
		public var btnLayerLock:Button = null;
		protected static var uiXML:XML =
			<View width="225" height="30">
			  <Image skin="png.guidecomp.内框_1" width="225" height="30" sizeGrid="5,5,5,5,1" x="0" y="0"/>
			  <Label text="图片名称" x="9" y="6" color="0x99ff00" width="134" height="18" align="left" var="txtLayerName"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="194" y="4" label="删" var="btnTileDele"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="169" y="4" label="见" var="btnLayerVisible"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="142" y="4" label="锁" var="btnLayerLock"/>
			  <Clip skin="png.guidecomp.clip_格子选中" x="0" y="0" width="225" height="30" sizeGrid="8,8,8,8,1" name="selectBox" mouseEnabled="false"/>
			</View>;
		public function tileLayerItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}