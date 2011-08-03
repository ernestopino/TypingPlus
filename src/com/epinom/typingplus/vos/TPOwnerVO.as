package com.epinom.typingplus.vos
{
	public class TPOwnerVO
	{
		private var _name:String;
		private var _web:String;
		
		public function TPComponentVO() {}
		
		public function get name():String { return _name; }
		public function set name(value:String):void { _name = value; }
		
		public function get web():String { return _web; }
		public function set web(value:String):void { _web = value; }
		
		public function toString():String
		{
			var str:String = "[TPComponentVO] : " + "name=" + _name + ", web=" + _web;
			return str;
		}
	}
}