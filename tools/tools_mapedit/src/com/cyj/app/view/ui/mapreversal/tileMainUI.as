/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	import com.cyj.app.view.tile.TileClip;
	import com.cyj.app.view.tile.TileMap;
	import com.cyj.app.view.tile.imglist.TileImgList;
	import com.cyj.app.view.tile.layer.TileLayerList;
	import com.cyj.app.view.tile.logic.TileLogic;
	import com.cyj.app.view.ui.mapreversal.tileMiniMapUI;
	public class tileMainUI extends View {
		public var panelLayerList:Panel = null;
		public var viewTileLayerList:TileLayerList = null;
		public var viewTileLogic:TileLogic = null;
		public var viewTileMiniMap:tileMiniMapUI = null;
		public var btnBrush:Button = null;
		public var panelClip:Panel = null;
		public var viewTileClip:TileClip = null;
		public var viewImgList:TileImgList = null;
		public var btnEraser:Button = null;
		public var btnFill:Button = null;
		public var panelTileMap:Panel = null;
		public var viewTileMap:TileMap = null;
		protected static var uiXML:XML =
			<View width="1200" height="700">
			  <Image skin="png.comp.blank" x="8" y="0" width="1180" height="54"/>
			  <Image skin="png.comp.blank" x="8" y="60" width="250" height="640"/>
			  <Image skin="png.comp.blank" x="261" y="60" width="630" height="640"/>
			  <Image skin="png.comp.blank" x="894" y="60" width="295" height="640"/>
			  <Panel x="7" y="467" width="251" height="232" var="panelLayerList">
			    <tileLayerList runtime="com.cyj.app.view.tile.layer.TileLayerList" var="viewTileLayerList"/>
			  </Panel>
			  <tileLogic x="8" y="264" var="viewTileLogic" runtime="com.cyj.app.view.tile.logic.TileLogic"/>
			  <tileMiniMap x="8" y="61" var="viewTileMiniMap" runtime="com.cyj.app.view.ui.mapreversal.tileMiniMapUI"/>
			  <Label text="选择项目" x="-84" y="83" color="0x99ff00" width="71" height="18" align="center"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnBrush" labelStroke="0" width="61" height="46" x="84" y="5" label="画笔"/>
			  <Image skin="png.guidecomp.line" x="901" y="391" width="285"/>
			  <Panel x="897" y="401" vScrollBarSkin="png.guidecomp.vscroll" hScrollBarSkin="png.guidecomp.hscroll" width="292" height="299" var="panelClip">
			    <tileClip runtime="com.cyj.app.view.tile.TileClip" var="viewTileClip"/>
			  </Panel>
			  <tileImgList x="900" y="65" var="viewImgList" runtime="com.cyj.app.view.tile.imglist.TileImgList"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnEraser" labelStroke="0" width="61" height="46" x="146" y="4" label="擦除"/>
			  <Button skin="png.guidecomp.btn_小按钮_1" labelColors="0xc79a84,0xe0a98d,0x93827a" var="btnFill" labelStroke="0" width="61" height="46" x="212" y="6" label="填充"/>
			  <Panel x="263" y="60" width="627" height="640" vScrollBarSkin="png.guidecomp.vscroll" hScrollBarSkin="png.guidecomp.hscroll" var="panelTileMap">
			    <tileMap var="viewTileMap" runtime="com.cyj.app.view.tile.TileMap"/>
			  </Panel>
			</View>;
		public function tileMainUI(){}
		override protected function createChildren():void {
			viewClassMap["com.cyj.app.view.tile.TileClip"] = TileClip;
			viewClassMap["com.cyj.app.view.tile.TileMap"] = TileMap;
			viewClassMap["com.cyj.app.view.tile.imglist.TileImgList"] = TileImgList;
			viewClassMap["com.cyj.app.view.tile.layer.TileLayerList"] = TileLayerList;
			viewClassMap["com.cyj.app.view.tile.logic.TileLogic"] = TileLogic;
			viewClassMap["com.cyj.app.view.ui.mapreversal.tileMiniMapUI"] = tileMiniMapUI;
			super.createChildren();
			createView(uiXML);
		}
	}
}