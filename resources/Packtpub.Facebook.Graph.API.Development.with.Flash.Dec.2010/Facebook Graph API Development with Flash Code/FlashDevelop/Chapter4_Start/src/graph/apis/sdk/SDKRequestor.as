package graph.apis.sdk
{
	import com.facebook.graph.data.FacebookSession;
	import com.facebook.graph.Facebook;
	import events.DialogEvent;
	import events.RequestEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import graph.apis.base.IRequestor;
	import graph.GraphList;
	import graph.GraphObject;
	import graph.GraphRequest;
	
	public class SDKRequestor extends EventDispatcher implements IRequestor
	{
		public function SDKRequestor(target:IEventDispatcher = null)
		{
			super(target);
			
			Facebook.init("«redacted»", initComplete);
		}
		
		private function initComplete(success:Object, fail:Object):void
		{
			if (success is FacebookSession)
			{
				dispatchEvent(new Event(Event.COMPLETE))
			}
			else
			{
				//was a failure. See contents of 'fail' object.
			}
		}
		
		private function requestComplete(result:Object, fail:Object, originalRequest:GraphRequest):void
		{
			var stringJson:String = "";
			if (result != null)
			{
				var decodedJSON:Object = result;
				if (originalRequest.connectionID)
				{
					var graphList:GraphList = new GraphList();
					var childGraphObject:GraphObject;
					for each (var childObject:Object in decodedJSON)
					{
						childGraphObject = new GraphObject();
						for (var childKey:String in childObject)
						{
							childGraphObject[childKey] = childObject[childKey];
						}
						graphList.addToList(childGraphObject);
					}
					graphList.paging = decodedJSON.paging;
					
					graphList.ownerID = originalRequest.objectID;
					graphList.connectionType = originalRequest.connectionID;
					
					dispatchEvent(new RequestEvent(RequestEvent.REQUEST_COMPLETED, graphList));
				}
				else
				{
					var graphObject:GraphObject = new GraphObject();
					for (var key:String in decodedJSON)
					{
						graphObject[key] = decodedJSON[key];
					}
					
					dispatchEvent(new RequestEvent(RequestEvent.REQUEST_COMPLETED, graphObject));
				}
			}
			else
			{
				//was a failure. See contents of 'fail' object.
			}
		}
		
		public function request(a_request:GraphRequest):void
		{
			var graphItem:String = "/" + a_request.objectID;
			if (a_request.connectionID)
			{
				graphItem += "/" + a_request.connectionID;
			}
			Facebook.api(graphItem, function(result:Object, fail:Object):void { requestComplete.call(this, result, fail, a_request); }, {metadata: 1});
		}
		
		public function attemptToAuthenticate(...permissions):void
		{
			var scope:String = "";
			if (permissions.length > 0)
			{
				scope = permissions.join(",");
			}
			Facebook.login(loginComplete, {perms: scope});
		}
		
		private function loginComplete(success:Object, fail:Object):void
		{
			if (success is FacebookSession)
			{
				this.request(new GraphRequest("me"));
			}
			else
			{
				//was a failure. See contents of 'fail' object.
			}
		}
		
	}

}