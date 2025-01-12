local function SetAllDoorsUnOwnable(ply)
    -- Validate player permissions first
    if not IsValid(ply) or not ply:IsAdmin() then
        DarkRP.notify(ply, 1, 4, "You don't have permission to use this command!")
        return false
    end

    -- Get only door entities instead of all entities
    local doors = ents.FindByClass("prop_door_rotating")
    table.Add(doors, ents.FindByClass("func_door"))
    table.Add(doors, ents.FindByClass("func_door_rotating"))

    local doorCount = 0
    local successCount = 0

    for _, door in ipairs(doors) do
        if not IsValid(door) then continue end
        
        -- Check if it's actually a DarkRP door
        if not door.isDoor or not door:isDoor() then continue end

        doorCount = doorCount + 1

        -- Use pcall to handle potential errors
        local success, err = pcall(function()
            -- Unown door if owned
            local owner = door:getDoorOwner()
            if IsValid(owner) then
                door:keysUnOwn(owner)
            end

            -- Reset all door properties
            door:setKeysNonOwnable(true)
            door:removeAllKeysExtraOwners()
            door:removeAllKeysAllowedToOwn()
            door:removeAllKeysDoorTeams()
            door:setDoorGroup(nil)
            door:setKeysTitle(nil)

            -- Store the changes
            DarkRP.storeDoorData(door)
            DarkRP.storeDoorGroup(door, nil)
            DarkRP.storeTeamDoorOwnability(door)
        end)

        if success then
            successCount = successCount + 1
        else
            ErrorNoHalt("Failed to process door: " .. tostring(err) .. "\n")
        end
    end

    -- Notify the player of results
    if doorCount > 0 then
        DarkRP.notify(ply, 0, 4, string.format("Successfully processed %d/%d doors", successCount, doorCount))
    else
        DarkRP.notify(ply, 1, 4, "No valid doors found!")
    end

    return true
end

-- Register the command with error checking
local success, err = pcall(function()
    DarkRP.definePrivilegedChatCommand("setalldoorsunownable", "DarkRP_ChangeDoorSettings", SetAllDoorsUnOwnable)
end)

if not success then
    ErrorNoHalt("Failed to register setalldoorsunownable command: " .. tostring(err) .. "\n")
end