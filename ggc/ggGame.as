﻿package com.mobile.ggc {	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.events.Event;	import flash.system.System;	public class ggGame {		private var ldr:URLLoader = new URLLoader();		public var players:ggPlayers;		private var dealer:ggDealer;				public function set gameFile(s:String):void		{			initialize();			ldr.addEventListener(Event.COMPLETE, cfgLoaded);			ldr.load(new URLRequest(s));		}				public function initialize():void		{			players = new ggPlayers();			dealer = new ggDealer();		}		private function cfgLoaded(e:Event):void{			ldr.removeEventListener(Event.COMPLETE, cfgLoaded);			configure(new XML(ldr.data));			ldr=null;		}		public function configure(cfg:XML):void		{			players.addEventListener(PlayerEvent.PLAYERS_BUILT, setRefs);			players.config = new XML(cfg.players);			dealer.config = new XML(cfg.dealer);									System.disposeXML(cfg);			cfg = null;		}				private function setRefs(e:Event):void		{			dealer.players = players;			players.dealer = dealer;						players.addEventListener(PlayerEvent.HIT_ME, hitTest);		}				public function hitTest(p:PlayerEvent):void		{			trace("hitTest");		}			}	}