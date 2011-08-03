package com.epinom.typingplus.vos
{
	public class TPSoundVO
	{
		private var _id:uint;
		private var _url:String;
		
		public function TPSoundVO(){}
		
		public function get id():uint { return _id; }
		public function set id(value:uint):void { _id = value; }
		
		public function get url():String { return _url; }
		public function set url(value:String):void { _url = value; }
	}
}