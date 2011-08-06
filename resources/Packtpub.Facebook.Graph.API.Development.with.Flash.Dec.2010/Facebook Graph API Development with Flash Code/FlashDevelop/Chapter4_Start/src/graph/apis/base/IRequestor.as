package graph.apis.base
{
	import flash.events.IEventDispatcher;
	import graph.GraphRequest;
	
	public interface IRequestor extends IEventDispatcher
	{
		function request(a_request:GraphRequest):void;
		function attemptToAuthenticate(...permissions):void;
	}
	
}