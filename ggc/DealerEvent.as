﻿package com.mobile.ggc{	import flash.events.Event;	public class DealerEvent extends Event 	{		// Event types.				public static const EVENT_DEFAULT:String = "default";		public static const CARDS_DEALT:String = "cardsDealt"; // Cards dealt to ACTIVE player for decision		public static const ISSUE_DEALT:String = "issueDealt"; // Issue Dealt to ALL Players for group decision 		public var cardViews:*;				public function DealerEvent(type:String = DealerEvent.EVENT_DEFAULT, bubbles:Boolean = false, cancelable:Boolean = false, _data:* = null) 		{			cardViews = _data;			super(type, bubbles, cancelable);		} 		override public function clone():Event {			// Return a new instance of this event with the same parameters.			return new DealerEvent(type, bubbles, cancelable);		}	}}