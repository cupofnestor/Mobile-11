﻿package com.mobile.GulfLinks {		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;		public class start extends MovieClip {						public function start() {			// constructor code			addEventListener(Event.ADDED_TO_STAGE, init);					}				public function init(e:Event):void		{			removeEventListener(Event.ADDED_TO_STAGE, init);			addEventListener(MouseEvent.MOUSE_DOWN, down);			addEventListener(MouseEvent.MOUSE_UP, up);			loading();		}				private function loading():void		{			this.gotoAndStop("loading");			this.addEventListener(Event.ENTER_FRAME, animate);		}				public function down(e:Event):void		{			this.gotoAndStop("down");		}				public function up(e:Event):void		{			this.gotoAndStop("up");			dispatchEvent(new Event("start"));		}				private function animate(e:Event):void		{			this.circ.rotation+=2;		}				public function loaded():void		{			this.gotoAndStop("up");			this.removeEventListener(Event.ENTER_FRAME, animate);		}	}	}