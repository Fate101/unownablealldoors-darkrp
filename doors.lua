local function SetAllDoorsUnOwnable(ply)
	
    for _, ent in ipairs(ents.GetAll()) do
        if ent:isDoor() == true then
            if IsValid(ent:getDoorOwner()) then
                ent:keysUnOwn(ent:getDoorOwner())
            end
            ent:setKeysNonOwnable(not ent:getKeysNonOwnable())
            ent:removeAllKeysExtraOwners()
            ent:removeAllKeysAllowedToOwn()
            ent:removeAllKeysDoorTeams()
            ent:setDoorGroup(nil)
            ent:setKeysTitle(nil)
        
            DarkRP.storeDoorData(ent)
            DarkRP.storeDoorGroup(ent, nil)
            DarkRP.storeTeamDoorOwnability(ent)

        else
            print("not a door") -- Mmmm good debugging
        end
    end
end
    
DarkRP.definePrivilegedChatCommand("setalldoorsunownable", "DarkRP_ChangeDoorSettings", SetAllDoorsUnOwnable)
