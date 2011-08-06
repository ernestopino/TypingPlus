package ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import graph.controls.GraphListRenderer;
	import graph.controls.GraphObjectRenderer;
	import graph.GraphList;
	import graph.GraphObject;
	
	public class GraphControlContainer extends Sprite
	{
		private var _lineContainer:Sprite;
		private var _rendererContainer:Sprite;
		public var _glrs:Array = [];
		public var _gors:Array = [];
		
		public function GraphControlContainer()
		{
			_lineContainer = new Sprite();
			_rendererContainer = new Sprite();
			
			addChild(_lineContainer);
			addChild(_rendererContainer);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(a_event:Event):void
		{
			renderLines();
		}
		
		public function markAsNotPoppedOut(a_graphObjectID:String):void
		{
			for each (var glr:GraphListRenderer in _glrs)
			{
				glr.markAsNotPoppedOut(a_graphObjectID);
			}
		}
		
		public function markAsPoppedOut(a_graphObjectID:String):void
		{
			for each (var glr:GraphListRenderer in _glrs)
			{
				glr.markAsPoppedOut(a_graphObjectID);
			}
		}
		
		private function renderLines():void
		{
			_lineContainer.graphics.clear();
			var currentList:Array;
			var from:Point;
			var to:Point;
			
			for each (var glr:GraphListRenderer in _glrs)
			{
				currentList = glr.glist.list;
				for each (var gor:GraphObjectRenderer in _gors)
				{
					for each (var go:GraphObject in currentList)
					{
						if (go.id == gor.graphObject.id)
						{
							from = _lineContainer.globalToLocal(gor.anchorPointGlobal);
							to = _lineContainer.globalToLocal(glr.anchorPointGlobal);
							
							_lineContainer.graphics.lineStyle(1.0, 0xbbbbbb);
							_lineContainer.graphics.moveTo(from.x, from.y);
							_lineContainer.graphics.lineTo(to.x, to.y);
						}
					}
					if (gor.graphObject.id == glr.glist.ownerID)
					{
						from = _lineContainer.globalToLocal(glr.anchorPointGlobal);
						to = _lineContainer.globalToLocal(gor.anchorPointGlobal);
						
						_lineContainer.graphics.lineStyle(3.0, 0x000000);
						_lineContainer.graphics.moveTo(from.x, from.y);
						_lineContainer.graphics.lineTo(to.x, to.y);
					}
				}
			}
		}
		
		public function addListRenderer(a_renderer:GraphListRenderer):void
		{
			_rendererContainer.addChild(a_renderer);
			_glrs.push(a_renderer);
			a_renderer.addEventListener(MouseEvent.CLICK, onMouseDownRenderer);
			
			for each (var gor:GraphObjectRenderer in _gors)
			{
				if (gor.graphObject.id == a_renderer.glist.ownerID)
				{
					a_renderer.x = gor.x + (gor.width * 1.3);
					a_renderer.y = gor.y + (gor.height * 1.8 * (Math.random() - 0.5));
				}
			}
		}
		
		public function addObjectRenderer(a_renderer:GraphObjectRenderer):void
		{
			_rendererContainer.addChild(a_renderer);
			_gors.push(a_renderer);
			a_renderer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownRenderer);
			
			var currentList:Array;
			for each (var glr:GraphListRenderer in _glrs)
			{
				currentList = glr.glist.list;
				for each (var go:GraphObject in currentList)
				{
					if (go.id == a_renderer.graphObject.id)
					{
						a_renderer.x = glr.x + (glr.width * 1.3);
						a_renderer.y = glr.y + (glr.height * 1.8 * (Math.random() - 0.5));
					}
				}
			}
		}
		
		public function removeListRenderer(a_renderer:GraphListRenderer):void
		{
			if (a_renderer.parent == _rendererContainer)
			{
				_rendererContainer.removeChild(a_renderer);
				a_renderer.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownRenderer);
				_glrs.splice(_glrs.indexOf(a_renderer), 1);
				a_renderer.visible = false;		//FIXME: why can we still see it, anyway?
				renderLines();
			}
		}
		
		public function removeObjectRenderer(a_renderer:GraphObjectRenderer):void
		{
			if (a_renderer.parent == _rendererContainer)
			{
				_rendererContainer.removeChild(a_renderer);
				a_renderer.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownRenderer);
				_gors.splice(_gors.indexOf(a_renderer), 1);
				renderLines();
			}
		}
		
		private function onMouseDownRenderer(a_event:MouseEvent):void
		{
			//doesn't work on MOUSE_DOWN all the time like one would expect
			//I think some code in the MinimalComps is interrupting the bubbling of the events. No big deal.
			_rendererContainer.addChild(a_event.currentTarget as DisplayObject);	//bring it to the top
		}
		
	}

}