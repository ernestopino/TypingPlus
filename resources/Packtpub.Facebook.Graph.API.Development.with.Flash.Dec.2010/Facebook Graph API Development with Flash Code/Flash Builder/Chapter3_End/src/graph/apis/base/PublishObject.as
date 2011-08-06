package graph.apis.base
{
	import flash.net.FileReference;
	public dynamic class PublishObject
	{
		/**
		 * ID of the Graph Object to which to publish
		 */
		public var ownerID:String;
		/**
		 * Type of connection to which to publish
		 */
		public var connectionType:String;
		/**
		 * Message to post. Used in "post", "note", "comment", "checkin", and "status message" objects.
		 */
		public var message:String
		/**
		 * URL of picture to attach to a message. Used in "post" objects.
		 */
		public var pictureURL:String;
		/**
		 * URL of link to attach to a message. Used in "post" objects.
		 */
		public var linkURL:String;
		/**
		 * Caption for link specified by linkURL. Used in "post" objects.
		 */
		public var caption:String;
		/**
		 * The name of the link specified by linkURL. Used in "post" objects.
		 */
		public var linkName:String;
		/**
		 * Description of link specified by linkURL. Used in "post" objects.
		 */
		public var description:String;
		/**
		 * Image to upload. Used in "photo" objects.
		 */
		public var source:FileReference;
		/**
		 * Subject of a Note. Used in "note" objects.
		 */
		public var subject:String;
		/**
		 * Name of an Album. Used in "album" objects.
		 */
		public var name:String;
		/**
		 * Date and time that an event will start. Used in "event" objects.
		 * ISO 8601 format, i.e. 1:25pm UTC Nov 8 2010 is "2010-11-08T13:25Z"
		 */
		public var start_time:String;
		/**
		 * Date and time that an event will finish. Used in "event" objects.
		 * ISO 8601 format, i.e. 1:25pm UTC Nov 8 2010 is "2010-11-08T13:25Z"
		 */
		public var end_time:String;
		/**
		 * Lat/long coordinates of a location. Used in "checkin" objects.
		 * JSON string encoding an object containing "latitude" and "longitude" properties.
		 */
		public var coordinates:String;
		/**
		 * ID of a Place. Used in "checkin" objects.
		 */
		public var place:String;
		
		public function PublishObject()
		{
			
		}
		
	}

}