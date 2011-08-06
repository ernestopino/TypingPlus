package graph.apis.base
{
	import flash.events.IEventDispatcher;
	import graph.GraphRequest;
	
	public interface IRequestor extends IEventDispatcher
	{
		function request(a_request:GraphRequest):void;
		function attemptToAuthenticate(...permissions):void;
		function initialize():void;
		function search(a_query:String = "", a_type:String = "", a_userID:String = ""):void;
		function publish(a_publishObject:PublishObject):void;
		function deleteObject(a_objectID:String):void;
	}
	
}