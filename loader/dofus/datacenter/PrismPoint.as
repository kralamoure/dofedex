class dofus.datacenter.PrismPoint extends Object
{
	function PrismPoint(§\x0b\x13§, cost, attackNear)
	{
		super();
		this.api = _global.API;
		this._nMapId = var3;
		this._nCost = cost;
		this._atkNear = attackNear;
	}
	function __get__cost()
	{
		return this._nCost;
	}
	function __get__mapID()
	{
		return this._nMapId;
	}
	function __get__attackNear()
	{
		return this._atkNear;
	}
	function __get__coordinates()
	{
		return this.x + ", " + this.y;
	}
	function __get__x()
	{
		return this.api.lang.getMapText(this._nMapId).x;
	}
	function __get__y()
	{
		return this.api.lang.getMapText(this._nMapId).y;
	}
	function __get__name()
	{
		var var2 = Number(this.api.lang.getMapText(this._nMapId).sa);
		return String(this.api.lang.getMapSubAreaText(var2).n).substr(0,2) != "//"?this.api.lang.getMapSubAreaText(var2).n:String(this.api.lang.getMapSubAreaText(var2).n).substr(2);
	}
}
