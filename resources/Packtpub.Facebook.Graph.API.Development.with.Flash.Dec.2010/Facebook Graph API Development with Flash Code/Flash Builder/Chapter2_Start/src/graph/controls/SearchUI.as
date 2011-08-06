package graph.controls
{
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.RadioButton;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SearchUI extends Window
	{
		protected static const PADDING:Number = 10;
		
		protected var _termLabel:Label;
		protected var _termInput:InputText;
		protected var _typeLabel:Label;
		protected var _userRadio:RadioButton;
		protected var _pageRadio:RadioButton;
		protected var _eventRadio:RadioButton;
		protected var _groupRadio:RadioButton;
		protected var _postRadio:RadioButton;
		protected var _checkinRadio:RadioButton;
		protected var _newsFeedRadio:RadioButton;
		protected var _friendPostsRadio:RadioButton;
		protected var _friendNameInput:InputText;
		protected var _searchButton:PushButton;
		protected var _searchCallback:Function;
		
		public function SearchUI(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0, a_title:String = "Search")
		{
			super(a_parent, a_xpos, a_ypos, a_title);
			this.width = 240;
			this.height = 300;
			this.hasCloseButton = true;
			
			_termLabel = new Label(this.content, PADDING, PADDING, "Query:");
			_termInput = new InputText(this.content, PADDING, _termLabel.y + _termLabel.height);
			_termInput.width = this.width - (2 * PADDING);
			
			_typeLabel = new Label(this.content, PADDING, _termInput.y + _termInput.height + PADDING, "Type:");
			_userRadio = new RadioButton(this.content, PADDING, _typeLabel.y + _typeLabel.height + PADDING, "User", true);
			_pageRadio = new RadioButton(this.content, PADDING, _userRadio.y + _userRadio.height + PADDING, "Page", true);
			_eventRadio = new RadioButton(this.content, PADDING, _pageRadio.y + _pageRadio.height + PADDING, "Event", true);
			_groupRadio = new RadioButton(this.content, PADDING, _eventRadio.y + _eventRadio.height + PADDING, "Group", true);
			_postRadio = new RadioButton(this.content, PADDING, _groupRadio.y + _groupRadio.height + PADDING, "Public Post", true);
			_checkinRadio = new RadioButton(this.content, PADDING, _postRadio.y + _postRadio.height + PADDING, "Checkin", true);
			_newsFeedRadio = new RadioButton(this.content, PADDING, _checkinRadio.y + _checkinRadio.height + PADDING, "My News Feed", true);
			_friendPostsRadio = new RadioButton(this.content, PADDING, _newsFeedRadio.y + _newsFeedRadio.height + PADDING, "Friend's Posts:", true);
			_friendNameInput = new InputText(this.content, PADDING, _friendPostsRadio.y + _friendPostsRadio.height + PADDING);
			
			_userRadio.groupName = _pageRadio.groupName = _eventRadio.groupName = _groupRadio.groupName = _postRadio.groupName = _checkinRadio.groupName = _newsFeedRadio.groupName = _friendPostsRadio.groupName = "Type";
			_userRadio.selected = true;
			
			_friendNameInput.width = this.width - (2 * PADDING);
			
			_searchButton = new PushButton(this.content, 0, _friendNameInput.y + _friendNameInput.height + PADDING, "Search", onClickSearch);
			_searchButton.x = this.width - PADDING - _searchButton.width;
			
			this.height = this.titleBar.height + _searchButton.y + _searchButton.height + PADDING;
		}
		
		private function onClickSearch(a_event:Event):void
		{
			var query:String = _termInput.text;
			var type:String;
			if (_userRadio.selected) type = "user";
			if (_pageRadio.selected) type = "page";
			if (_eventRadio.selected) type = "event";
			if (_groupRadio.selected) type = "group";
			if (_checkinRadio.selected) type = "checkin";
			if (_postRadio.selected) type = "post";
			if (_newsFeedRadio.selected) type = "home";
			if (_friendPostsRadio.selected) type = "feed";
			var userID:String = _friendNameInput.text;
			
			if (_searchCallback != null)
			{
				_searchCallback(query, type, userID);
			}
		}
		
		public function setSearchCallback(a_callback:Function):void
		{
			_searchCallback = a_callback;
		}
		
		override protected function onClose(event:MouseEvent):void
		{
			super.onClose(event);
			this.visible = false;
		}
	}

}