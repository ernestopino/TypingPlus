package controllers
{
	import flash.events.Event;
	import graph.apis.base.ExtendedPermissions;
	import graph.apis.http.HTTPRequestor;
	import graph.apis.sdk.SDKRequestor;
	import graph.GraphRequest;
	import ui.GraphControlContainer;
	
	public class CustomGraphContainerController extends GCController
	{
		// gamedev.michaeljameswilliams.com/scrap/visualizer/sdkindex.html
		public function CustomGraphContainerController(a_graphControlContainer:GraphControlContainer)
		{
			super(a_graphControlContainer);
			_requestor = new SDKRequestor();
			addEventListenersToRequestor();
			//we must wait for the SDK to initialise before we can do anything else with it
			_requestor.addEventListener(Event.COMPLETE, onRequestorInitialize);
		}
		
		private function onRequestorInitialize(a_event:Event):void
		{
			_requestor.attemptToAuthenticate(ExtendedPermissions.READ_STREAM);
		}
		
	}

}