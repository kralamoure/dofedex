class dofus.graphics.battlefield.SmileyOverHead extends MovieClip
{
	function SmileyOverHead(§\x1e\x1d\x11§)
	{
		super();
		this.draw(var3);
	}
	function __get__height()
	{
		return 20;
	}
	function __get__width()
	{
		return 20;
	}
	function draw(§\x1e\x1d\x11§)
	{
		this.attachMovie("Loader","_ldrSmiley",10,{_x:-10,_width:20,_height:20,scaleContent:true,contentPath:dofus.Constants.SMILEYS_ICONS_PATH + var2 + ".swf"});
	}
}
