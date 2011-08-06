package events
{
	import flash.events.Event;
	import graph.GraphObject;
	
	public class GraphObjectEvent extends Event
	{
		public static const POP_OUT:String = "popOut";
		
		private var _graphObject:GraphObject;
		
		public function GraphObjectEvent(type:String, a_graphObject:GraphObject, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_graphObject = a_graphObject;
		}
		
		public override function clone():Event
		{
			return new GraphObjectEvent(type, _graphObject, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("GraphObjectEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get graphObject():GraphObject
		{
			return _graphObject;
		}
		
	}
	
}