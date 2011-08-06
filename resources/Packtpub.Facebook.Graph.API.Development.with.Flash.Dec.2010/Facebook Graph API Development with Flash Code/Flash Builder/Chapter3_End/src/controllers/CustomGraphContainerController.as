package controllers
{
	import graph.apis.http.HTTPRequestor;
	import graph.GraphRequest;
	import ui.GraphControlContainer;
	
	public class CustomGraphContainerController extends GCController
	{
		
		public function CustomGraphContainerController(a_graphControlContainer:GraphControlContainer)
		{
			super(a_graphControlContainer);
			_requestor = new HTTPRequestor();
			addEventListenersToRequestor();
			_requestor.request(new GraphRequest("PacktPub"));
		}
		
	}

}