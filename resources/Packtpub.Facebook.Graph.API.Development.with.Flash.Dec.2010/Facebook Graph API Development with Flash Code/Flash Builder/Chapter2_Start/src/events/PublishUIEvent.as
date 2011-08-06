package events
{
	import flash.events.Event;
	import graph.apis.base.PublishObject;
	import graph.controls.publishing.PublishingCapabilities;
	
	/**
	 * ...
	 * @author MichaelJW
	 */
	public class PublishUIEvent extends Event
	{
		private var _ownerID:String;
		private var _connectionType:String;
		private var _publishingCapability:int = PublishingCapabilities.NONE;
		private var _publishObject:PublishObject;
		
		public static const SHOW_UI:String = "showUI";
		public static const PUBLISH:String = "publish";
		
		public function PublishUIEvent(type:String, a_ownerID:String = "", a_connectionType:String = "", a_publishingCapability:int = 0, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this._ownerID = a_ownerID;
			this._connectionType = a_connectionType;
			this._publishingCapability = a_publishingCapability;
		}
		
		public override function clone():Event
		{
			var event:PublishUIEvent = new PublishUIEvent(type, _ownerID, _connectionType, _publishingCapability, bubbles, cancelable);
			event.publishObject = _publishObject;
			return event;
		}
		
		public override function toString():String
		{
			return formatToString("PublishUIEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get ownerID():String
		{
			return _ownerID;
		}
		
		public function get connectionType():String
		{
			return _connectionType;
		}
		
		public function get publishingCapability():int
		{
			return _publishingCapability;
		}
		
		public function get publishObject():PublishObject
		{
			return _publishObject;
		}
		
		public function set publishObject(a_value:PublishObject):void
		{
			_publishObject = a_value;
		}
		
	}
	
}