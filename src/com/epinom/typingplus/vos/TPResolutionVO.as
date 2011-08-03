package com.epinom.typingplus.vos
{
	public class TPResolutionVO
	{
		private var _width:Number;
		private var _height:Number;
		
		public function TPResolutionVO() {}
		
		public function get width():Number { return _width; }
		public function set width(value:Number):void { _width = value; }
		
		public function get height():Number { return _height; }
		public function set height(value:Number):void { _height = value; }
		
		public function toString():String
		{
			var str:String = "[TPResolutionVO] : " + "width=" + _width +  ", height=" + _height;
			return str;
		}
	}
}