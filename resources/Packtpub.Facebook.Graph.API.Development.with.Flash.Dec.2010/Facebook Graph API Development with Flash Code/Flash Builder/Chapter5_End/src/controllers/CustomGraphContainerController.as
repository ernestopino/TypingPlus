package controllers
{
	import events.DialogEvent;
	import flash.events.Event;
	import graph.apis.base.ExtendedPermissions;
	import graph.apis.http.HTTPRequestor;
	import graph.apis.sdk.SDKRequestor;
	import graph.GraphRequest;
	import ui.GraphControlContainer;
	
	public class CustomGraphContainerController extends GCController
	{
		public function CustomGraphContainerController(a_graphControlContainer:GraphControlContainer)
		{
			super(a_graphControlContainer);
			this._showListCounts = true;
			this._showListFilters = true;
			
			_requestor = new HTTPRequestor();
			addEventListenersToRequestor();
			//we must wait for the Requestor to initialise before we can do anything else with it
			_requestor.addEventListener(Event.COMPLETE, onRequestorInitialize);
			
			_requestor.initialize();
		}
		
		private function onRequestorInitialize(a_event:Event):void
		{
			_requestor.attemptToAuthenticate(ExtendedPermissions.READ_STREAM);
		}
		
		override protected function listFilterCallback(a_objectID:String, a_connectionType:String, a_since:String, a_until:String):void
		{
			super.listFilterCallback(a_objectID, a_connectionType, a_since, a_until);
			var filterRequest:GraphRequest = new GraphRequest(a_objectID, a_connectionType);
			filterRequest.since = a_since;
			filterRequest.until = a_until;
			_requestor.request(filterRequest);
		}
	}

}