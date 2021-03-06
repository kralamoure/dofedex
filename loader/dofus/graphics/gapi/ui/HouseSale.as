class dofus.graphics.gapi.ui.HouseSale extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "HouseSale";
	function HouseSale()
	{
		super();
	}
	function __set__house(var2)
	{
		this._oHouse = var2;
		return this.__get__house();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.HouseSale.CLASS_NAME);
	}
	function callClose()
	{
		this.api.network.Houses.leave();
		return true;
	}
	function createChildren()
	{
		this.addToQueue({object:this,method:this.addListeners});
		this.addToQueue({object:this,method:this.initData});
		this.addToQueue({object:this,method:this.initTexts});
		this._btnCancel._visible = false;
		this._txtPrice.tabIndex = 0;
		this._txtPrice.restrict = "0-9";
		this._txtPrice.onSetFocus = function()
		{
			this._parent.onSetFocus();
		};
		this._txtPrice.onKillFocus = function()
		{
			this._parent.onKillFocus();
		};
	}
	function addListeners()
	{
		this._btnCancel.addEventListener("click",this);
		this._btnValidate.addEventListener("click",this);
		this._btnClose.addEventListener("click",this);
		this.api.kernel.KeyManager.addShortcutsListener("onShortcut",this);
	}
	function initData()
	{
		if(this._oHouse == undefined)
		{
			return undefined;
		}
		this._txtDescription.text = this._oHouse.name + "\n\n" + this._oHouse.description;
		if(this._oHouse.localOwner)
		{
			this._txtPrice.text = this._oHouse.price;
			this._btnCancel._visible = this._oHouse.price != 0;
			this._mcPrice._visible = true;
			Selection.setFocus(this._txtPrice);
		}
		else
		{
			this._txtPrice.text = this.getFormattedPrice();
			this._txtPrice.editable = false;
			this._txtPrice.selectable = false;
			this._mcPrice._visible = false;
		}
	}
	function initTexts()
	{
		this._lblPrice.text = this.api.lang.getText("PRICE") + " :";
		if(this._oHouse.localOwner)
		{
			this._winBackground.title = this.api.lang.getText("HOUSE_SALE");
			this._btnCancel.label = this.api.lang.getText("CANCEL_THE_SALE");
			this._btnValidate.label = this.api.lang.getText("VALIDATE");
		}
		else
		{
			this._winBackground.title = this.api.lang.getText("HOUSE_PURCHASE");
			this._btnValidate.label = this.api.lang.getText("BUY");
		}
	}
	function onShortcut(var2)
	{
		if(var2 == "ACCEPT_CURRENT_DIALOG" && eval(Selection.getFocus())._name == "_txtPrice")
		{
			this.click({target:this._btnValidate});
			return false;
		}
		return true;
	}
	function click(var2)
	{
		switch(var2.target._name)
		{
			case "_btnCancel":
				if(this._oHouse.localOwner)
				{
					this.api.network.Houses.sell(0);
				}
				break;
			case "_btnValidate":
				if(this._oHouse.localOwner)
				{
					this.api.network.Houses.sell(Number(this._txtPrice.text));
				}
				else
				{
					if(this._oHouse.price <= 0)
					{
						return undefined;
					}
					if(this._oHouse.price > this.api.datacenter.Player.Kama)
					{
						this.gapi.loadUIComponent("AskOk","AskOkNotRich",{title:this.api.lang.getText("ERROR_WORD"),text:this.api.lang.getText("NOT_ENOUGH_RICH")});
					}
					else
					{
						var var3 = this.gapi.loadUIComponent("AskYesNo","AskYesNoBuy",{title:this.api.lang.getText("HOUSE_PURCHASE"),text:this.api.lang.getText("DO_U_BUY_HOUSE",[this._oHouse.name,this.getFormattedPrice()])});
						var3.addEventListener("yes",this);
					}
				}
				break;
			default:
				if(var0 !== "_btnClose")
				{
					break;
				}
				this.callClose();
				break;
		}
	}
	function getFormattedPrice()
	{
		return new ank.utils.(this._oHouse.price).addMiddleChar(this.api.lang.getConfigText("THOUSAND_SEPARATOR"),3);
	}
	function yes()
	{
		this.api.network.Houses.buy(this._oHouse.price);
	}
	function onSetFocus()
	{
		getURL("FSCommand:" add "trapallkeys","false");
	}
	function onKillFocus()
	{
		getURL("FSCommand:" add "trapallkeys","true");
	}
}
