﻿package  com.mobile.GulfLinks {			import flash.events.*;	public class delItem extends delBody {		public var tag:String="";		public var freq:Number;		public function delItem():void		{			super();			this.addEventListener(Event.ADDED_TO_STAGE, init)		}		public function init(e:Event):void		{			this.tagName.text = tag;		}				public function set _tag(val:String):void		{			//set textfield with tagname			tag = val;					}				public function set _freq(val:Number):void		{			//set ?color ?relationships ?size from frequency			freq = val;		}					}	}