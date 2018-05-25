/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	public class tileMapUI extends View {
		public var imgMap:Image = null;
		protected static var uiXML:XML =
			<View width="628" height="635">
			  <Image skin="png.guidecomp.内框_1" width="628" height="635" sizeGrid="5,5,5,5,1" var="imgMap" name="" x="00" y="0"/>
			</View>;
		public function tileMapUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}