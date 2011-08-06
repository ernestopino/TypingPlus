package graph.controls
{
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;
	import com.bit101.components.TextArea;
	import events.GCEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class ToggleBar extends Panel
	{
		protected var _label:Label;
		protected var _button:PushButton;
		
		public function ToggleBar(a_parent:DisplayObjectContainer = null, a_x:Number = 0, a_y:Number = 0)
		{
			super(a_parent, a_x, a_y);
			
			_label = new Label(this.content, 0, 0, " [ToggleBar]");
			_button = new PushButton(this.content, 0, 0, "Show", onClickButton);
			this.height = _button.height;
			fitToSize();
		}
		
		private function fitToSize():void
		{
			_button.height = this.height;
			_label.height = _button.height;
			_button.width = 40;
			_button.x = this.width - _button.width;
			_label.width = this.width - _button.width;
		}
		
		public function toggleDisplay(a_isNowShowing:Boolean):void
		{
			if (a_isNowShowing)
			{
				_button.label = "Hide";
			}
			else
			{
				_button.label = "Show";
			}
		}
		
		protected function onClickButton(a_event:MouseEvent):void
		{
			//do nothing
		}
		
		override public function get width():Number
		{
			return super.width;
		}
		
		override public function set width(a_value:Number):void
		{
			super.width = a_value;
			this.fitToSize();
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		/**
		 * Should not be altered.
		 */
		override public function set height(a_value:Number):void
		{
			//shouldn't do this
			super.height = a_value;
		}
	}

}