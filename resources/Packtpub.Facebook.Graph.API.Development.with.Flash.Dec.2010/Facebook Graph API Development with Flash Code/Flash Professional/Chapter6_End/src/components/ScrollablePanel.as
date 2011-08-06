package components
{
	import com.bit101.components.Panel;
	import com.bit101.components.VScrollBar;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class ScrollablePanel extends Panel
	{
		protected var _vScrollBar:VScrollBar;
		protected var _prevContentHeight:Number;
		protected var _scrollEventHandler:Function;
		
		public function ScrollablePanel(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, hasVScrollbar:Boolean = true)
		{
			super(parent, xpos, ypos);
			
			if (hasVScrollbar)
			{
				_vScrollBar = new VScrollBar(this, this.width, 0, onScroll);
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
				_vScrollBar.maximum = this.content.height - this.height;	//don't go too far past the end
				_vScrollBar.value = -this.content.y;
				_vScrollBar.setThumbPercent(_vScrollBar.pageSize / this.content.height);
			}
		}
		
		private function resizeScrollBar():void
		{
			if (_vScrollBar)
			{
				_vScrollBar.x = this.width - _vScrollBar.width;
				_vScrollBar.height = this.height - this.height;
				_vScrollBar.minimum = 0;
				_vScrollBar.pageSize = this.height - this.height;
				_vScrollBar.lineSize = 3;
			}
		}
		
		protected function onScroll(a_event:Event):void
		{
			this.content.y = -_vScrollBar.value;
			if (_scrollEventHandler != null)
			{
				_scrollEventHandler(a_event);
			}
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
		
		public function updateScrollbar():void
		{
			setScrollbarThumb();
		}
		
		override public function get height():Number
		{
			return super.height;
		}
		
		override public function set height(a_value:Number):void
		{
			super.height = a_value;
			_vScrollBar.height = this.height;
		}
		
		override public function get width():Number
		{
			return super.width;
		}
		
		override public function set width(a_value:Number):void
		{
			super.width = a_value;
			_vScrollBar.x = width - _vScrollBar.width;
		}
		
		public function setScrollEventHandler(a_handler:Function):void
		{
			_scrollEventHandler = a_handler;
		}
		
		public function get scrollValue():Number
		{
			return _vScrollBar.value;
		}
		
		public function get scrollMaximum():Number
		{
			return _vScrollBar.maximum;
		}
	}

}