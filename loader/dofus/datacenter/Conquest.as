class dofus.datacenter.Conquest extends Object
{
	function Conquest()
	{
		super();
		this.clear();
		mx.events.EventDispatcher.initialize(this);
	}
	function clear()
	{
		this._eaPlayers = new ank.utils.
();
		this._eaAttackers = new ank.utils.
();
	}
	function __get__alignBonus()
	{
		return this._cbdAlignBonus;
	}
	function __set__alignBonus(§\x13\x12§)
	{
		this._cbdAlignBonus = var2;
		this.dispatchEvent({type:"bonusChanged"});
		return this.__get__alignBonus();
	}
	function __get__alignMalus()
	{
		return this._cbdAlignMalus;
	}
	function __set__alignMalus(§\x13\x12§)
	{
		this._cbdAlignMalus = var2;
		this.dispatchEvent({type:"bonusChanged"});
		return this.__get__alignMalus();
	}
	function __get__rankMultiplicator()
	{
		return this._cbdRankMultiplicator;
	}
	function __set__rankMultiplicator(§\x13\x12§)
	{
		this._cbdRankMultiplicator = var2;
		this.dispatchEvent({type:"bonusChanged"});
		return this.__get__rankMultiplicator();
	}
	function __get__players()
	{
		return this._eaPlayers;
	}
	function __set__players(§\x1e\n\x0f§)
	{
		this._eaPlayers = var2;
		return this.__get__players();
	}
	function __get__attackers()
	{
		return this._eaAttackers;
	}
	function __set__attackers(§\x1e\n\x0f§)
	{
		this._eaAttackers = var2;
		return this.__get__attackers();
	}
	function __get__worldDatas()
	{
		return this._cwdDatas;
	}
	function __set__worldDatas(§\x1e\n\x0f§)
	{
		this._cwdDatas = var2;
		this.dispatchEvent({type:"worldDataChanged",value:var2});
		return this.__get__worldDatas();
	}
}
