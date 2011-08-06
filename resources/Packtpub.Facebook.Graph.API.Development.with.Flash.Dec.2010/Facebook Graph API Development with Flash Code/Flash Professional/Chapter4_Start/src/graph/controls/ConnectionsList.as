package graph.controls
{
	import com.bit101.components.List;
	import com.bit101.components.ListItem;
	import events.GCEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import graph.GraphObject;
	import graph.GraphRequest;
	
	public class ConnectionsList extends List
	{
		private var _go:GraphObject;
		
		public function ConnectionsList(a_parent:DisplayObjectContainer = null, a_x:Number = 0, a_y:Number = 0, a_graphObject:GraphObject = null)
		{
			super(a_parent, a_x, a_y);
			if (a_graphObject)
			{
				renderGraphObject(a_graphObject);
			}
			this.addEventListener(MouseEvent.CLICK, onClickList);
		}
		
		private function onClickList(a_event:MouseEvent):void
		{
			if (a_event.target is ListItem)
			{
				var item:ListItem = a_event.target as ListItem;
				var connectionID:String = item.data.data as String;
				var request:GraphRequest = new GraphRequest("", connectionID);
				dispatchEvent(new GCEvent(GCEvent.GRAPH_REQUEST, request));
			}
		}
		
		public function renderGraphObject(a_graphObject:GraphObject):void
		{
			this.removeAll();
			
			_go = a_graphObject;
			if (_go.metadata && _go.metadata.connections)
			{
				for (var key:String in _go.metadata.connections)
				{
					this.addItem( { label:key, data:key } );
				}
			}
			else
			{
				//oops! no connections.
			}
		}
		
	}

}