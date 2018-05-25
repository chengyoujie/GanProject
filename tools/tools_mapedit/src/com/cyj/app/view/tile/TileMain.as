package com.cyj.app.view.tile
{
	import com.cyj.app.ToolsApp;
	import com.cyj.app.data.TileLayerData;
	import com.cyj.app.view.tile.cell.TileCellBase;
	import com.cyj.app.view.tile.cell.TileCellImg;
	import com.cyj.app.view.tile.layer.TileLayer;
	import com.cyj.app.view.ui.mapreversal.tileMainUI;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.registerClassAlias;
	
	import morn.core.handlers.Handler;

	public class TileMain extends tileMainUI
	{
		public var curUseTile:TileSelectClip = new TileSelectClip();
		/**当前操作的图层**/
		public var curOperLayer:TileLayer;
		public var tileSetting:TileImgSetting;
		
		
		public function TileMain()
		{
			super();
			initView();
			initEvent();
		}
		
		
		private function initEvent():void
		{
			btnEraser.clickHandler = new Handler(handleEraser);
			btnBrush.clickHandler = new Handler(handleBrush);
			btnFill.clickHandler = new Handler(handleFill);
		}
		
		private function initView():void
		{
			tileSetting = new TileImgSetting();
		}
		
		/**
		 *初始化项目
		 */		
		public function initPorject():void
		{
			viewImgList.initPorject();
			viewTileMap.initProject();
			viewTileLayerList.initProject();
			viewTileLogic.initPorject();
		}
		
		private function handleEraser():void
		{
			curUseTile.oper = TileSelectClip.OPER_EARS;
		}
		private function handleBrush():void
		{
			curUseTile.oper = TileSelectClip.OPER_NORMAL;
		}
		
		private function handleFill():void
		{
			curUseTile.oper=TileSelectClip.OPER_FILL;
		}
		
	}
}