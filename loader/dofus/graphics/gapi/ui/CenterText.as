class dofus.graphics.gapi.ui.CenterText extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "CenterText";
	var _sText = "";
	var _bBackground = false;
	var _nTimer = 0;
	function CenterText()
	{
		super();
	}
	function __set__text(var2)
	{
		this._sText = var2;
		return this.__get__text();
	}
	function __set__background(var2)
	{
		this._bBackground = var2;
		return this.__get__background();
	}
	function __set__timer(var2)
	{
		this._nTimer = var2;
		return this.__get__timer();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.CenterText.CLASS_NAME);
	}
	function createChildren()
	{
		if(this._sText.length == 0)
		{
			return undefined;
		}
		this.addToQueue({object:this,method:this.initText});
		this._mcBackground._visible = false;
		this._prgbGfxLoad._visible = false;
		if(this._nTimer != 0)
		{
			ank.utils.Timer.setTimer(this,"centertext",this,this.unloadThis,this._nTimer);
		}
	}
	function initText()
	{
		this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this._sText;
		var var2 = this._lblWhite.textHeight;
		this._mcBackground._visible = this._bBackground;
		this._mcBackground._height = var2 + 2.5 * (this._lblWhite._y - this._mcBackground._y);
	}
	function updateProgressBar(var2, var3, var4)
	{
		var var5 = Math.floor(var3 / var4 * 100);
		if(_global.isNaN(var5))
		{
			var5 = 0;
		}
		this._prgbGfxLoad._visible = true;
		this._prgbGfxLoad["\x1e\n\x11"].text = var2;
		this._prgbGfxLoad["\x1e\n\x10"].text = var5 + "%";
		this._prgbGfxLoad["\n\x12"]._width = var5;
	}
}
