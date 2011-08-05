package com.epinom.typingplus.views
{	
	import com.epinom.typingplus.vos.TPComponentVO;
	import com.epinom.typingplus.objects.TPInterfaceObject;
	
	import flash.display.DisplayObject;
	
	public class TPComponent
	{
		private var _vo:TPComponentVO;
		private var _io:TPInterfaceObject;
		private var _displayObject:DisplayObject;
		
		public function TPComponent(vo:TPComponentVO, io:TPInterfaceObject, displayObject:DisplayObject)
		{
			_vo = vo;
			_io = io;
			_displayObject = displayObject;
		}
		
		public function get vo():TPComponentVO { return _vo; }
		public function set vo(value:TPComponentVO):void { _vo = value; }
		
		public function get io():TPInterfaceObject { return _io; }
		public function set io(value:TPInterfaceObject):void { _io = value; }
		
		public function get displayObject():DisplayObject { return _displayObject; }
		public function set displayObject(value: DisplayObject):void { _displayObject = value; }
	}
}