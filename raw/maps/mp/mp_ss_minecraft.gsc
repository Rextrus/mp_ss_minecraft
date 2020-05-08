// __/\\\________/\\\_______________________________________________________________________/\\\\\\\\\__/\\\\\\_________________________________        
//  _\/\\\_______\/\\\____________________________________________________________________/\\\////////__\////\\\_________________________________       
//   _\//\\\______/\\\___/\\\__________________/\\\_______/\\\___________________________/\\\/______________\/\\\_________________________________      
//   __\//\\\____/\\\___\///___/\\\\\\\\\\__/\\\\\\\\\\\_\///______/\\\\\\\\____________/\\\________________\/\\\_____/\\\\\\\\\_____/\\/\\\\\\___     
//    ___\//\\\__/\\\_____/\\\_\/\\\//////__\////\\\////___/\\\___/\\\//////____________\/\\\________________\/\\\____\////////\\\___\/\\\////\\\__    
//     ____\//\\\/\\\_____\/\\\_\/\\\\\\\\\\____\/\\\______\/\\\__/\\\___________________\//\\\_______________\/\\\______/\\\\\\\\\\__\/\\\__\//\\\_   
//      _____\//\\\\\______\/\\\_\////////\\\____\/\\\_/\\__\/\\\_\//\\\___________________\///\\\_____________\/\\\_____/\\\/////\\\__\/\\\___\/\\\_  
//       ______\//\\\_______\/\\\__/\\\\\\\\\\____\//\\\\\___\/\\\__\///\\\\\\\\______________\////\\\\\\\\\__/\\\\\\\\\_\//\\\\\\\\/\\_\/\\\___\/\\\_ 
//        _______\///________\///__\//////////______\/////____\///_____\////////__________________\/////////__\/////////___\////////\//__\///____\///__
/*
         _   ________   ___       __             _
        | | / / ___( ) / _ | ____/ /_____ ____  (_)
        | |/ / /__ |/ / __ |/ __/  '_/ _ `/ _ \/ /
        |___/\___/   /_/ |_/_/ /_/\_\\_,_/_//_/_/  
    Website: vistic-clan.net
	(C) mp_ss_minecraft BY ARKANI*/
main()
{
	maps\mp\_load::main();

	//ambientPlay("ambient_backlot_ext");
	level.detroitglow=(randomfloat(1),randomfloat(1),randomfloat(1));
		
	thread water1();
	thread lava1(); 
	thread sound();
	thread teleporter();
	thread credit();

	game["allies"] = "sas";
	game["axis"] = "opfor";
	game["attackers"] = "axis";
	game["defenders"] = "allies";
	game["allies_soldiertype"] = "woodland";
	game["axis_soldiertype"] = "woodland";
	
	setdvar( "r_specularcolorscale", "1" );
	setdvar("ss_compassEnabled",0);
	setdvar("r_glowbloomintensity0",".25");
	setdvar("r_glowbloomintensity1",".25");
	setdvar("r_glowskybleedintensity0",".3");

}
water1()
{
	water = getent("water1", "targetname");

	while(1)
	{
		water movex(2, 1, .4, .4);
		wait 1;
		water movex(-2, 1, .4, .4);
		wait 1;
	}
}
lava1()
{
	lava = getent("lava1", "targetname");

	while(1)
	{
		lava movex(2, 1, .4, .4);
		wait 1;
		lava movex(-2, 1, .4, .4);
		wait 1;
	}
}
teleporter()
{
    tele=getentarray("teleport","targetname");
    if(isdefined(tele))
    {
        for(i=0;i<tele.size;i++)
            tele[i] thread portMe();
    }
}
portMe()
{

    for(;;)
    {
        self waittill("trigger",who);
        targ=getent(self.target,"targetname");
        who setorigin(targ.origin);
        who setplayerangles(targ.angles);
        who playsound("portal");
    }
}
sound()
{
	sound1 = getent("sound1", "targetname");
	sound2 = getent("sound2", "targetname");

	while(1)
	{
		sound1 playsound("portalsound");
		sound2 playsound("portalsound");
		wait 5;
	}

}
credit()
{
	level endon("intermission");

	if(isdefined(level.hud_creator))
		level.hud_creator destroy();

	level.hud_creator=newhudelem();
	level.hud_creator.x=110;
	level.hud_creator.y=(6*13);
	level.hud_creator.alignx="left";
	level.hud_creator.horzalign="left";
	level.hud_creator.fontscale=1.4;
	level.hud_creator.alpha=1;
	level.hud_creator.glowalpha=1;
	if(isdefined(level.randomcolor))
		level.hud_creator.glowcolor=level.randomcolor;
	else 
		level.hud_creator.glowcolor=level.detroitglow;
	level.hud_creator.hidewheninmenu=true;

	level.hud_creator settext("Map by VC' Arkani\nVistic-Clan.net");
}