package events
{
	import flash.events.Event;
	
	public class DialogEvent extends Event
	{
		public static const ERROR:String = "ErrorDialog";
		public static const DIALOG:String = "DefaultDialog";
		
		private var _message:String;
		
		public function DialogEvent(type:String, a_message:String = "", bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_message = a_message;
		}
		
		public override function clone():Event
		{
			return new DialogEvent(type, _message, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("DialogEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
		
		public function get message():String
		{
			return _message;
		}
		
	}
	
}