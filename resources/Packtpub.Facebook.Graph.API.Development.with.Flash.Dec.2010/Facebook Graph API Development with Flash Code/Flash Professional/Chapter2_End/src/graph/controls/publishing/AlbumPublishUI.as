package graph.controls.publishing
{
	import com.bit101.components.InputText;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import com.bit101.components.Window;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import graph.apis.base.PublishObject;
	
	public class AlbumPublishUI extends PublishUI
	{
		protected var _nameLabel:Label;
		protected var _nameInput:InputText;
		protected var _descriptionLabel:Label;
		protected var _descriptionInput:TextArea;
		
		public function AlbumPublishUI(a_parent:DisplayObjectContainer = null, a_xpos:Number = 0, a_ypos:Number = 0, a_ownerID:String = "", a_connectionType:String = "")
		{
			super(a_parent, a_xpos, a_ypos, a_ownerID, a_connectionType, "Create an Album");
			
			this.width = 240;
			this.height = 300;
			
			_nameLabel = new Label(this.content, PADDING, PADDING, "Name:");
			_nameInput = new InputText(this.content, PADDING, _nameLabel.y + _nameLabel.height);
			_nameInput.width = this.width - (2 * PADDING);

			_descriptionLabel = new Label(this.content, PADDING, _nameInput.y + _nameInput.height, "Description:");
			_descriptionInput = new TextArea(this.content, PADDING, _descriptionLabel.y + _descriptionLabel.height);
			_descriptionInput.width = this.width - (2 * PADDING);
			_descriptionInput.height *= 0.4;
			
			_postButton.x = _descriptionInput.x + _descriptionInput.width - _postButton.width;
			_postButton.y = _descriptionInput.y + PADDING + _descriptionInput.height;
			
			setHeightByPostButton();
		}
		
		override protected function onClickPostButton(a_event:Event):void
		{
			_publishObject.name = _nameInput.text;
			_publishObject.description = _descriptionInput.text;
			
			super.onClickPostButton(a_event);
		}
		
	}

}