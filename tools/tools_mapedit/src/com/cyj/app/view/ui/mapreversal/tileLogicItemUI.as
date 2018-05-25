/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	public class tileLogicItemUI extends View {
		public var txtLogicName:Label = null;
		public var imgColorTrue:Image = null;
		public var imgColorFalse:Image = null;
		public var btnRemove:Button = null;
		public var btnTrue:Button = null;
		public var btnFalse:Button = null;
		protected static var uiXML:XML =
			<View width="225" height="30">
			  <Image skin="png.guidecomp.内框_1" width="225" height="30" sizeGrid="5,5,5,5,1" x="0" y="0"/>
			  <Label text="图片名称" x="58" y="6" color="0x99ff00" width="90" height="18" align="left" var="txtLogicName"/>
			  <Image skin="png.comp.blank" x="6" y="6" width="20" height="19" var="imgColorTrue"/>
			  <Image skin="png.comp.blank" x="30" y="6" width="19" height="19" var="imgColorFalse"/>
			  <Label text="真" x="9" y="6" color="0xffffff" width="16" height="19"/>
			  <Label text="假" x="32" y="6" color="0xffffff" width="15" height="18"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="195" y="5" label="-" var="btnRemove"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="139" y="4" label="真" var="btnTrue" toggle="true"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0" width="24" height="21" x="166" y="4" label="假" var="btnFalse" toggle="true"/>
			  <Clip skin="png.guidecomp.clip_格子选中" x="0" y="0" width="225" height="30" sizeGrid="8,8,8,8,1" name="selectBox" mouseEnabled="false"/>
			</View>;
		public function tileLogicItemUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}