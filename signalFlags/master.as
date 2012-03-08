﻿package com.mobile.signalFlags {		import flash.display.MovieClip;	import flash.events.KeyboardEvent;	import flash.events.Event;	import flash.display.BitmapData;	import flash.display.DisplayObject;	import flash.utils.getQualifiedClassName;	import flash.utils.getDefinitionByName;	import flash.net.URLRequest;	import flash.net.URLLoader;	import flash.display.Screen;	import flash.display.NativeWindowSystemChrome;	import flash.display.StageScaleMode;	import flash.display.StageAlign;	import flash.display.NativeWindow;	import flash.desktop.NativeApplication;		import flash.system.System;	//remove	public class master extends MovieClip {		private var mailPage:mail_page;		public var config:XML;		public var messages:Object = {};		var keyboardActive:Boolean=true;		var painting:ship;		var mess:paper;		var card:finished_card;		var dict:dictionary;		var flipCard:shipFlip;		var app:NativeApplication = NativeApplication.nativeApplication;		var window:NativeWindow;		public function master() {			getConfig();					}						public  function init(e:Event):void		{		}				private function demo()		{			stage.scaleMode = StageScaleMode.NO_BORDER;			stage.align = StageAlign.TOP_LEFT;			stage.nativeWindow.alwaysInFront = true;			stage.nativeWindow.x = 0;			stage.nativeWindow.y = 0;			var main:Screen = Screen.mainScreen;			stage.nativeWindow.width = main.visibleBounds.width;			stage.nativeWindow.height = main.visibleBounds.width*0.5625; 		}				 			//ADD to kiosk2.as		private function getConfig()			{				//var _cfg:XML = new XML("<root><section as3class=\"dictionary\"><a>woot</a><b>food</b></section><bar>toos</bar></root>");				//var _cfg:XML;				var req:URLRequest = new URLRequest("config.xml");				var ldr:URLLoader = new URLLoader();				ldr.load(req);				ldr.addEventListener(Event.COMPLETE, configLoaded);			}					private function  configLoaded(e:Event):void			{				config = new XML(e.target.data);				postConfig();			} 					private function postConfig():void{			this.addEventListener("getConfig", configHandler);			//this.fullOffX = config.kiosk.@offX;			prepAttract();			setupMail();			setupMessages();					}				private function setupMessages():void		{			messages.messageComplete = config.messages.messageComplete			messages.messageMode = config.messages.messageMode								}				private function setupMail():void		{			mailPage = new mail_page();			mailPage.config = new XML(config.section.(@as3class == "mailPage"))		}				//ADD to kiosk2.as		private function configHandler(e:Event):void		{			//Get full classname i.e.  com.mobile.signalFlags::dictionary			var clName:String = getQualifiedClassName(e.target);			//create class to reference 			var objClass:Class = Class(getDefinitionByName(clName));   						//shorten className to reference XML;			var attName:String = clName.split("::")[1];						//create link to Event target based on ref class			var obj = e.target as objClass;						//Find appropriate config section for localized config of target.						obj.cfg = new XML(config.section.(@as3class == attName));						//System.disposeXML(config);			//config = null;					}				//Creates instance of ship painting with animation/sound and adds listeners for key interrupt		private function prepAttract():void		{						demo();						dict = new dictionary();			addChild(dict);			painting = new ship();			addChildAt(painting,0);			attract();			//mess = painting.paperMessage("","Press \"Explore the Flags\" [x] or \"Send a Message\" [m] to begin \r \r",2000, false);			//mess = painting.paperMessage("","Press \"Explore the Flags\" [x] or \"Send a Message\" [m] to begin \r \r",2000, false);		}								private function attract():void		{						trace("::ATTRACT::");			painting.dim = 0;			painting.sailsAreActive = true;			stage.addEventListener(KeyboardEvent.KEY_DOWN, chooseMode);			//mess = painting.paperMessage("","Press \"Explore the Flags\" [x] or \"Send a Message\" [m] to begin \r \r",2000, false);			//mess = painting.paperMessage("","Press \"Explore the Flags\" [x] or \"Send a Message\" [m] to begin \r \r",2000, false);			stage.focus = stage;		}				private function chooseMode(k:KeyboardEvent):void		{						trace("CHOOSING MODE:: "+k.charCode);			 ( k.charCode == 120 ) ? dictionaryMode() : ( k.charCode == 109 ) ? messageMode() : null;		}				private function dictionaryMode():void		{			stage.removeEventListener(KeyboardEvent.KEY_DOWN, chooseMode);			painting.kbActive = false;			dict.kbActive = true;						dict.addEventListener("exit", dictExitHandler);			painting.sailsAreActive = false;			painting.dim = 1;			dict.go();			//painting = null;		}								private function dictExitHandler(e:Event):void		{			attract();		}						private function messageMode():void		{			stage.removeEventListener(KeyboardEvent.KEY_DOWN, chooseMode);			painting.directions = messages.messageMode;			//wait for any key to activate the message creation			//stage.addEventListener(KeyboardEvent.KEY_DOWN, paintingActive);			//wait for exit message to be sent for reset						painting.addEventListener("exit", exitHandler);			//wait for message complete						painting.addEventListener("messageComplete", messageCompleteHandler );			//changed so that ship will add/remove listeners itself			painting.kbActive = true;					}				//activates message creation via key events on painting.		private function paintingActive(k:KeyboardEvent):void		{			stage.removeEventListener(KeyboardEvent.KEY_DOWN, paintingActive);			painting.addEventListener("exit", exitHandler);			mess.off();						//wait for message complete						painting.addEventListener("messageComplete", messageCompleteHandler );			//changed so that ship will add/remove listeners itself			painting.kbActive = true;		}								//visitor has decided their message is complete, looks for confirmation to "submit" the message		private function messageCompleteHandler(e:Event):void		{			painting.removeEventListener("messageComplete", messageCompleteHandler );			mess = painting.paperMessage(messages.messageComplete,99000,false);			//any key will submit the message			stage.addEventListener(KeyboardEvent.KEY_DOWN, submitMessage);		}						//Clears the message box from ship, and waits to build the image to submit.		private function submitMessage(e:Event):void		{			stage.removeEventListener(KeyboardEvent.KEY_DOWN, submitMessage);			//once the message is off, make the card.			mess.addEventListener("paperOff", getEmail);			mess.off();			painting.instructPaper.off();		}				private function getEmail(e:Event):void		{			painting.kbActive = false;			painting.sailsAreActive = false;			painting.dim = 1;			mess.removeEventListener("paperOff", getEmail);			/*var mailPage:mail_page = new mail_page();			mailPage.addEventListener("mailComplete", mailCompleteHandler);			var mailCfg:XML = new XML(config.section.(@as3class == "mailPage"))			mailPage.config = mailCfg;*/ 			mailPage.addEventListener("mailComplete", mailCompleteHandler);			addChild(mailPage);					}						private function mailCompleteHandler(e:Event):void		{			removeChild(e.target as MovieClip);			painting.resetShip();			attract();					}				//makes an image of user's card for email/posting		/*private function makeCard(e:Event):void		{						mess.removeEventListener("paperOff", makeCard);			stage.removeEventListener(KeyboardEvent.KEY_DOWN, paintingKeyDownHandler);			mess = null;			//create new instance of the ship/flip card payoff			flipCard = new shipFlip(painting.snap());			addChild(flipCard);			//flipCard.y=540;			//for preview only.			mess = painting.paperMessage(config.messages.theEnd,99000,false);			stage.addEventListener(KeyboardEvent.KEY_DOWN, TMPresetHandler);		}				//Temporary reset method		public function TMPresetHandler(e:KeyboardEvent):void		{			stage.removeEventListener(KeyboardEvent.KEY_DOWN, TMPresetHandler);			//trace("::MAIN:: TMPresetHandler::"+e);								(e.charCode == 9) ? exitHandler(e) : stage.addEventListener(KeyboardEvent.KEY_DOWN, TMPresetHandler);;							}*/				private function exitHandler(e:Event):void		{			//remove completed message, exit, and keydown handler			painting.removeEventListener("messageComplete", messageCompleteHandler );			painting.removeEventListener("exit", exitHandler);			//remove flipCard preview if present			(this.flipCard != null ) ? removeChild(flipCard) : null;			//painting = null;			//flipCard = null;			painting.resetShip();			attract();		}				//clears the card/flip payoff		private function killCard(e:Event):void		{			removeChild(card);			card = null;					}									}	}