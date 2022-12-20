# unownablealldoors-darkrp
This is a function for DarkRP That allows you to set all doors to unownable

It was driving me insane that I was getting objects with random "F2 to Own" on it and no way to remove it. So I made a hacky way of doing it :D


As much as it's advised that you don't edit the DarkRP gamemode directly - I didn't listen.

Put the code snippet in doors.lua in gamemodes/darkrp/gamemode/modules/doorsystem/sv_doors.lua

It should be only ran once but you can add it to the list of DarkRP commands if you want - this snippet is in command.lua
Which goes in gamemodes/darkrp/gamemode/modules/doorsystem/sh_doors.lua

Your mileage may vary - I had to edit the SQL database after running but that was because code is dumb - If you're interested in the query used...

UPDATE darkrp_door SET isDisabled=REPLACE(isDisabled, 0, 1)

I'm 100% sure this could be tidied up and put into a nice command but I got what I want out of it.
ENJOY :D
