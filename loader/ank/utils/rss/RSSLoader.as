class ank.utils.rss.RSSLoader extends XML
{
	function RSSLoader()
	{
		super();
		mx.events.EventDispatcher.initialize(this);
		this.ignoreWhite = true;
		this.initialize();
	}
	function __get__data()
	{
		return this._oData;
	}
	function getChannels()
	{
		return this._aChannels;
	}
	function load(§\x1e\f\x0b§, §\x1e\x1a\x02§)
	{
		super.load(var3);
		this._oData = var4;
	}
	function initialize()
	{
		this._aChannels = new Array();
	}
	function parse()
	{
		this.initialize();
		if(this.childNodes.length == 0)
		{
			return false;
		}
		var var2 = this.firstChild;
		if(var2.nodeName.toLowerCase() != "rss")
		{
			return false;
		}
		var var3 = var2.firstChild;
		while(var3 != null)
		{
			if(var3.nodeName.toLowerCase() == "channel")
			{
				var var4 = new ank.utils.rss.();
				if(var4.parse(var3))
				{
					this._aChannels.push(var4);
				}
			}
			var3 = var3.nextSibling;
		}
		return true;
	}
	function onLoad(§\x14\x1b§)
	{
		if(var2)
		{
			if(this.parse())
			{
				this.dispatchEvent({type:"onRSSLoaded",data:this._oData});
			}
			else
			{
				this.dispatchEvent({type:"onBadRSSFile",data:this._oData});
			}
		}
		else
		{
			this.dispatchEvent({type:"onRSSLoadError",data:this._oData});
		}
	}
}
