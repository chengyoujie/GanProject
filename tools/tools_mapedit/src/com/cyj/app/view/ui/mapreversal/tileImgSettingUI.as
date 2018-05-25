/**Created by the Morn,do not modify.*/
package com.cyj.app.view.ui.mapreversal {
	import morn.core.components.*;
	public class tileImgSettingUI extends View {
		public var bg:Image = null;
		public var txtTitle:Label = null;
		public var btnCancle:Button = null;
		public var btnOK:Button = null;
		public var btnClose:Button = null;
		public var inputCellW:TextInput = null;
		public var txtImgInfo:TextArea = null;
		public var inputCellH:TextInput = null;
		public var inputSpaceX:TextInput = null;
		public var inputSpaceY:TextInput = null;
		public var panelImgPreView:Panel = null;
		public var imgPre:Image = null;
		public var inputNumX:TextInput = null;
		public var inputNumY:TextInput = null;
		public var inputStartX:TextInput = null;
		public var inputStartY:TextInput = null;
		protected static var uiXML:XML =
			<View width="400" height="450">
			  <Image skin="png.guidecomp.通用面板_2" x="0" y="0" width="401" height="450" sizeGrid="160,40,160,40,1" var="bg"/>
			  <Label text="提示" x="129" y="8" width="148" height="18" align="center" color="0xccff00" stroke="0x0" var="txtTitle"/>
			  <Button label="取消" skin="png.guidecomp.btn_四字常规_1" x="210" y="388" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnCancle"/>
			  <Button label="确定" skin="png.guidecomp.btn_四字常规_1" x="98" y="388" labelColors="0xc79a84,0xe0a98d,0x93827a" labelStroke="0x0" var="btnOK"/>
			  <Button skin="png.guidecomp.btn_关闭_1" x="372" y="17" var="btnClose"/>
			  <TextArea text="图片信息：" skin="png.guidecomp.textarea" x="20" y="47" width="79" height="19" color="0x66ffff" align="center" isHtml="true" editable="false"/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="171" y="78" color="0xffff99" width="78" height="24" margin="3,3,3" var="inputCellW" restrict="0-9"/>
			  <TextArea text="100x100" skin="png.guidecomp.textarea" x="120" y="47" width="256" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" var="txtImgInfo"/>
			  <TextArea skin="png.guidecomp.textarea" x="20" y="79" vScrollBarSkin="png.guidecomp.vscroll" width="74" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="切片信息："/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="297" y="76" color="0xffff99" width="79" height="24" margin="3,3,3" var="inputCellH" restrict="0-9"/>
			  <TextArea skin="png.guidecomp.textarea" x="132" y="79" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="宽"/>
			  <TextArea skin="png.guidecomp.textarea" x="254" y="80" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="高"/>
			  <TextArea skin="png.guidecomp.textarea" x="20" y="110" vScrollBarSkin="png.guidecomp.vscroll" width="74" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="切图间隔："/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="169" y="107" color="0xffff99" width="78" height="24" margin="3,3,3" var="inputSpaceX" restrict="0-9"/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="295" y="105" color="0xffff99" width="79" height="24" margin="3,3,3" var="inputSpaceY" restrict="0-9"/>
			  <TextArea skin="png.guidecomp.textarea" x="132" y="108" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="宽"/>
			  <TextArea skin="png.guidecomp.textarea" x="254" y="109" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="高"/>
			  <Panel x="29" y="189" width="348" height="190" vScrollBarSkin="png.guidecomp.vscroll" hScrollBarSkin="png.guidecomp.hscroll" var="panelImgPreView">
			    <Image skin="png.comp.blank" width="298" height="157" x="0" y="0" var="imgPre"/>
			  </Panel>
			  <TextArea skin="png.guidecomp.textarea" x="20" y="165" vScrollBarSkin="png.guidecomp.vscroll" width="74" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="切图个数："/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="167" y="162" color="0xffff99" width="78" height="24" margin="3,3,3" var="inputNumX" restrict="0-9"/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="293" y="160" color="0xffff99" width="79" height="24" margin="3,3,3" var="inputNumY" restrict="0-9"/>
			  <TextArea skin="png.guidecomp.textarea" x="132" y="163" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="横(x)"/>
			  <TextArea skin="png.guidecomp.textarea" x="254" y="164" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="竖(y)"/>
			  <TextArea skin="png.guidecomp.textarea" x="6" y="140" width="90" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="切图起始位置："/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="169" y="136" color="0xffff99" width="78" height="24" margin="3,3,3" var="inputStartX" restrict="0-9"/>
			  <TextInput text="100" skin="png.guidecomp.textinput_2" x="295" y="134" color="0xffff99" width="79" height="24" margin="3,3,3" var="inputStartY" restrict="0-9"/>
			  <TextArea skin="png.guidecomp.textarea" x="132" y="137" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="横(x)"/>
			  <TextArea skin="png.guidecomp.textarea" x="254" y="138" width="36" height="19" color="0x66ffff" align="center" isHtml="true" editable="false" text="竖(y)"/>
			</View>;
		public function tileImgSettingUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}