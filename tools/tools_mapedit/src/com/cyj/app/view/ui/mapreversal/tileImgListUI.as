/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	import com.cyj.app.view.tile.imglist.TileListItem;
	public class tileImgListUI extends View {
		public var listTile:List = null;
		protected static var uiXML:XML =
			<View width="280" height="322">
			  <List x="0" y="20" repeatY="9" vScrollBarSkin="png.guidecomp.vscroll" width="276" height="301" var="listTile">
			    <tileListItem x="0" y="0" runtime="com.cyj.app.view.tile.imglist.TileListItem" name="render"/>
			  </List>
			  <Label text="图块列表" color="0xffcc33" width="283" height="18" align="center" x="-4" y="-1"/>
			</View>;
		public function tileImgListUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.tile.imglist.TileListItem"] = TileListItem;
			super.createChildren();
			createView(uiXML);
		}
	}
}