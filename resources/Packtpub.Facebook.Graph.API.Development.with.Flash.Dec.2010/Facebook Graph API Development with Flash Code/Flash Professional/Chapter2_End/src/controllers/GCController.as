package controllers
{
	import events.DialogEvent;
	import events.GCEvent;
	import events.GraphObjectEvent;
	import events.RequestEvent;
	import graph.apis.base.IRequestor;
	import graph.apis.base.PublishObject;
	import graph.controls.GraphListRenderer;
	import graph.controls.GraphObjectRenderer;
	import graph.controls.publishing.PublishingCapabilities;
	import graph.GraphList;
	import graph.GraphObject;
	import graph.GraphRequest;
	import ui.GraphControlContainer;
	public class GCController
	{
		protected var _gcc:GraphControlContainer;
		protected var _graphObjects:Object = { };
		protected var _requestor:IRequestor;
		protected var _showListCounts:Boolean = false;
		protected var _showListFilters:Boolean = false;
		protected var _publishingCapability:int = PublishingCapabilities.NONE;
		private var __showDeleteButtons:Boolean = false;
		private var __canShowSearchUI:Boolean = false;
		private var _canShowSearchUICallback:Function;
		
		public function GCController(a_graphControlContainer:GraphControlContainer)
		{
			_gcc = a_graphControlContainer;
		}
		
		protected function addEventListenersToRequestor():void
		{
			_requestor.addEventListener(RequestEvent.REQUEST_COMPLETED, onRequestComplete);
			_requestor.addEventListener(DialogEvent.DIALOG, onRequestorDialog);
			_requestor.addEventListener(DialogEvent.ERROR, onRequestorDialog);
		}
		
		protected function onRequestorDialog(a_event:DialogEvent):void
		{
			showDialogBox(a_event.message);
		}
		
		protected function onRequestComplete(a_event:RequestEvent):void
		{
			if (a_event.graphItem is GraphObject)
			{
				renderGraphObject(a_event.graphItem as GraphObject);
			}
			else if (a_event.graphItem is GraphList)
			{
				renderGraphList(a_event.graphItem as GraphList);
			}
		}
		
		protected function showDialogBox(a_message:String):void
		{
			_gcc.dispatchEvent(new DialogEvent(DialogEvent.DIALOG, a_message));
		}
		
		protected function listFilterCallback(a_objectID:String, a_connectionType:String, a_since:String, a_until:String):void
		{
			//stub
		}
		
		protected function deleteGraphObject(a_objectID:String):void
		{
			//stub
		}
		
		protected function renderGraphList(a_glist:GraphList):void
		{
			var glr:GraphListRenderer = new GraphListRenderer(a_glist, -100, -100);
			glr.publishingCapability = this._publishingCapability;
			glr.filterCallback = listFilterCallback;
			glr.deleteGraphObjectCallback = deleteGraphObject;
			glr.showCount = this._showListCounts;
			glr.showDeleteButton = this.__showDeleteButtons;
			if ((a_glist.connectionType != "") && (a_glist.ownerID != ""))
			{
				glr.showFilterBar = this._showListFilters;
			}
			else
			{
				//for search results
				glr.showFilterBar = false;
			}
			glr.addEventListener(GCEvent.CLOSE_WINDOW, onCloseGLR);
			glr.addEventListener(GraphObjectEvent.POP_OUT, onRequestPopOutGraphObject);
			_gcc.addListRenderer(glr);
		}
		
		protected function onRequestPopOutGraphObject(a_event:GraphObjectEvent):void
		{
			renderGraphObject(a_event.graphObject);
			if (_requestor)
			{
				_requestor.request(new GraphRequest(a_event.graphObject.id));
			}
		}
		
		protected function onCloseGLR(a_event:GCEvent):void
		{
			var glr:GraphListRenderer = a_event.target as GraphListRenderer;
			_gcc.removeListRenderer(glr);
		}
		
		public function renderGraphObject(a_graphObject:GraphObject):void
		{
			var gor:GraphObjectRenderer;
			
			if (a_graphObject.id != null)
			{
				if (_graphObjects[a_graphObject.id])
				{
					//graph object already exists and thus has a renderer
					var existingGraphObject:GraphObject = _graphObjects[a_graphObject.id] as GraphObject;
					gor = existingGraphObject.rendererObject;
					gor.renderData(a_graphObject);
				}
				else
				{
					_gcc.markAsPoppedOut(a_graphObject.id);
					
					//graph object does not exist, so a renderer must be created
					_graphObjects[a_graphObject.id] = a_graphObject;
					gor = new GraphObjectRenderer(a_graphObject, 0, 0);
					gor.addEventListener(GCEvent.CLOSE_WINDOW, onCloseGOR);
					_gcc.addObjectRenderer(gor);
					gor.addEventListener(GCEvent.GRAPH_REQUEST, onGORRequestItem);
				}
			}
			else
			{
				trace("Graph Object was null!");
			}
		}
		
		protected function onGORRequestItem(a_event:GCEvent):void
		{
			if (_requestor)
			{
				_requestor.request(a_event.request);
			}
		}
		
		protected function onCloseGOR(a_event:GCEvent):void
		{
			var gor:GraphObjectRenderer = a_event.target as GraphObjectRenderer;
			
			_gcc.markAsNotPoppedOut(gor.graphObject.id);
			_gcc.removeObjectRenderer(gor);
		}
		
		protected function get _canShowSearchUI():Boolean
		{
			return __canShowSearchUI;
		}
		
		protected function set _canShowSearchUI(a_value:Boolean):void
		{
			__canShowSearchUI = a_value;
			//yeah, I know, this is a very convoluted way of doing things.
			//wanted to avoid making you, the reader, have to dig in to any
			//other classes to make this change
			if (_canShowSearchUICallback != null)
			{
				_canShowSearchUICallback(__canShowSearchUI);
			}
		}
		
		public function get _showDeleteButtons():Boolean
		{
			return __showDeleteButtons;
		}
		
		public function set _showDeleteButtons(a_value:Boolean):void
		{
			__showDeleteButtons = a_value;
			for each (var glr:GraphListRenderer in _gcc._glrs)
			{
				glr.showDeleteButton = a_value;
			}
		}
		
		public function search(a_query:String = "", a_type:String = "", a_userID:String = ""):void
		{
			//stub
		}
		
		public function publish(a_publishObject:PublishObject):void
		{
			//stub
		}
		
		public function setSearchUISettingCallback(a_callback:Function):void
		{
			_canShowSearchUICallback = a_callback;
			_canShowSearchUICallback(__canShowSearchUI);
		}
	}

}