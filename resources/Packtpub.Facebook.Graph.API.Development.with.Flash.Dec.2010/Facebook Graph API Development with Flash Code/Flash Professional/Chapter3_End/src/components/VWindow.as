package components
{
	import com.bit101.components.VScrollBar;
	import com.bit101.components.Window;
	import events.GCEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class VWindow extends Window
	{
		protected var _vScrollBar:VScrollBar;
		protected var _prevContentHeight:Number;
		
		public function VWindow(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, title:String = "Window", hasVScrollbar:Boolean = false)
		{
			super(parent, xpos, ypos, title);
			this.addEventListener(Event.RESIZE, onResize);
			
			if (hasVScrollbar)
			{
				_vScrollBar = new VScrollBar(this, this.width, this.titleBar.height, onScroll);
				resizeScrollBar();
				setScrollbarThumb();
				this.content.addEventListener(Event.ADDED, onAddContent);
				this.content.addEventListener(Event.RESIZE, onContentResize);
				this.content.addEventListener(Event.CHANGE, onContentChange);
				this.addEventListener(Event.ENTER_FRAME, onEnterFrameWithScrollbar);
			}
		}
		
		private function onEnterFrameWithScrollbar(a_event:Event):void
		{
			//FIXME: This is a hack. For some reason, I can't figure out what's changing content.height, so I'm using this to detect it.
			if (this.content.height != _prevContentHeight)
			{
				_prevContentHeight = this.content.height;
				setScrollbarThumb();
			}
		}
		
		private function onContentChange(a_event:Event):void
		{
			setScrollbarThumb();
		}
		
		private function onContentResize(a_event:Event):void
		{
			setScrollbarThumb();
		}
		
		private function onAddContent(a_event:Event):void
		{
			setScrollbarThumb();
		}
		
		private function onResize(a_event:Event):void
		{
			resizeScrollBar();
			setScrollbarThumb();
		}
		
		private function setScrollbarThumb():void
		{
			if (_vScrollBar)
			{
				_vScrollBar.maximum = this.content.height - (this.height - this._titleBar.height);	//don't go too far past the end
				_vScrollBar.value = -this.content.y;
				_vScrollBar.setThumbPercent(_vScrollBar.pageSize / this.content.height);
			}
		}
		
		private function resizeScrollBar():void
		{
			if (_vScrollBar)
			{
				_vScrollBar.x = this.width - _vScrollBar.width;
				_vScrollBar.height = this.height - this.titleBar.height;
				_vScrollBar.minimum = 0;
				_vScrollBar.pageSize = this.height - this._titleBar.height;
				_vScrollBar.lineSize = 3;
			}
		}
		
		protected function onScroll(a_event:Event):void
		{
			this.content.y = -_vScrollBar.value;
		}
		
		public function get contentWidth():Number
		{
			if (_vScrollBar)
			{
				return this.width - _vScrollBar.width;
			}
			else
			{
				return this.width;
			}
		}
		
		override protected function onClose(event:MouseEvent):void
		{
			super.onClose(event);
			dispatchEvent(new GCEvent(GCEvent.CLOSE_WINDOW));
		}
		
		public function updateScrollbar():void
		{
			setScrollbarThumb();
		}
		
	}

}