class dofus.graphics.gapi.ui.PayZone extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "PayZone";
	function PayZone()
	{
		super();
	}
	function __set__dialogID(§\x06\x16§)
	{
		this._nDialogID = var2;
		return this.__get__dialogID();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.PayZone.CLASS_NAME);
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		if(this.api.datacenter.Basics.payzone_isFirst)
		{
			this.gapi.loadUIComponent("PayZoneDialog2","PayZoneDialog2",{name:"El Pemy",gfx:"9059",dialogID:this._nDialogID});
		}
	}
	function addListeners()
	{
		this._btnInfos.addEventListener("click",this);
	}
	function click(§\x1e\x19\x18§)
	{
		this.gapi.loadUIComponent("PayZoneDialog2","PayZoneDialog2",{name:"El Pemy",gfx:"9059",dialogID:this._nDialogID});
	}
}
