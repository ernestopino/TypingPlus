package graph
{
	public class GraphRequest
	{
		public var objectID:String = "";
		public var connectionID:String = "";
		public var limit:int = 25;
		public var offset:int = 0;
		public var since:String = "";
		public var until:String = "";
		
		public function GraphRequest(a_objectID:String = "", a_connectionID:String = "")
		{
			this.objectID = a_objectID;
			this.connectionID = a_connectionID;
		}
		
	}

}