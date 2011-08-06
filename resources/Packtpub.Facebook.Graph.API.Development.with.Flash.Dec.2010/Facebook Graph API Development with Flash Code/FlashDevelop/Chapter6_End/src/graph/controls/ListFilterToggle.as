package graph.controls
{
	import events.GCEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	public class ListFilterToggle extends ToggleBar
	{
		
		public function ListFilterToggle(a_parent:DisplayObjectContainer = null, a_x:Number = 0, a_y:Number = 0)
		{
			super(a_parent, a_x, a_y);
			_label.text = " Filter";
		}
		
		override protected function onClickButton(a_event:MouseEvent):void
		{
			dispatchEvent(new GCEvent(GCEvent.TOGGLE_LIST_FILTER));
		}
	}

}