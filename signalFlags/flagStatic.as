﻿package com.mobile.signalFlags {		import flash.display.MovieClip;			public class flagStatic extends MovieClip {				var _letter:String;		public function flagStatic() {			// constructor code		}				public function set letter(val:String):void		{			var flVal:String;			flVal = val.toLowerCase();			this.flag_mc.gotoAndStop(flVal);		}					}	}