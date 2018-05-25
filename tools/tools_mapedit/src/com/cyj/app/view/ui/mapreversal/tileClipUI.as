/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	public class tileClipUI extends View {
		public var imgTile:Image = null;
		protected static var uiXML:XML =
			<View width="286" height="292">
			  <Image skin="png.guidecomp.内框_1" width="286" height="292" sizeGrid="5,5,5,5,1" var="imgTile" name="" x="0." y="0"/>
			</View>;
		public function tileClipUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}