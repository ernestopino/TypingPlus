package graph.controls
{
	import com.bit101.components.Calendar;
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.Window;
	import components.ScrollablePanel;
	import events.DialogEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class FilterPanel extends Panel
	{
		protected static const PADDING:Number = 10;
		
		protected var _sinceLabel:Label;
		protected var _sinceInput:InputText;
		protected var _sinceCalendarButton:PushButton;
		protected var _sinceCalendar:Calendar;
		protected var _untilLabel:Label;
		protected var _untilInput:InputText;
		protected var _untilCalendarButton:PushButton;
		protected var _untilCalendar:Calendar;
		protected var _submitButton:PushButton;
		
		protected var _callback:Function;
		protected var _objectID:String;
		protected var _connectionID:String;
		
		public function FilterPanel(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0)
		{
			super(a_parent, a_xpos, a_ypos);
			
			_sinceLabel = new Label(content, PADDING, PADDING, "Since:");
			_sinceInput = new InputText(content, PADDING, _sinceLabel.y + _sinceLabel.height);
			_sinceCalendarButton = new PushButton(content, 0, _sinceInput.y, "C", onClickSinceCalendarButton);
			
			_untilLabel = new Label(content, PADDING, _sinceInput.y + _sinceInput.height + PADDING, "Until:");
			_untilInput = new InputText(content, PADDING, _untilLabel.y + _untilLabel.height);
			_untilCalendarButton = new PushButton(content, 0, _untilInput.y, "C", onClickUntilCalendarButton);
			
			_submitButton = new PushButton(content, 0, 0, "Filter", onClickSubmitButton);
			
			_sinceCalendar = new FilterCalendar(content, PADDING / 2, PADDING / 2);
			_untilCalendar = new FilterCalendar(content, PADDING / 2, PADDING / 2);
			_sinceCalendar.visible = _untilCalendar.visible = false;
			
			
			_sinceCalendar.addEventListener(Event.CHANGE, onSinceCalendarChooseDate);
			_untilCalendar.addEventListener(Event.CHANGE, onUntilCalendarChooseDate);
			
			setPositions();
		}
		
		
		public function setCallback(a_callback:Function):void
		{
			_callback = a_callback;
		}
		
		private function onClickSubmitButton(a_event:Event):void
		{
			if (_callback != null)
			{
				_callback(_objectID, _connectionID, _sinceInput.text, _untilInput.text);
			}
		}
		
		private function setPositions():void
		{
			_sinceLabel.x = PADDING;
			_sinceLabel.y = PADDING;
			_sinceInput.x = PADDING;
			_sinceInput.y = _sinceLabel.y + _sinceLabel.height;
			_sinceCalendarButton.y = _sinceInput.y;
			_sinceCalendarButton.width = _sinceCalendarButton.height = _sinceInput.height;
			_sinceCalendarButton.x = this.width - PADDING - _sinceCalendarButton.width;
			_sinceInput.width = this.width - (3 * PADDING) - _sinceCalendarButton.width;
			
			_untilLabel.x = PADDING;
			_untilLabel.y = _sinceInput.y + _sinceInput.height + PADDING;
			_untilInput.x = PADDING;
			_untilInput.y = _untilLabel.y + _untilLabel.height;
			_untilCalendarButton.y = _untilInput.y;
			_untilCalendarButton.width = _untilCalendarButton.height = _untilInput.height;
			_untilCalendarButton.x = this.width - PADDING - _untilCalendarButton.width;
			_untilInput.width = this.width - (3 * PADDING) - _untilCalendarButton.width;
			
			_submitButton.x = this.width - PADDING - _submitButton.width;
			_submitButton.y = _untilInput.y + _untilInput.height + PADDING;
		}
		
		private function onSinceCalendarChooseDate(a_event:Event):void
		{
			_sinceCalendar.visible = false;
			_sinceInput.text = _sinceCalendar.year.toString() + "-" + (_sinceCalendar.month + 1).toString() + "-" + _sinceCalendar.day.toString();
		}

		private function onUntilCalendarChooseDate(a_event:Event):void
		{
			_untilCalendar.visible = false;
			_untilInput.text = _untilCalendar.year.toString() + "-" + (_untilCalendar.month + 1).toString() + "-" + _untilCalendar.day.toString();
		}

		private function onClickSinceCalendarButton(a_event:MouseEvent):void
		{
			_untilCalendar.visible = false;
			_sinceCalendar.visible = !_sinceCalendar.visible;	//toggle
		}

		private function onClickUntilCalendarButton(a_event:MouseEvent):void
		{
			_sinceCalendar.visible = false;
			_untilCalendar.visible = !_untilCalendar.visible;	//toggle
		}
		
		/**
		 * Returns the value of the "since" parameter
		 */
		public function get since():String
		{
			return _sinceInput.text;
		}
		
		/**
		 * Returns the value of the "until" parameter
		 */
		public function get until():String
		{
			return _untilInput.text;
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		override public function set height(a_value:Number):void
		{
			super.height = a_value;
			setPositions();
		}
		
		override public function get width():Number
		{
			return super.width;
		}
		
		override public function set width(a_value:Number):void
		{
			super.width = a_value;
			setPositions();
		}
		
		public function set connectionID(a_value:String):void
		{
			_connectionID = a_value;
		}
		
		public function set objectID(a_value:String):void
		{
			_objectID = a_value;
		}
	}

}