class dofus.datacenter.Datacenter extends Object
{
	function Datacenter(§\x1e\x1a\x16§)
	{
		super();
		this.initialize(var3);
	}
	function initialize(§\x1e\x1a\x16§)
	{
		this._oAPI = var2;
		this.Player = new dofus.datacenter.(var2);
		this.Basics = new dofus.datacenter.Basics();
		this.Challenges = new ank.utils.	();
		this.Sprites = new ank.utils.	();
		this.Houses = new ank.utils.	();
		this.Storages = new ank.utils.	();
		this.Game = new dofus.datacenter.Game();
		this.Conquest = new dofus.datacenter.Conquest();
		this.Subareas = new ank.utils.	();
		this.Map = new dofus.datacenter.();
		this.Temporary = new Object();
	}
	function clear()
	{
		this.Player = new dofus.datacenter.(this._oAPI);
		this.Basics.initialize();
		this.Challenges = new ank.utils.	();
		this.Sprites = new ank.utils.	();
		this.Houses = new ank.utils.	();
		this.Storages = new ank.utils.	();
		this.Game = new dofus.datacenter.Game();
		this.Conquest = new dofus.datacenter.Conquest();
		this.Subareas = new ank.utils.	();
		this.Map = new dofus.datacenter.();
		this.Temporary = new Object();
		delete this.Exchange;
	}
	function clearGame()
	{
		this.Game = new dofus.datacenter.Game();
	}
}
