package graph.controls
{
	import com.bit101.components.PushButton;
	import components.ScrollablePanel;
	import components.VWindow;
	import events.DialogEvent;
	import events.GCEvent;
	import events.PublishUIEvent;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import graph.controls.publishing.PublishingCapabilities;
	import graph.GraphList;
	import graph.GraphObject;
	
	public class GraphListRenderer extends VWindow
	{
		private static const WINDOW_WIDTH:Number = 240;
		private static const WINDOW_HEIGHT_REGULAR:Number = 240;
		private static const WINDOW_HEIGHT_EXPANDED:Number = 370;
		private static const BETWEEN_PANEL_PADDING:Number = 2;
		
		protected var _contentPanel:ScrollablePanel;
		protected var _detailsPanels:Object = { };
		protected var _detailsPanelsArray:Array = [];
		protected var _glist:GraphList;
		protected var _hasRequestedNewResults:Boolean = false;
		protected var _toggleFilterBar:ListFilterToggle;
		protected var _showFilterBar:Boolean = false;
		protected var _showCount:Boolean = false;
		protected var _publishingCapability:int = PublishingCapabilities.NONE;
		protected var _showDeleteButton:Boolean = false;
		protected var _filterPanel:FilterPanel;
		protected var _filterPanelIsShowing:Boolean = false;
		protected var _filterCallback:Function;
		protected var _deleteGraphObjectCallback:Function;
		protected var _publishButton:PushButton;
		
		public function GraphListRenderer(a_graphList:GraphList, a_x:Number = 0, a_y:Number = 0, a_parent:DisplayObjectContainer = null)
		{
			super(a_parent, a_x, a_y, "[List]", false);
			this.width = WINDOW_WIDTH;
			this.height = WINDOW_HEIGHT_REGULAR;
			this.hasCloseButton = true;
			_contentPanel = new ScrollablePanel(this.content, 0, 0, true);
			repositionContentPanel();
			_contentPanel.width = this.width;
			_contentPanel.setScrollEventHandler(onPanelScroll);
			
			_publishButton = new PushButton(this.content, 0, 0, "Publish", onClickPublishButton);
			_publishButton.visible = false;
			
			_glist = a_graphList;
			setTitleCaption();
			
			setUpWindowContents();
			renderData();
		}
		
		private function onClickPublishButton(a_event:Event):void
		{
			//somehow pass three bits of info to HUD:
			 //owner ID, connection type, publishcapability
			 dispatchEvent(new PublishUIEvent(PublishUIEvent.SHOW_UI, this._glist.ownerID, this._glist.connectionType, _publishingCapability));
		}
		
		private function setTitleCaption():void
		{
			var connectionTitleText:String = "";
			if (_glist)
			{
				if (_glist.connectionType)
				{
					connectionTitleText = _glist.connectionType.substr(0, 1).toUpperCase() + _glist.connectionType.substr(1) + " ";
				}
				title = connectionTitleText + "[List]";
				if (_showCount)
				{
					if (_glist.list)
					{
						title += " (" + _glist.list.length + ")";
					}
				}
			}
		}
		
		protected function onPanelScroll(a_event:Event):void
		{
			if (!_hasRequestedNewResults)
			{
				if (_contentPanel.scrollValue >= 0.85 * _contentPanel.scrollMaximum)
				{
					//dispatchEvent
					_hasRequestedNewResults = true;
				}
			}
		}
		
		public function markAsPoppedOut(a_graphObjectID:String):void
		{
			var dp:GraphObjectPanel = _detailsPanels[a_graphObjectID];
			if (dp)
			{
				dp.showPopOutButton = false;
			}
		}
		
		public function markAsNotPoppedOut(a_graphObjectID:String):void
		{
			var dp:GraphObjectPanel = _detailsPanels[a_graphObjectID];
			if (dp)
			{
				dp.showPopOutButton = true;
			}
		}
		
		private function renderData():void
		{
			_hasRequestedNewResults = false;
			var detailsPanel:GraphObjectPanel;
			for each (var go:GraphObject in _glist.list)
			{
				detailsPanel = new GraphObjectPanel(_contentPanel.content, 0, 0, go, true, _showDeleteButton);
				detailsPanel.ownerID = _glist.ownerID;
				detailsPanel.connectionType = _glist.connectionType;
				detailsPanel.width = _contentPanel.contentWidth;
				detailsPanel.height = this.height - this.titleBar.height;
				detailsPanel.deleteCallback = this._deleteGraphObjectCallback;
				_detailsPanels[go.id] = detailsPanel;
				if (_detailsPanelsArray.length > 0)
				{
					var prevPanel:GraphObjectPanel = _detailsPanelsArray[_detailsPanelsArray.length - 1] as GraphObjectPanel;
					detailsPanel.y = prevPanel.y + prevPanel.height + BETWEEN_PANEL_PADDING;
				}
				_detailsPanelsArray.push(detailsPanel);
				detailsPanel.addEventListener(Event.RESIZE, onPanelResize);
				
				go.graphObjectListRenderers.push(this);
			}
			this.updateScrollbar();
			setTitleCaption();
			if (_glist.connectionType == "" || _glist.ownerID == "")
			{
				showFilterBar = false;
			}
		}
		
		private function onPanelResize(a_event:Event):void
		{
			repositionPanelsFromIndex(_detailsPanelsArray.indexOf(a_event.target as GraphObjectPanel));
			this.updateScrollbar();
		}
		
		private function repositionPanelsFromIndex(a_index:int):void
		{
			for (var i:int = a_index; i < _detailsPanelsArray.length - 1; i++)
			{
				var prevPanel:GraphObjectPanel = _detailsPanelsArray[i] as GraphObjectPanel;
				var currPanel:GraphObjectPanel = _detailsPanelsArray[i+1] as GraphObjectPanel;
				currPanel.y = prevPanel.y + prevPanel.height + BETWEEN_PANEL_PADDING;
			}
		}
		
		private function setUpWindowContents():void
		{
			renderListFilter();
		}
		
		private function renderListFilter():void
		{
			if (_showFilterBar)
			{
				if (_toggleFilterBar)
				{
					_toggleFilterBar.visible = true;
				}
				else
				{
					_toggleFilterBar = new ListFilterToggle(this.content);
					_toggleFilterBar.addEventListener(GCEvent.TOGGLE_LIST_FILTER, onRequestToggleListFilter);
					_toggleFilterBar.width = this.width;
					_toggleFilterBar.y = _contentPanel.y + _contentPanel.height + BETWEEN_PANEL_PADDING - _toggleFilterBar.height;
					repositionContentPanel();
				}
				if (_filterPanel == null)
				{
					_filterPanel = new FilterPanel(this.content, 0, _toggleFilterBar.y + _toggleFilterBar.height);
					_filterPanel.width = this.width;
					_filterPanel.connectionID = this._glist.connectionType;
					_filterPanel.objectID = this._glist.ownerID;
					if (_filterCallback != null)
					{
						_filterPanel.setCallback(_filterCallback);
					}
					_filterPanel.height = WINDOW_HEIGHT_EXPANDED - WINDOW_HEIGHT_REGULAR;
				}
			}
			else
			{
				this.height = WINDOW_HEIGHT_REGULAR;
				_filterPanelIsShowing = false;
				if (_toggleFilterBar)
				{
					_toggleFilterBar.visible = false;
				}
				repositionContentPanel();
			}
		}
		
		private function repositionContentPanel():void
		{
			if (_publishingCapability)
			{
				_contentPanel.y = _publishButton.y + _publishButton.height;
			}
			else
			{
				_contentPanel.y = 0;
			}
			if (_showFilterBar)
			{
				_contentPanel.height = _toggleFilterBar.y - _contentPanel.y;
			}
			else
			{
				_contentPanel.height = this.height - (this.titleBar.height + _contentPanel.y);
			}
		}
		
		private function onRequestToggleListFilter(a_event:GCEvent):void
		{
			if (_filterPanelIsShowing)
			{
				this.height = WINDOW_HEIGHT_REGULAR;
			}
			else
			{
				this.height = WINDOW_HEIGHT_EXPANDED;
			}
			_filterPanelIsShowing = !_filterPanelIsShowing;
			_toggleFilterBar.toggleDisplay(_filterPanelIsShowing);
		}
		
		public function get glist():GraphList
		{
			return _glist;
		}
		
		/**
		 * The anchor point of any connection lines drawn
		 */
		public function get anchorPointGlobal():Point
		{
			if (!this.parent) return new Point(0, 0);
			
			return this.parent.localToGlobal(new Point(this.x + (0.5 * this.width), this.y + (0.5 * this.height)));
		}
		
		public function get showCount():Boolean
		{
			return _showCount;
		}
		
		public function set showCount(a_value:Boolean):void
		{
			_showCount = a_value;
			setTitleCaption();
		}
		
		public function set showFilterBar(a_value:Boolean):void
		{
			_showFilterBar = a_value;
			renderListFilter();
		}
		
		public function set filterCallback(a_value:Function):void
		{
			_filterCallback = a_value;
			if (_filterPanel)
			{
				_filterPanel.setCallback(_filterCallback);
			}
		}
		
		public function set deleteGraphObjectCallback(a_value:Function):void
		{
			_deleteGraphObjectCallback = a_value;
			for (var i:int = 0; i < _detailsPanelsArray.length; i++)
			{
				var currPanel:GraphObjectPanel = _detailsPanelsArray[i] as GraphObjectPanel;
				currPanel.deleteCallback = a_value;
			}
		}
		
		public function get publishingCapability():int
		{
			return _publishingCapability;
		}
		
		public function set publishingCapability(a_value:int):void
		{
			_publishingCapability = a_value;
			repositionContentPanel();
			renderPublishButton();
		}
		
		public function set showDeleteButton(a_value:Boolean):void
		{
			_showDeleteButton = a_value;
			for (var i:int = 0; i < _detailsPanelsArray.length; i++)
			{
				var currPanel:GraphObjectPanel = _detailsPanelsArray[i] as GraphObjectPanel;
				currPanel.showDeleteButton = a_value;
			}
		}
		
		private function renderPublishButton():void
		{
			if (_publishingCapability != PublishingCapabilities.NONE)
			{
				if (_glist.ownerID && _glist.connectionType)
				{
					_publishButton.visible = true;
				}
			}
			else
			{
				_publishButton.visible = false;
			}
		}
		
	}

}