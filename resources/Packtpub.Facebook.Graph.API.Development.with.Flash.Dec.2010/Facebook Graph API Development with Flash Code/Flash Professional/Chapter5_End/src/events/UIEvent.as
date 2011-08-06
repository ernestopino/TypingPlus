package events
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		public static const ZOOM_IN:String = "zoomIn";
		public static const ZOOM_OUT:String = "zoomOut";
		public static const RESET_VIEW:String = "resetView";
		public static const RECENTER:String = "recenter";
		
		public function UIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
		}
		
		public override function clone():Event
		{
			return new UIEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("UIEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
	}
	
}