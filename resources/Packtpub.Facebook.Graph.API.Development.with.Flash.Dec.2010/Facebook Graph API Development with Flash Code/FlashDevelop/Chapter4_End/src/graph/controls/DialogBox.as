package graph.controls
{
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import components.VWindow;
	import events.GCEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	
	public class DialogBox extends VWindow
	{
		public static const WINDOW_WIDTH:Number = 300;
		public static const WINDOW_HEIGHT:Number = 200;
		
		protected static const PADDING:Number = 5;
		
		protected var _textArea:TextArea;
		protected var _okButton:PushButton;
		
		public function DialogBox(message:String = "", parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Dialog", hasVScrollbar:Boolean = false)
		{
			super(parent, xpos, ypos, title, hasVScrollbar);
			this.width = WINDOW_WIDTH;
			this.height = WINDOW_HEIGHT;
			_okButton = new PushButton(this.content, 0, 0, "OK");
			_okButton.x = this.width - (_okButton.width + PADDING);
			_okButton.y = this.height - (titleBar.height + _okButton.height + PADDING);
			_okButton.addEventListener(MouseEvent.CLICK, onClickOK);
			
			_textArea = new TextArea(this.content, PADDING, PADDING, message);
			_textArea.height = _okButton.y - PADDING - _textArea.y;
			_textArea.width = this.width - (2 * PADDING);
			
			this.hasCloseButton = true;
		}
		
		private function onClickOK(a_event:MouseEvent):void
		{
			dispatchEvent(new GCEvent(GCEvent.CLOSE_WINDOW));
		}
		
	}

}