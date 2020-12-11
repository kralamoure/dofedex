class dofus.graphics.gapi.ui.WaitingQueue extends dofus.graphics.gapi.core.DofusAdvancedComponent
{
	static var CLASS_NAME = "WaitingQueue";
	function WaitingQueue()
	{
		super();
		this._btnLeaveQueue._visible = false;
	}
	function __set__queueInfos(§\x1e\x18\x10§)
	{
		this._oQueueInfos = var2;
		return this.__get__queueInfos();
	}
	function init()
	{
		super.init(false,dofus.graphics.gapi.ui.WaitingQueue.CLASS_NAME);
		if(this.api.datacenter.Basics.aks_is_free_community)
		{
			this._btnSubscribe._visible = false;
		}
	}
	function createChildren()
	{
		if(this._oQueueInfos == undefined)
		{
			return undefined;
		}
		this._btnSubscribe._visible = false;
		this._btnLeaveQueue._visible = false;
		this.addToQueue({object:this,method:this.initButton});
		this.addToQueue({object:this,method:this.initData});
	}
	function initButton()
	{
		this._btnSubscribe.addEventListener("click",this);
		this._btnLeaveQueue.addEventListener("click",this);
		this._btnSubscribe.label = this.api.lang.getText("SUBSCRIPTION");
		this._btnLeaveQueue.label = this.api.lang.getText("WAIT_QUEUE_LEAVE");
	}
	function initData()
	{
		var var2 = this.api.lang.getServerInfos(this._oQueueInfos.queueId).n;
		if(var2 != undefined)
		{
			this._lblWhite3.text = this._lblBlackTL3.text = this._lblBlackTR3.text = this._lblBlackBL3.text = this._lblBlackBR3.text = this.api.lang.getText("WAITING_FOR_CONNECTION_ON",[var2]);
		}
		else
		{
			this._lblWhite3.text = this._lblBlackTL3.text = this._lblBlackTR3.text = this._lblBlackBL3.text = this._lblBlackBR3.text = this.api.lang.getText("WAITING_FOR_CONNECTION");
		}
		if(this._oQueueInfos.subscriber == true || this.api.datacenter.Basics.aks_is_free_community)
		{
			this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this.api.lang.getText("WAIT_QUEUE_ABO_MSG1",[this._oQueueInfos.position,this._oQueueInfos.totalAbo]);
			this._lblWhite2.text = this._lblBlackTL2.text = this._lblBlackTR2.text = this._lblBlackBL2.text = this._lblBlackBR2.text = this.api.lang.getText("WAIT_QUEUE_ABO_MSG2",[this._oQueueInfos.totalNonAbo]);
		}
		else if(this._oQueueInfos.subscriber == false)
		{
			this._btnSubscribe._visible = true;
			this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this.api.lang.getText("WAIT_QUEUE_NON_ABO_MSG1",[this._oQueueInfos.position - this._oQueueInfos.totalAbo,this._oQueueInfos.totalNonAbo]);
			this._lblWhite2.text = this._lblBlackTL2.text = this._lblBlackTR2.text = this._lblBlackBL2.text = this._lblBlackBR2.text = this.api.lang.getText("WAIT_QUEUE_NON_ABO_MSG2",[this._oQueueInfos.totalAbo]);
		}
		else
		{
			this._lblWhite.text = this._lblBlackTL.text = this._lblBlackTR.text = this._lblBlackBL.text = this._lblBlackBR.text = this.api.lang.getText("WAIT_QUEUE_POSITION",[this._oQueueInfos.position]);
		}
		if(this._oQueueInfos.queueId > -1 && this.api.lang.getConfigText("ENABLE_LEAVE_QUEUE"))
		{
			this._btnLeaveQueue._visible = true;
		}
	}
	function click(§\x1e\x19\x18§)
	{
		switch(var2.target._name)
		{
			case "_btnSubscribe":
				_root.getURL(this.api.lang.getConfigText("PAY_LINK"),"_blank");
				break;
			case "_btnLeaveQueue":
				this.api.kernel.changeServer();
		}
	}
}
