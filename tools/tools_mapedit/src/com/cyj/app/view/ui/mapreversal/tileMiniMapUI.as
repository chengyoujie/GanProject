/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	public class tileMiniMapUI extends View {
		protected static var uiXML:XML =
			<View width="250" height="200"/>;
		public function tileMiniMapUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}