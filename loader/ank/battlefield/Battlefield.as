class ank.battlefield.Battlefield extends MovieClip
{
	var _bJumpActivate = false;
	static var FRAMELOADTIMOUT = 500;
	var _bUseCustomGroundGfxFile = false;
	var bGhostView = false;
	var bCustomFileLoaded = false;
	function Battlefield()
	{
		super();
	}
	function __get__isMapBuild()
	{
		if(this._bMapBuild)
		{
			return true;
		}
		ank.utils.Logger.err("[isMapBuild] Carte non chargée");
		return false;
	}
	function __set__screenWidth(var2)
	{
		this._nScreenWidth = var2;
		return this.__get__screenWidth();
	}
	function __get__screenWidth()
	{
		return this._nScreenWidth != undefined?this._nScreenWidth:ank.battlefield.Constants.DISPLAY_WIDTH;
	}
	function __set__screenHeight(var2)
	{
		this._nScreenHeight = var2;
		return this.__get__screenHeight();
	}
	function __get__screenHeight()
	{
		return this._nScreenHeight != undefined?this._nScreenHeight:ank.battlefield.Constants.DISPLAY_HEIGHT;
	}
	function __set__isJumpActivate(var2)
	{
		this._bJumpActivate = var2;
		return this.__get__isJumpActivate();
	}
	function __get__isJumpActivate()
	{
		return this._bJumpActivate;
	}
	function __get__container()
	{
		return this._mcMainContainer;
	}
	function __get__isContainerVisible()
	{
		return this._mcMainContainer._visible;
	}
	function __get__datacenter()
	{
		return this._oDatacenter;
	}
	function initialize(var2, var3, var4, var5)
	{
		this._oDatacenter = var2;
		this._sGroundFile = var3;
		if(!this.initializeDatacenter())
		{
			ank.utils.Logger.err("BattleField -> Init datacenter impossible");
			this.onInitError();
		}
		ank.utils.Extensions.addExtensions();
		if(_global.GAC == undefined)
		{
			_global.GAC = new ank.battlefield.
();
			_global.GAC.setAccessoriesRoot(var5);
		}
		this.attachClassMovie(ank.battlefield.mc.Container,"_mcMainContainer",10,[this,this._oDatacenter,var4]);
		this._bMapBuild = false;
		this.loadManager = new ank.battlefield.LoadManager(this.createEmptyMovieClip("LoadManager",this.getNextHighestDepth()));
	}
	function setStreaming(var2, var3, var4)
	{
		ank.battlefield.Constants.USE_STREAMING_FILES = var2;
		ank.battlefield.Constants.STREAMING_OBJECTS_DIR = var3;
		ank.battlefield.Constants.STREAMING_GROUNDS_DIR = var4;
	}
	function setStreamingMethod(var2)
	{
		ank.battlefield.Constants.STREAMING_METHOD = var2;
	}
	function setCustomGfxFile(var2, var3)
	{
		if(var2 && (var2 != "" && this._sGroundFile != var2))
		{
			this._sGroundFile = var2;
			this._bUseCustomGroundGfxFile = true;
			this.bCustomFileLoaded = false;
		}
		if(var3 && (var3 != "" && this._sObjectFile != var3))
		{
			this._mcMainContainer.initialize(this._mcMainContainer,this._oDatacenter,var3);
			this.bCustomFileLoaded = false;
			this._sObjectFile = var3;
		}
	}
	function activateTacticMode(var2)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.tacticMode(var2);
	}
	function clear()
	{
		this._mcMainContainer.clear();
		this._sGroundFile = "";
		this._sObjectFile = "";
		ank.utils.Timer.clear("battlefield");
		ank.utils.CyclicTimer.getInstance().clear();
		this.initializeDatacenter();
		this.createHandlers();
		this._bMapBuild = false;
	}
	function setColor(var2)
	{
		this._mcMainContainer.setColor(var2);
	}
	function cleanMap(nPermanentLevel, §\x18\x06§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(nPermanentLevel == undefined)
		{
			nPermanentLevel = Number.POSITIVE_INFINITY;
		}
		else
		{
			nPermanentLevel = Number(nPermanentLevel);
		}
		this.mapHandler.initializeMap(nPermanentLevel);
		this.unSelect(true);
		this.clearAllZones();
		this.clearPointer();
		this.removeGrid();
		this.clearAllSprites(var3);
		this.overHeadHandler.clear();
		this.textHandler.clear();
		this.pointsHandler.clear();
		ank.utils.Timer.clean();
		ank.utils.CyclicTimer.getInstance().clear();
	}
	function getZoom()
	{
		return this._mcMainContainer.getZoom();
	}
	function showContainer(var2)
	{
		this._mcMainContainer._visible = var2;
	}
	function zoom(var2)
	{
		this._mcMainContainer.zoom(var2);
	}
	function buildMapFromObject(var2, var3)
	{
		this.clear();
		if(var2 == undefined)
		{
			return undefined;
		}
		this.onMapBuilding();
		this.mapHandler.build(var2,undefined,var3);
		if(this.mapHandler.LoaderRequestLeft == 0)
		{
			this.DispatchMapLoaded();
		}
		else
		{
			this._nFrameLoadTimeOut = ank.battlefield.Battlefield.FRAMELOADTIMOUT;
			this.onEnterFrame = function()
			{
				ref._nFrameLoadTimeOut--;
				if(ref._nFrameLoadTimeOut <= 0 || ref.mapHandler.LoaderRequestLeft <= 0)
				{
					delete ref.onEnterFrame;
					ref.DispatchMapLoaded();
				}
			};
		}
	}
	function DispatchMapLoaded()
	{
		this._bMapBuild = true;
		this.onMapLoaded();
	}
	function buildMap(var2, var3, var4, var5, var6, var7, var8, var9)
	{
		if(var8 == undefined)
		{
			var8 = new ank.battlefield.datacenter.Map();
		}
		ank.battlefield.utils.Compressor.uncompressMap(var2,var3,var4,var5,var6,var7,var8,var9);
		this.buildMapFromObject(var8,var9);
	}
	function updateCell(§\x07\x11§, §\x1e\x13\x14§, §\x1e\x10\x05§, nPermanentLevel)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(var3 == undefined)
		{
			this.mapHandler.initializeCell(var2,Number.POSITIVE_INFINITY,true);
		}
		else
		{
			var var6 = ank.battlefield.utils.Compressor.uncompressCell(var3,true);
			this.mapHandler.updateCell(var2,var6,var4,nPermanentLevel);
		}
	}
	function setObject2Frame(var2, var3)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.setObject2Frame(var2,var3);
	}
	function setObject2Interactive(§\x07\x11§, §\x18\x17§, nPermanentLevel)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.setObject2Interactive(var2,var3,nPermanentLevel);
	}
	function updateCellObjectExternalWithExternalClip(var2, var3, var4, var5, var6, var7)
	{
		var var8 = new ank.battlefield.datacenter.
();
		var8.layerObjectExternal = var3;
		var8.layerObjectExternalInteractive = var5 != undefined?var5:true;
		var8.layerObjectExternalAutoSize = var6;
		var8.layerObjectExternalData = var7;
		this.mapHandler.updateCell(var2,var8,"1C000",nPermanentLevel);
	}
	function setObjectExternalFrame(var2, var3)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.setObjectExternalFrame(var2,var3);
	}
	function initializeCell(§\x07\x11§, nPermanentLevel)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.mapHandler.initializeCell(var2,nPermanentLevel);
	}
	function select(var2, var3, var4, var5)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(typeof var2 == "object")
		{
			this.selectionHandler.selectMultiple(true,var2,var3,var4,var5);
		}
		else if(typeof var2 == "number")
		{
			this.selectionHandler.select(true,var2,var3,var4,var5);
		}
	}
	function unSelect(var2, var3, var4)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(var2)
		{
			this.selectionHandler.clear();
		}
		else if(typeof var3 == "object")
		{
			this.selectionHandler.selectMultiple(false,var3,undefined,var4);
		}
		else if(typeof var3 == "number")
		{
			this.selectionHandler.select(false,var3,undefined,var4);
		}
		else if(var4 != undefined)
		{
			this.selectionHandler.clearLayer(var4);
		}
	}
	function unSelectAllButOne(var2)
	{
		var var3 = this.selectionHandler.getLayers();
		var var4 = 0;
		while(var4 < var3.length)
		{
			if(var3[var4] != var2)
			{
				this.selectionHandler.clearLayer(var3[var4]);
			}
			var4 = var4 + 1;
		}
	}
	function setInteraction(var2)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.interactionHandler.setEnabled(var2);
	}
	function setInteractionOnCell(var2, var3)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.interactionHandler.setEnabledCell(var2,var3);
	}
	function setInteractionOnCells(var2, var3)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		§§enumerate(var2);
		while((var var0 = §§enumeration()) != null)
		{
			this.interactionHandler.setEnabledCell(var2[k],var3);
		}
	}
	function drawZone(var2, var3, var4, var5, var6, var7)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.drawZone(var2,var3,var4,var5,var6,var7);
	}
	function clearZone(var2, var3, var4)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.clearZone(var2,var3,var4);
	}
	function clearZoneLayer(var2)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.clearZoneLayer(var2);
	}
	function clearAllZones(var2)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.zoneHandler.clear();
	}
	function clearPointer(var2)
	{
		this.pointerHandler.clear();
	}
	function hidePointer(var2)
	{
		this.pointerHandler.hide();
	}
	function addPointerShape(var2, var3, var4, var5)
	{
		this.pointerHandler.addShape(var2,var3,var4,var5);
	}
	function drawPointer(var2)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.pointerHandler.draw(var2);
	}
	function getSprite(sID)
	{
		return this.spriteHandler.getSprite(sID);
	}
	function getSprites()
	{
		return this.spriteHandler.getSprites();
	}
	function addSprite(sID, spriteData)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.addSprite(sID,spriteData);
	}
	function addLinkedSprite(sID, §\x1e\x0f\x05§, §\x07\x03§, oSprite)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.addLinkedSprite(sID,var3,var4,oSprite);
	}
	function carriedSprite(sID, §\x1e\x0f\x05§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.carriedSprite(sID,var3);
	}
	function removeEffectsByCasterID(sCasterID)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.removeEffectsByCasterID(sCasterID);
	}
	function uncarriedSprite(sID, §\x07\x11§, §\x13\x16§, §\x1e\x17\x1c§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.uncarriedSprite(sID,var3,var4,var5);
	}
	function mountSprite(sID, §\x1e\x18\x14§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.mountSprite(sID,var3);
	}
	function unmountSprite(sID)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.unmountSprite(sID);
	}
	function clearAllSprites(var2)
	{
		this.spriteHandler.clear(var2);
	}
	function removeSprite(sID, §\x18\x06§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.removeSprite(sID,var3);
	}
	function hideSprite(sID, §\x16\x18§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.hideSprite(sID,var3);
	}
	function setSpritePosition(sID, §\x07\x11§, §\x10\x1d§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpritePosition(sID,var3,var4);
	}
	function setSpriteDirection(sID, §\x06\x07§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteDirection(sID,var3);
	}
	function stopSpriteMove(sID, §\x1e\x17\x1c§, §\x07\x11§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.stopSpriteMove(sID,var3,var4);
	}
	function moveSprite(sID, §\x12\x0e§, §\x1e\x17\x1c§, §\x1b\x0e§, §\x19\x17§, §\x19\x16§, §\x1e\x1d\x1d§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		var var9 = ank.battlefield.utils.Compressor.extractFullPath(this.mapHandler,var3);
		this.moveSpriteWithUncompressedPath(sID,var9,var4,var5,var6,var7,var8);
	}
	function moveSpriteWithUncompressedPath(sID, §\x1d\x1c§, §\x1e\x17\x1c§, §\x1b\x0e§, §\x19\x17§, §\x19\x16§, §\x1e\x1d\x1d§, §\x1e\x14\x16§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(var3 != undefined)
		{
			this.spriteHandler.moveSprite(sID,var3,var4,var5,var9,var6,var7,var8);
		}
	}
	function slideSprite(sID, §\x07\x11§, §\x1e\x17\x1c§, §\x1e\x14\x16§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.slideSprite(sID,var3,var4,var5);
	}
	function autoCalculateSpriteDirection(sID, §\x07\x11§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.autoCalculateSpriteDirection(sID,var3);
	}
	function convertHeightToFourSpriteDirection(sID)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.convertHeightToFourSpriteDirection(sID);
	}
	function setForcedSpriteAnim(sID, §\x1e\x14\x17§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteAnim(sID,var3,true);
	}
	function setSpriteAnim(sID, §\x1e\x14\x17§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteAnim(sID,var3);
	}
	function setSpriteLoopAnim(sID, §\x1e\x14\x17§, §\x1e\x1b\x1a§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteLoopAnim(sID,var3,var4);
	}
	function setSpriteTimerAnim(sID, §\x1e\x14\x17§, §\x19\x19§, §\x1e\x1b\x1a§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteTimerAnim(sID,var3,var4,var5);
	}
	function setSpriteGfx(sID, §\x1e\x12\x0b§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteGfx(sID,var3);
	}
	function setSpriteColorTransform(sID, §\x1e\x17\x0e§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteColorTransform(sID,var3);
	}
	function setSpriteAlpha(sID, §\b\x19§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.setSpriteAlpha(sID,var3);
	}
	function spriteLaunchVisualEffect(sID, §\x1e\x19\x11§, §\x07\x11§, §\x06\x02§, §\t\x0b§, §\x1e\f\x1b§, §\x1e\x17\x13§, §\x19\x0e§, §\x1c\x01§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.launchVisualEffect(sID,var3,var4,var5,var6,var7,var8,var9,var10);
	}
	function spriteLaunchCarriedSprite(sID, §\x1e\x19\x11§, §\x07\x11§, §\x06\x02§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.launchCarriedSprite(sID,var3,var4,var5);
	}
	function selectSprite(sID, §\x15\x16§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.spriteHandler.selectSprite(sID,var3);
	}
	function addSpriteBubble(sID, §\x1e\f\x12§, §\x1e\x1b\x13§)
	{
		var var5 = this._oDatacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[addSpriteBubble] Sprite inexistant (sprite Id : " + sID + ")");
			return undefined;
		}
		if(var5.isInMove)
		{
			return undefined;
		}
		if(!var5.isVisible)
		{
			return undefined;
		}
		var var6 = var5.mc;
		var var7 = var6._x;
		var var8 = var6._y;
		if(var4 == undefined)
		{
			var4 = ank.battlefield.TextHandler.BUBBLE_TYPE_CHAT;
		}
		if(var7 == 0 || var8 == 0)
		{
			ank.utils.Logger.err("[addSpriteBubble] le sprite n\'est pas encore placé");
			return undefined;
		}
		this.textHandler.addBubble(sID,var7,var8,var3,var4);
	}
	function removeSpriteBubble(sID)
	{
		var var3 = this._oDatacenter.Sprites.getItemAt(sID);
		if(var3 == undefined)
		{
			return undefined;
		}
		this.textHandler.removeBubble(sID);
	}
	function addSpritePoints(sID, §\x1e\x0b\x19§, §\x06\x1d§)
	{
		var var5 = this._oDatacenter.Sprites.getItemAt(sID);
		if(var5 == undefined)
		{
			ank.utils.Logger.err("[addSpritePoints] Sprite inexistant");
			return undefined;
		}
		if(!var5.isVisible)
		{
			return undefined;
		}
		var var6 = var5.mc;
		var var7 = var6._x;
		var var8 = var6._y - ank.battlefield.Constants.DEFAULT_SPRITE_HEIGHT;
		if(var7 == 0 || var8 == 0)
		{
			ank.utils.Logger.err("[addSpritePoints] le sprite n\'est pas encore placé");
			return undefined;
		}
		this.pointsHandler.addPoints(sID,var7,var8,var3,var4);
	}
	function addSpriteOverHeadItem(sID, §\x1e\x10\x13§, className, §\x17§, §\x06\x0b§, §\x1a\n§)
	{
		var var8 = this._oDatacenter.Sprites.getItemAt(sID);
		if(var8 == undefined)
		{
			ank.utils.Logger.err("[addSpriteOverHeadItem] Sprite inexistant");
			return undefined;
		}
		if(var8.isInMove && !var7)
		{
			return undefined;
		}
		if(!var8.isVisible)
		{
			return undefined;
		}
		var var9 = var8.mc;
		this.overHeadHandler.addOverHeadItem(sID,var9._x,var9._y,var9,var3,className,var5,var6);
	}
	function removeSpriteOverHeadLayer(sID, §\x1e\x10\x13§)
	{
		this.overHeadHandler.removeOverHeadLayer(sID,var3);
	}
	function hideSpriteOverHead(sID)
	{
		this.overHeadHandler.removeOverHead(sID);
	}
	function addSpriteExtraClipOnTimer(sID, §\x1e\x12\x0b§, §\x06\x1d§, §\x14\r§, §\x05\x19§)
	{
		this.addSpriteExtraClip(sID,var3,var4,var5);
		var var7 = new Object();
		var7.timerId = _global.setInterval(this,"removeSpriteExtraClipOnTimer",var6,var7,sID,var5);
	}
	function removeSpriteExtraClipOnTimer(var2, var3, var4)
	{
		_global.clearInterval(var2.timerId);
		this.removeSpriteExtraClip(sID,var4);
	}
	function addSpriteExtraClip(sID, §\x1e\x12\x0b§, §\x06\x1d§, §\x14\r§)
	{
		this.spriteHandler.addSpriteExtraClip(sID,var3,var4,var5);
	}
	function removeSpriteExtraClip(sID, §\x14\r§)
	{
		this.spriteHandler.removeSpriteExtraClip(sID,var3);
	}
	function showSpritePoints(sID, §\x1e\x1b\n§, §\x06\x1d§)
	{
		this.spriteHandler.showSpritePoints(sID,var3,var4);
	}
	function setSpriteGhostView(var2)
	{
		this.bGhostView = var2;
		this.spriteHandler.setSpriteGhostView(var2);
	}
	function setSpriteScale(sID, §\x1e\x1d\x19§, §\x1e\x1d\x18§)
	{
		this.spriteHandler.setSpriteScale(sID,var3,var4);
	}
	function drawGrid(var2)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		if(this.gridHandler.bGridVisible)
		{
			this.removeGrid();
		}
		else
		{
			this.gridHandler.draw(var2);
		}
	}
	function removeGrid(var2)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		this.gridHandler.clear();
	}
	function addVisualEffectOnSprite(sID, §\x1e\x19\x11§, §\x07\x11§, §\x06\x02§, §\x1e\f\x1b§)
	{
		if(!this.isMapBuild)
		{
			return undefined;
		}
		var var7 = this._oDatacenter.Sprites.getItemAt(sID);
		var var8 = this._oDatacenter.Sprites.getItemAt(var6);
		this.visualEffectHandler.addEffect(var7,var3,var4,var5,var8);
	}
	function initializeDatacenter(var2)
	{
		if(this._oDatacenter == undefined)
		{
			return false;
		}
		this._oDatacenter.Map.cleanSpritesOn();
		this._oDatacenter.Map = new ank.battlefield.datacenter.Map();
		this._oDatacenter.Sprites = new ank.utils.();
		return true;
	}
	function createHandlers(var2)
	{
		this.mapHandler = new ank.battlefield.(this,this._mcMainContainer,this._oDatacenter);
		this.spriteHandler = new ank.battlefield.
(this,this._mcMainContainer.ExternalContainer.Object2,this._oDatacenter.Sprites);
		this.interactionHandler = new ank.battlefield.(this._mcMainContainer.ExternalContainer.InteractionCell,this._oDatacenter);
		this.zoneHandler = new ank.battlefield.	(this,this._mcMainContainer.ExternalContainer.Zone);
		this.pointerHandler = new ank.battlefield.(this,this._mcMainContainer.ExternalContainer.Pointer);
		this.selectionHandler = new ank.battlefield.(this,this._mcMainContainer.ExternalContainer,this._oDatacenter);
		this.gridHandler = new ank.battlefield.
(this._mcMainContainer.ExternalContainer.Grid,this._oDatacenter);
		this.visualEffectHandler = new ank.battlefield.	(this,this._mcMainContainer.ExternalContainer.Object2);
		this.textHandler = new ank.battlefield.(this,this._mcMainContainer.Text,this._oDatacenter);
		this.pointsHandler = new ank.battlefield.(this,this._mcMainContainer.Points,this._oDatacenter);
		this.overHeadHandler = new ank.battlefield.(this,this._mcMainContainer.OverHead);
	}
	function onLoadInit(var2)
	{
		if((var var0 = var2._name) !== "Ground")
		{
			var2.__proto__ = ank.battlefield.mc.ExternalContainer.prototype;
			var2.initialize(this._sGroundFile);
			this.createHandlers();
		}
		else
		{
			var2._parent.useCustomGroundGfxFile(this._bUseCustomGroundGfxFile);
			this.bCustomFileLoaded = true;
			this.onInitComplete();
		}
	}
	function onLoadError(var2)
	{
		this.onInitError();
	}
	function onLoadProgress(var2, var3, var4)
	{
		this.onInitProgress(var3,var4);
	}
}
