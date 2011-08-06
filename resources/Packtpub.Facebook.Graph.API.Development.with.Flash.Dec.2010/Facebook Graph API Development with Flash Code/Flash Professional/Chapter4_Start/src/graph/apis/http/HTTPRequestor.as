package graph.apis.http
{
	import events.DialogEvent;
	import events.RequestEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	import graph.apis.base.IRequestor;
	import graph.BaseGraphItem;
	import graph.GraphList;
	import graph.GraphObject;
	import graph.GraphRequest;
	import com.adobe.serialization.json.JSON;
	
	//the class needs to dispatch events
	public class HTTPRequestor extends EventDispatcher implements IRequestor
	{
		public var accessToken:String = "";
		
		//this is used to figure out which GraphRequest created each loader
		private var _requests:Dictionary = new Dictionary();
		
		public function HTTPRequestor(target:IEventDispatcher = null)
		{
			//this is needed because the class extends EventDispatcher
			super(target);
			ExternalInterface.addCallback("setAccessToken", setAccessToken);
			
			ExternalInterface.call("function() {"
				+ "window.setAccessToken = function(hashValue){"
				+ 	"var visualizer = document.getElementById('Visualizer');"
				+ 	"visualizer.setAccessToken(hashValue);"
				+ "}"
			+ "}");
		}
		
		public function request(a_request:GraphRequest):void
		{
			var loader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest();
			var variables:URLVariables = new URLVariables();
			
			//We construct a URL from the parameters of the GraphRequest
			urlRequest.url = "https://graph.facebook.com/" + a_request.objectID;
			if (a_request.connectionID)
			{
				urlRequest.url += "/" + a_request.connectionID;
			}
			
			variables.metadata = 1;
			if (accessToken != "")
			{
				variables.access_token = accessToken;
			}
			urlRequest.data = variables;
			
			//this is used to figure out which GraphRequest created the loader later
			_requests[loader] = a_request;
			
			loader.addEventListener(Event.COMPLETE, onGraphDataLoadComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(urlRequest);
		}
		
		private function onIOError(a_event:IOErrorEvent):void
		{
			trace(a_event.text);
		}
		
		private function onGraphDataLoadComplete(a_event:Event):void
		{
			var loader:URLLoader = a_event.target as URLLoader;
			var graphData:String = loader.data;
			var decodedJSON:Object = JSON.decode(graphData);
			
			//we find the original GraphRequest used to start the loader
			var originalRequest:GraphRequest = _requests[loader] as GraphRequest;
			
			if (decodedJSON.data)
			{
				var graphList:GraphList = new GraphList();
				var childGraphObject:GraphObject;
				for each (var childObject:Object in decodedJSON.data)
				{
					childGraphObject = new GraphObject();
					for (var childKey:String in childObject)
					{
						childGraphObject[childKey] = childObject[childKey];
					}
					graphList.addToList(childGraphObject);
				}
				graphList.paging = decodedJSON.paging;
				
				//we use the properties of the original GraphRequest to add
				//some extra data to the GraphList itself
				graphList.ownerID = originalRequest.objectID;
				graphList.connectionType = originalRequest.connectionID;
				
				//since this class does not have a renderGraphList() method, we dispatch an
				//event, which CustomGraphContainerController will listen for, and call its
				//own renderGraphList() method
				dispatchEvent(new RequestEvent(RequestEvent.REQUEST_COMPLETED, graphList));
			}
			else
			{
				var graphObject:GraphObject = new GraphObject();
				for (var key:String in decodedJSON)
				{
					graphObject[key] = decodedJSON[key];
				}
				
				//since this class does not have a renderGraphList() method, we dispatch an
				//event, which CustomGraphContainerController will listen for, and call its
				//own renderGraphList() method
				dispatchEvent(new RequestEvent(RequestEvent.REQUEST_COMPLETED, graphObject));
			}
		}
		
		public function attemptToAuthenticate(...permissions):void
		{
			var scope:String = "";
			if (permissions.length > 0)
			{
				scope = "&scope=" + permissions.join(",");
			}
			ExternalInterface.call("window.open",
				"https://graph.facebook.com/oauth/authorize?client_id=«redacted»&type=user_agent&redirect_uri=http://gamedev.michaeljameswilliams.com/scrap/visualizer/callback.html"
				+ scope,
				"facebookLoginWindow",
				"height=370, width=600");
		}
		
		private function onAuthenticationComplete(a_event:Event):void
		{
			trace("Authentication complete");
			var loader:URLLoader = URLLoader(a_event.target);
			trace(loader.data);
		}
		
		private function setAccessToken(a_hashValue:String):void
		{
			var hashParams:Array = a_hashValue.substr(1).split("&");
			var hashKeyAndValue:Array;
			
			for (var i:int = 0; i < hashParams.length; i++)
			{
				hashKeyAndValue = (hashParams[i] as String).split("=");
				if (hashKeyAndValue[0] == "access_token")
				{
					this.accessToken = hashKeyAndValue[1];
					break;
				}
			}
			this.request(new GraphRequest("me"));
		}

	}

}