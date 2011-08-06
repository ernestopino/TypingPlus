package graph
{
	public dynamic class GraphList extends BaseGraphItem
	{
		public var list:Array = [];
		public var ownerID:String = "";
		public var connectionType:String = "";
		
		public function GraphList()
		{
			
		}
		
		public function addToList(a_go:GraphObject):void
		{
			list.push(a_go);
		}
	}

}