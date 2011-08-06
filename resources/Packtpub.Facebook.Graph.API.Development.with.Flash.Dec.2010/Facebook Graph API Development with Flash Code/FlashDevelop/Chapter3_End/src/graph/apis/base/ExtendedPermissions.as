package graph.apis.base
{
	public class ExtendedPermissions
	{
		/**
		 * Enables application to post content, comments, and likes to the user's stream and to their friends' streams.
		 */
		public static const PUBLISH_STREAM:String = "publish_stream";
		/**
		 * Enables application to create and modify events on the user's behalf.
		 */
		public static const CREATE_EVENT:String = "create_event";
		/**
		 * Enables application to RSVP to events on the user's behalf.
		 */
		public static const RSVP_EVENT:String = "rsvp_event";
		/**
		 * Enables application to send text messages to the user and respond to text messages from the user.
		 */
		public static const SMS:String = "sms";
		/**
		 * Prevents access token from expiring.
		 */
		public static const OFFLINE_ACCESS:String = "offline_access";
		/**
		 * Provides access to the "About Me" section of the user's profile.
		 * Found in the "about" property.
		 * See also: FRIENDS_ABOUT_ME.
		 */
		public static const USER_ABOUT_ME:String = "user_about_me";
		/**
		 * Provides access to the "About Me" section of the user's friends' profiles.
		 * Found in the "about" property.
		 * See also: USER_ABOUT_ME.
		 */
		public static const FRIENDS_ABOUT_ME:String = "friends_about_me";
		/**
		 * Provides access to the user's list of activities.
		 * Found in the "activities" connection.
		 * See also: FRIENDS_ACTIVITIES.
		 */
		public static const USER_ACTIVITIES:String = "user_activities";
		/**
		 * Provides access to the user's friends' lists of activities.
		 * Found in the "activities" connection.
		 * See also: USER_ACTIVITIES.
		 */
		public static const FRIENDS_ACTIVITIES:String = "friends_activities";
		/**
		 * Provides access to the user's birthday.
		 * Found in the "birthday_date" property.
		 * See also FRIENDS_BIRTHDAY.
		 */
		public static const USER_BIRTHDAY:String = "user_birthday";
		/**
		 * Provides access to the user's friends' birthdays.
		 * Found in the "birthday_date" property.
		 * See also USER_BIRTHDAY.
		 */
		public static const FRIENDS_BIRTHDAY:String = "friends_birthday";
		/**
		 * Provides access to the user's education history.
		 * Found in the "education" property.
		 * See also FRIENDS_EDUCATION_HISTORY.
		 */
		public static const USER_EDUCATION_HISTORY:String = "user_education_history";
		/**
		 * Provides access to the user's friends education histories.
		 * Found in the "education" property.
		 * See also USER_EDUCATION_HISTORY.
		 */
		public static const FRIENDS_EDUCATION_HISTORY:String = "friends_education_history";
		/**
		 * Provides access to the list of events that the user is attending.
		 * Found in the "events" connection.
		 * See also FRIENDS_EVENTS.
		 */
		public static const USER_EVENTS:String = "user_events";
		/**
		 * Provides access to the list of events that the users' friends are attending.
		 * Found in the "events" connection.
		 * See also USER_EVENTS.
		 */
		public static const FRIENDS_EVENTS:String = "friends_events";
		/**
		 * Provides access to the list of groups that the user is a member of.
		 * Found in the "groups" connection.
		 * See also FRIENDS_GROUPS.
		 */
		public static const USER_GROUPS:String = "user_groups";
		/**
		 * Provides access to the list of groups that the users' friends are members of.
		 * Found in the "groups" connection.
		 * See also USER_GROUPS.
		 */
		public static const FRIENDS_GROUPS:String = "friends_groups";
		/**
		 * Provides access to the user's hometown.
		 * Found in the "hometown" property.
		 * See also FRIENDS_HOMETOWN.
		 */
		public static const USER_HOMETOWN:String = "user_hometown";
		/**
		 * Provides access to the user's friends' hometowns.
		 * Found in the "hometown" property.
		 * See also USER_HOMETOWN.
		 */
		public static const FRIENDS_HOMETOWN:String = "friends_hometown";
		/**
		 * Provides access to the user's list of interests.
		 * Found in the "interests" connection.
		 * See also FRIENDS_INTERESTS.
		 */
		public static const USER_INTERESTS:String = "user_interests";
		/**
		 * Provides access to the user's friends' lists of interests.
		 * Found in the "interests" connection.
		 * See also USER_INTERESTS.
		 */
		public static const FRIENDS_INTERESTS:String = "friends_interests";
		/**
		 * Provides access to the list of all the pages that the user has liked.
		 * Found in the "likes" connection.
		 * See also FRIENDS_LIKES.
		 */
		public static const USER_LIKES:String = "user_likes";
		/**
		 * Provides access to the list of all the pages that the users' friends have liked.
		 * Found in the "likes" connection.
		 * See also USER_LIKES.
		 */
		public static const FRIENDS_LIKES:String = "friends_likes";
		/**
		 * Provides access to the user's current location.
		 * Found in the "location" property.
		 * See also FRIENDS_LOCATION.
		 */
		public static const USER_LOCATION:String = "user_location";
		/**
		 * Provides access to the user's friends' current locations.
		 * Found in the "location" property.
		 * See also USER_LOCATION.
		 */
		public static const FRIENDS_LOCATION:String = "friends_location";
		/**
		 * Provides access to the user's notes.
		 * Found in the "notes" connection.
		 * See also FRIENDS_NOTES.
		 */
		public static const USER_NOTES:String = "user_notes";
		/**
		 * Provides access to the user's friends' notes.
		 * Found in the "notes" connection.
		 * See also USER_NOTES.
		 */
		public static const FRIENDS_NOTES:String = "friends_notes";
		/**
		 * Provides access to the user's online/offline presence.
		 * See also FRIENDS_ONLINE_PRESENCE.
		 */
		public static const USER_ONLINE_PRESENCE:String = "user_online_presence";
		/**
		 * Provides access to the user's friends' online/offline presence.
		 * See also USER_ONLINE_PRESENCE.
		 */
		public static const FRIENDS_ONLINE_PRESENCE:String = "friends_online_presence";
		/**
		 * Provides access to the photos and videos that the user has been tagged in.
		 * Found in the "photos" connection and the "videos" connection.
		 * See also FRIENDS_PHOTO_VIDEO_TAGS.
		 */
		public static const USER_PHOTO_VIDEO_TAGS:String = "user_photo_video_tags";
		/**
		 * Provides access to the photos and videos that the user's friends have been tagged in.
		 * Found in the "photos" connection and the "videos" connection.
		 * See also USER_PHOTO_VIDEO_TAGS.
		 */
		public static const FRIENDS_PHOTO_VIDEO_TAGS:String = "friends_photo_video_tags";
		/**
		 * Provides access to the photos that the user has uploaded.
		 * See also FRIENDS_PHOTOS.
		 */
		public static const USER_PHOTOS:String = "user_photos";
		/**
		 * Provides access to the photos that the user has uploaded.
		 * See also USER_PHOTOS.
		 */
		public static const FRIENDS_PHOTOS:String = "friends_photos";
		/**
		 * Provides access to the user's family and personal relationships, and their relationship status.
		 * See also FRIENDS_RELATIONSHIPS.
		 */
		public static const USER_RELATIONSHIPS:String = "user_relationships";
		/**
		 * Provides access to the user's friends' family and personal relationships, and their relationship statuses.
		 * See also USER_RELATIONSHIPS.
		 */
		public static const FRIENDS_RELATIONSHIPS:String = "friends_relationships";
		/**
		 * Provides access to the user's relationship preferences.
		 * See also FRIENDS_RELATIONSHIP_DETAILS.
		 */
		public static const USER_RELATIONSHIP_DETAILS:String = "user_relationship_details";
		/**
		 * Provides access to the user's friends' relationship preferences.
		 * See also USER_RELATIONSHIP_DETAILS.
		 */
		public static const FRIENDS_RELATIONSHIP_DETAILS:String = "friends_relationship_details";
		/**
		 * Provides access to the user's religious and political affiliations.
		 * See also FRIENDS_RELIGION_POLITICS.
		 */
		public static const USER_RELIGION_POLITICS:String = "user_religion_politics";
		/**
		 * Provides access to the user's religious and political affiliations.
		 * See also USER_RELIGION_POLITICS.
		 */
		public static const FRIENDS_RELIGION_POLITICS:String = "friends_religion_politics";
		/**
		 * Provides access to the user's most recent status message.
		 * See also FRIENDS_STATUS.
		 */
		public static const USER_STATUS:String = "user_status";
		/**
		 * Provides access to the user's most recent status message.
		 * See also USER_STATUS.
		 */
		public static const FRIENDS_STATUS:String = "friends_status";
		/**
		 * Provides access to the videos that the user has uploaded.
		 * Found in the "videos" connection.
		 * See also FRIENDS_VIDEOS.
		 */
		public static const USER_VIDEOS:String = "user_videos";
		/**
		 * Provides access to the videos that the user's friends have uploaded.
		 * Found in the "videos" connection.
		 * See also USER_VIDEOS.
		 */
		public static const FRIENDS_VIDEOS:String = "friends_videos";
		/**
		 * Provides access to the user's website URL.
		 * See also FRIENDS_WEBSITE.
		 */
		public static const USER_WEBSITE:String = "user_website";
		/**
		 * Provides access to the user's friends' website URLs.
		 * See also USER_WEBSITE.
		 */
		public static const FRIENDS_WEBSITE:String = "friends_website";
		/**
		 * Provides access to the user's work history.
		 * Found in the "work" property.
		 * See also FRIENDS_WORK_HISTORY.
		 */
		public static const USER_WORK_HISTORY:String = "user_work_history";
		/**
		 * Provides access to the user's work history.
		 * Found in the "work" property.
		 * See also USER_WORK_HISTORY.
		 */
		public static const FRIENDS_WORK_HISTORY:String = "friends_work_history";
		/**
		 * Provides access to the user's primary email address.
		 * Found in the "email" property.
		 */
		public static const EMAIL:String = "email";
		/**
		 * Provides read access to the user's friend lists.
		 * Note: you can always find a list of all the user's friends using the "friends" connection.
		 */
		public static const READ_FRIENDLISTS:String = "read_friendlists";
		/**
		 * Provides read access to the Insights data for pages, applications, and domains that the user owns.
		 */
		public static const READ_INSIGHTS:String = "read_insights";
		/**
		 * Provides read access to the user's Facebook Inbox.
		 * You must apply for the inbox API whitelist before you can prompt for this permission.
		 * Apply here: http://www.facebook.com/help/contact.php?show_form=inbox_api_whitelist
		 */
		public static const READ_MAILBOX:String = "read_mailbox";
		/**
		 * Provides read access to the user's friend requests.
		 */
		public static const READ_REQUESTS:String = "read_requests";
		/**
		 * Provides read access to all the posts in the user's News Feed.
		 * Also allows application to perform searches against the user's News Feed.
		 */
		public static const READ_STREAM:String = "read_stream";
		/**
		 * Provides applications that integrate with Facebook Chat the ability to log users in.
		 */
		public static const XMPP_LOGIN:String = "xmpp_login";
		/**
		 * Provides the ability to manage ads and call the Facebook Ads API on the user's behalf.
		 */
		public static const ADS_MANAGEMENT:String = "ads_management";
		/**
		 * Provides read access to the user's check-ins.
		 * See also FRIENDS_CHECKINS.
		 */
		public static const USER_CHECKINS:String = "user_checkins";
		/**
		 * Provides read access to friends' check-ins that the user can see.
		 * See also USER_CHECKINS.
		 */
		public static const FRIENDS_CHECKINS:String = "friends_checkins";
		/**
		 * Enables application to retrieve access tokens for pages that the user administrates.
		 * The access tokens can be queried using the "accounts" connection.
		 */
		public static const MANAGE_PAGES:String = "manage_pages";
		
		public function ExtendedPermissions()
		{
			
		}
		
	}

}