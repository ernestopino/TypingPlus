package graph.controls
{
	import com.bit101.components.List;
	import com.bit101.components.Panel;
	import com.bit101.components.Window;
	import components.VWindow;
	import events.GCEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import graph.GraphObject;
	import graph.GraphRequest;
	
	public class GraphObjectRenderer extends VWindow
	{
		private static const WINDOW_WIDTH:Number = 240;
		private static const WINDOW_HEIGHT_REGULAR:Number = 240;
		private static const WINDOW_HEIGHT_EXPANDED:Number = 320;
		
		protected var _detailsPanel:GraphObjectPanel;
		protected var _showConnectionsBar:ConnectionListToggle;
		protected var _connectionsList:ConnectionsList;
		protected var _go:GraphObject;
		protected var _connectionsAreShowing:Boolean = false;
		protected var _hasListOfConnections:Boolean = false;
		
		public function GraphObjectRenderer(a_graphObject:GraphObject, a_x:Number = 0, a_y:Number = 0, a_parent:DisplayObjectContainer = null)
		{
			super(a_parent, a_x, a_y, "", false);

			_go = a_graphObject;
			if (_go.rendererObject)
			{
				//shouldn't be created
				throw new Error("Graph Object already has a renderer.");
				return;
			}
			
			var caption:String = a_graphObject.name;
			if (caption == "")
			{
				caption = a_graphObject.id;
			}
			this.title = caption;
			this.width = WINDOW_WIDTH;
			this.height = WINDOW_HEIGHT_REGULAR;
			this.hasCloseButton = true;
			
			_go.rendererObject = this;
			setUpWindowContents();
			renderData();
		}
		
		public function renderData(a_graphObject:GraphObject = null):void
		{
			if (a_graphObject)
			{
				_go = a_graphObject;
			}
			this.title = _go.name;
			_detailsPanel.renderGraphObject(_go);
			renderConnectionsList();
		}
		
		private function setUpWindowContents():void
		{
			_detailsPanel = new GraphObjectPanel(this.content);
			_detailsPanel.width = this.contentWidth;
			_detailsPanel.height = this.height - this.titleBar.height;
		}
		
		private function renderConnectionsList():void
		{
			_hasListOfConnections = (_go.metadata && _go.metadata.connections);
			
			if (_hasListOfConnections)
			{
				if (_showConnectionsBar)
				{
					
				}
				else
				{
					_showConnectionsBar = new ConnectionListToggle(this.content);
					_showConnectionsBar.addEventListener(GCEvent.TOGGLE_CONNECTIONS, onRequestToggleConnectionsList);
					_showConnectionsBar.width = this.width;
					_showConnectionsBar.y = _detailsPanel.y + _detailsPanel.height - _showConnectionsBar.height;
					_detailsPanel.height = _showConnectionsBar.y - _detailsPanel.y;
				}
				if (_connectionsList == null)
				{
					_connectionsList = new ConnectionsList(this.content, _detailsPanel.x, _showConnectionsBar.y + _showConnectionsBar.height);
					_connectionsList.width = this.width;
					_connectionsList.height = WINDOW_HEIGHT_EXPANDED - WINDOW_HEIGHT_REGULAR;
					_connectionsList.addEventListener(GCEvent.GRAPH_REQUEST, onRequestConnection);
				}
				_connectionsList.renderGraphObject(_go);
			}
			
		}
		
		private function onRequestConnection(a_event:GCEvent):void
		{
			var request:GraphRequest = a_event.request;
			request.objectID = _go.id;
			dispatchEvent(new GCEvent(GCEvent.GRAPH_REQUEST, request));
		}
		
		private function onRequestToggleConnectionsList(a_event:GCEvent):void
		{
			if (_connectionsAreShowing)
			{
				this.height = WINDOW_HEIGHT_REGULAR;
			}
			else
			{
				this.height = WINDOW_HEIGHT_EXPANDED;
			}
			_connectionsAreShowing = !_connectionsAreShowing;
			_showConnectionsBar.toggleDisplay(_connectionsAreShowing);
		}
		
		public function get graphObject():GraphObject
		{
			return _go;
		}
		
		/**
		 * The anchor point of any connection lines drawn
		 */
		public function get anchorPointGlobal():Point
		{
			if (!this.parent) return new Point(0, 0);
			
			var returnPoint:Point = new Point(this.x + (0.5 * this.width), this.y + (0.5 * this.height));
			if (_connectionsAreShowing)
			{
				returnPoint.y -= 0.5 * _connectionsList.height;
			}
			return this.parent.localToGlobal(returnPoint);
		}
	}

}