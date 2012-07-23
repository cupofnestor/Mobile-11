﻿package com.mobile.ggc {	import flash.system.System;	import flash.events.EventDispatcher;	import flash.events.Event;	public class ggDealer extends EventDispatcher{		var decks:ggDeck = new ggDeck;		var firstname:String; //This is a dummy variable		//var activePlayer:Player // need to keep track of active player here???		var _players:Object = {};		var thePlayers:ggPlayers;		var currentPlayerName:String = "";				//Config First		public function set config(cfg:XML):void		{			//set local config vars			firstname = cfg.firstname.toString(); //this is dummy var			decks.config = new XML(cfg.deck);  //setup decks depending on cfg xml						//allow for garbagecollection of XML after passing to decks.			System.disposeXML(cfg);			cfg = null;		}				//Players Second		public function set players(_p:ggPlayers):void		{			thePlayers = _p;			decks.players = thePlayers.toObject();			thePlayers.addEventListener(PlayerEvent.HIT_ME, dealTwo); //Players will request deal depending on game phase		}								//Player wants two cards.		private function dealTwo(e:PlayerEvent):void		{			currentPlayerName = e.data;			var currentPlayer:basePlayer = thePlayers.playerRef(currentPlayerName);			currentPlayer.addEventListener(PlayerEvent.DECISION, playerChoice);			decks.addEventListener(DeckEvent.PULLED, cardPulled);			decks.drawTwo(currentPlayerName); //ask deck for cards		}								private function cardPulled(d:DeckEvent):void //deck returns cards.		{			decks.removeEventListener(DeckEvent.PULLED, cardPulled);			dispatchEvent(new DealerEvent(DealerEvent.CARDS_DEALT, false, false, d.cards))		}				public function playerChoice(e:PlayerEvent):void //player chooses card/action e.data is the *HAND* id of chosen card		{			var chosenID:Number = e.data;			var cP:basePlayer = e.currentTarget as basePlayer;			cP.removeEventListener(PlayerEvent.DECISION, playerChoice);									decks.discard(cP.team, chosenID);			decks.drop(cP.team, (chosenID+1)%2);			var uId:Number = cP.view[chosenID].uId;			dealIssue(uId);		}				//Players must be dealt issue for vote.		private function dealIssue(uId:Number):void		{			decks.addEventListener(DeckEvent.PULLED, issuePulled);			decks.drawIssue(uId); //ask deck for issue		}				private function issuePulled(d:DeckEvent):void		{			decks.removeEventListener(DeckEvent.PULLED, issuePulled);			dispatchEvent(new DealerEvent(DealerEvent.ISSUE_DEALT, true, false, d.cards))					}			}	}