﻿package com.mobile.ggc{	import flash.events.Event;	public class PlayerEvent extends Event 	{		// Event types.				public static const EVENT_DEFAULT:String = "default";		public static const PLAYERS_BUILT:String = "playersBuilt";		public static const DECISION:String = "decision"; // decision on individual cards		public static const VOTE:String = "vote"; //vote on group issue		public static const HIT_ME:String = "hitMe";		public static const VIEW_CHANGED:String = "viewChanged"; 		public var data:*;						public function PlayerEvent(type:String = PlayerEvent.EVENT_DEFAULT, bubbles:Boolean = false, cancelable:Boolean = false, _data:* = null) 		{			data = _data;			super(type, bubbles, cancelable);		} 		override public function clone():Event {			// Return a new instance of this event with the same parameters.			return new PlayerEvent(type, bubbles, cancelable, data);		}	}}