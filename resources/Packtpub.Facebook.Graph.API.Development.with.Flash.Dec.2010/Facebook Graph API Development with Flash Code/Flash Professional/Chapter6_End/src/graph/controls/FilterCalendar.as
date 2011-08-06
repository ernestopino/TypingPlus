package graph.controls
{
	import com.bit101.components.Calendar;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FilterCalendar extends Calendar
	{
	
		public function FilterCalendar(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0)
		{
			super(a_parent, a_xpos, a_ypos);
		}
		
		override protected function onDayClick(a_event:MouseEvent):void
		{
			super.onDayClick(a_event);
			dispatchEvent(new Event(Event.CHANGE));
		}
	}

}