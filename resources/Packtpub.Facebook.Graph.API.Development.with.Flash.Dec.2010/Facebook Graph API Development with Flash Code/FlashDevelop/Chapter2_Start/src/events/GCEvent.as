package events
{
	import flash.events.Event;
	import graph.GraphRequest;
	
	public class GCEvent extends Event
	{
		public static const CLOSE_WINDOW:String = "closeWindow";
		public static const TOGGLE_CONNECTIONS:String = "toggleConnections";
		public static const TOGGLE_LIST_FILTER:String = "toggleListFilter";
		public static const GRAPH_REQUEST:String = "graphRequest";
		
		private var _request:GraphRequest;
		
		public function GCEvent(type:String, a_request:GraphRequest=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_request = a_request;
		}
		
		public override function clone():Event
		{
			return new GCEvent(type, _request, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("GCEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get request():GraphRequest
		{
			return _request;
		}
		
	}
	
}