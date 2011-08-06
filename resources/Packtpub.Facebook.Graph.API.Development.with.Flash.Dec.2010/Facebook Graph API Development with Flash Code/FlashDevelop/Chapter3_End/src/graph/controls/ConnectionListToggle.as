package graph.controls
{
	import events.GCEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	public class ConnectionListToggle extends ToggleBar
	{
		
		public function ConnectionListToggle(a_parent:DisplayObjectContainer = null, a_x:Number = 0, a_y:Number = 0)
		{
			super(a_parent, a_x, a_y);
			_label.text = " Connections";
		}
		
		override protected function onClickButton(a_event:MouseEvent):void
		{
			dispatchEvent(new GCEvent(GCEvent.TOGGLE_CONNECTIONS));
		}
	}

}