/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	public class tileListItemUI extends View {
		public var txtTileName:Label = null;
		public var txtTileInfo:Label = null;
		public var btnTileDele:Button = null;
		public var btnTileSetting:Button = null;
		protected static var uiXML:XML =
			<View width="252" height="30">
			  <Image skin="png.guidecomp.内框_1" width="252" height="30" sizeGrid="5,5,5,5,1" x="0" y="0"/>
			  <Label text="图片名称" x="9" y="6" color="0x99ff00" width="110" height="18" align="left" var="txtTileName"/>
			  <Label text="32x32" x="126" y="6" color="0x99ff00" width="67" height="18" align="left" var="txtTileInfo"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="222" y="4" label="删" var="btnTileDele"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="197" y="4" label="设" var="btnTileSetting"/>
			  <Clip skin="png.guidecomp.clip_格子选中" x="0" y="0" width="252" height="30" sizeGrid="8,8,8,8,1" name="selectBox" mouseEnabled="false"/>
			</View>;
		public function tileListItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}