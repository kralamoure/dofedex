class dofus.managers.NightManager
{
	static var STATE_COLORS = [undefined,dofus.Constants.NIGHT_COLOR];
	static var _sSelf = null;
	function NightManager(§\x1e\x1a\x15§)
	{
		dofus.managers.NightManager._sSelf = this;
		this._oApi = var2;
	}
	function __get__time()
	{
		var var2 = this.getCurrentTime();
		if(new ank.utils.(var2[1]).addLeftChar("0",2) == "undefined")
		{
			return "";
		}
		return new ank.utils.(var2[0]).addLeftChar("0",2) + ":" + new ank.utils.(var2[1]).addLeftChar("0",2);
	}
	function __get__date()
	{
		return this.getCurrentDateString();
	}
	function initialize(§\x1e\n\x1a§, §\x1e\x07§, §\x1e\x1b\x03§, §\x1d\x03§)
	{
		this._aSequence = var2;
		this._aMonths = var3;
		this._nYearOffset = var4;
		this._mcBattlefield = var5;
	}
	function setReferenceTime(§\x1e\x1c\b§)
	{
		this._cdDate = new ank.utils.(var2,this._aMonths,this._nYearOffset);
		this.clear();
	}
	function setReferenceDate(§\x1e\x1b\x04§, §\x02\x18§, §\x06\x1c§)
	{
		this._nYear = var2;
		this._nMonth = var3;
		this._nDay = var4;
	}
	function clear()
	{
		_global.clearInterval(this._nIntervalID);
	}
	function noEffects()
	{
		this.clear();
		this._mcBattlefield.setColor();
	}
	function getCurrentTime()
	{
		return this._cdDate.getCurrentTime();
	}
	function getCurrentDateString()
	{
		var var2 = this._cdDate.getCurrentDate();
		if(getTimer() - this._oApi.datacenter.Basics.lastDateUpdate > 60000)
		{
			this._oApi.network.Basics.getDate();
		}
		var var3 = this._nYear == undefined?var2[2] + " " + var2[1] + " " + var2[0]:this._nDay + " " + this._aMonths[11 - this._nMonth][1] + " " + this._nYear;
		return var3;
	}
	function getDiffDate(§\x1e\x1c\r§)
	{
		return this._cdDate.getDiffDate(var2);
	}
	static function getInstance()
	{
		return dofus.managers.NightManager._sSelf;
	}
	function setState()
	{
		var var2 = this._cdDate.getCurrentMillisInDay();
		var var3 = 0;
		while(var3 < this._aSequence.length)
		{
			var var4 = this._aSequence[var3][1];
			if(var2 < var4)
			{
				var var5 = this._aSequence[var3][2];
				this.applyState(var5,var4 - var2,var4);
				return undefined;
			}
			var3 = var3 + 1;
		}
		ank.utils.Logger.err("[setState] ... heu la date " + var2 + " n\'est pas dans la séquence");
	}
	function applyState(§\x1e\x17\x1c§, §\x06\x18§, §\x06\x04§)
	{
		this._mcBattlefield.setColor(var2);
		this.clear();
		this._nIntervalID = _global.setInterval(this,"setState",var3,var4);
	}
}
