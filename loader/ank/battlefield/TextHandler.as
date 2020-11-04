class ank.battlefield.TextHandler
{
	static var BUBBLE_TYPE_CHAT = 1;
	static var BUBBLE_TYPE_THINK = 2;
	function TextHandler(var3, var4, var5)
	{
		this.initialize(var2,var3,var4);
	}
	function initialize(var2, var3, var4)
	{
		this._mcBattlefield = var2;
		this._mcContainer = var3;
		this._oDatacenter = var4;
	}
	function clear()
	{
		for(var k in this._mcContainer)
		{
			this._mcContainer[k].removeMovieClip();
		}
	}
	function addBubble(sID, §\x1e\x1b\x03§, §\x1e\x1a\x18§, §\x1e\f\x14§, §\x1e\n\x11§)
	{
		var var7 = (this._oDatacenter.Map.width - 1) * ank.battlefield.Constants.CELL_WIDTH;
		this.removeBubble(sID);
		var var8 = this._mcContainer.attachClassMovie(var6 != ank.battlefield.TextHandler.BUBBLE_TYPE_THINK?ank.battlefield.mc.Bubble:ank.battlefield.mc.BubbleThink,"bubble" + sID,this._mcContainer.getNextHighestDepth(),[var5,var3,var4,var7]);
		var var9 = this._mcBattlefield.getZoom();
		if(var9 < 100)
		{
			var8._xscale = var8._yscale = 10000 / var9;
		}
	}
	function removeBubble(sID)
	{
		var var3 = this._mcContainer["bubble" + sID];
		var3.remove();
	}
}
