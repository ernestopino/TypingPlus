package graph.apis.sdk
{
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.data.FacebookSession;
	import com.facebook.graph.Facebook;
	import events.DialogEvent;
	import events.RequestEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequestMethod;
	import graph.apis.base.IRequestor;
	import graph.apis.base.PublishObject;
	import graph.GraphList;
	import graph.GraphObject;
	import graph.GraphRequest;
	
	public class SDKRequestor extends EventDispatcher implements IRequestor
	{
		public function SDKRequestor(target:IEventDispatcher = null)
		{
			super(target);
		}

		public function initialize():void
		{
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
			Facebook.api(
				graphItem,
				function(result:Object, fail:Object):void { requestComplete.call(this, result, fail, a_request); },
				{metadata: 1, limit:a_request.limit, offset:a_request.offset, since:a_request.since, until:a_request.until}
			);
		}
		
		public function search(a_query:String = "", a_type:String = "", a_userID:String = ""):void
		{
			var urlStub:String;
			if (a_type == "home")
			{
				urlStub = "/me/home";
			}
			else if ((a_type == "feed") && (a_userID != ""))
			{
				urlStub = "/" + a_userID + "/feed";
			}
			else
			{
				urlStub = "/search";
			}
			Facebook.api(
				urlStub,
				searchComplete,
				{ metadata: 1, q:a_query, type:a_type }
			);
		}
		
		private function searchComplete(result:Object, fail:Object):void
		{
			if (result != null)
			{
				var decodedJSON:Object = result;
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
				
				dispatchEvent(new RequestEvent(RequestEvent.REQUEST_COMPLETED, graphList));
			}
			else
			{
				//was a failure. See contents of 'fail' object.
			}
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
		
		public function publish(a_publishObject:PublishObject):void
		{
			var urlStub:String = "/" + a_publishObject.ownerID + "/" + a_publishObject.connectionType;
			var actionObj:Object = [ {
				name:"Visit my Twitter Page",
				link:"http://twitter.com/MichaelJW"
			} ];
			var actionString:String = JSON.encode(actionObj);
			
			var privacyObj:Object = {
				value:"ALL_FRIENDS"
			}
			var privacyString:String = JSON.encode(privacyObj);
			
			Facebook.api(
				urlStub,
				publishComplete,
				{
					message:a_publishObject.message,
					picture:a_publishObject.pictureURL,
					link:a_publishObject.linkURL,
					name:a_publishObject.linkName,
					caption:a_publishObject.caption,
					description:a_publishObject.description,
					actions:actionString,
					privacy:privacyString
				},
				URLRequestMethod.POST
			);
			
			Facebook.api(
				urlStub,
				publishComplete,
				{
					message:a_publishObject.message,
					source:a_publishObject.source
				},
				URLRequestMethod.POST
			);
		}
		
		private function publishComplete(result:Object, fail:Object):void
		{
			if (result != null)
			{
				dispatchEvent(new DialogEvent(DialogEvent.DIALOG, "Publish complete!"));
			}
			else
			{
				dispatchEvent(new DialogEvent(DialogEvent.DIALOG, "Publish failed. Details: " + String(fail)));
			}
		}
		
		public function deleteObject(a_objectID:String):void
		{
			Facebook.deleteObject(a_objectID, deleteComplete);
		}

		private function deleteComplete(result:Object, fail:Object):void
		{
			if (result != null)
			{
				dispatchEvent(new DialogEvent(DialogEvent.DIALOG, "Deleted!"));
			}
			else
			{
				dispatchEvent(new DialogEvent(DialogEvent.DIALOG, "Deletion failed. Details: " + String(fail)));
			}
		}
		
	}

}