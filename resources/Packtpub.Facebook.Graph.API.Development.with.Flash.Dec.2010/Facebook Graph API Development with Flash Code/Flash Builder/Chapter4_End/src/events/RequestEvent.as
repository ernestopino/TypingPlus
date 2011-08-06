package events
{
	import flash.events.Event;
	import graph.BaseGraphItem;
	
	public class RequestEvent extends Event
	{
		public static const REQUEST_COMPLETED:String = "requestCompleted";
		
		private var _graphItem:BaseGraphItem;
		
		public function RequestEvent(type:String, a_graphItem:BaseGraphItem, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_graphItem = a_graphItem;
		}
		
		public override function clone():Event
		{
			return new RequestEvent(type, _graphItem, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("RequestEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get graphItem():BaseGraphItem
		{
			return _graphItem;
		}
		
	}
	
}