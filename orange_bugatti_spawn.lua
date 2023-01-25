-- Orange Bugattis custom spawn menu
local ENT = {}

-- Set the entity to inherit from the base entity class
ENT.Type = "anim"

-- Set the class name
ENT.ClassName = "spawner"

-- Define the properties and behaviors of the entity
function ENT:Initialize()
    -- code to initialize the entity
end

function ENT:Think()
    -- code for the entity's logic
end

-- Function to open the vehicle spawn menu
function ENT:OpenVehicleMenu(ply)
    -- Check if the player has the necessary permissions
    if not table.HasValue({"superadmin", "admin"}, ply:GetUserGroup()) then 
        ply:ChatPrint("You do not have permission to use this spawner.")
        return 
    end
    -- Open the menu
    CreateVehicleSpawnMenu(ply, self)
end

-- Check for "e" button press on the entity
hook.Add("PlayerUse", "CheckEntityPress", function(ply, ent)
    if ent:GetClass() == ENT.ClassName and ply:KeyDown(IN_USE) then
        ent:OpenVehicleMenu(ply)
    end
end)

-- Register the entity with the engine
scripted_ents.Register(ENT, ENT.ClassName, true)

-- Add your entity to the spawn menu
list.Set("SpawnableEntities", ENT.ClassName, { "models/props_c17/furnitureStove001a.mdl", ENT.ClassName } )

-- Create a new category for your custom entity
list.SetCategory("Vehicle Spawner", ENT.ClassName, "Vehicle Spawner")

-- Function to spawn a vehicle
function ENT:SpawnVehicle(ply, vehicle)
    -- Check if the player has the necessary permissions
    if not table.HasValue({"superadmin", "admin"}, ply:GetUserGroup()) then 
        ply:ChatPrint("You do not have permission to use this spawner.")
        return 
    end

    -- Spawn the vehicle
    ply:ConCommand("gm_spawn " .. vehicle)
end

-- Create the menu
local function CreateVehicleSpawnMenu(ply, ent)
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 300)
    frame:Center()
    frame:SetTitle("Vehicle Spawn Menu")
    frame:MakePopup()

    -- Create a button for the buggy
    local button = vgui.Create("DButton", frame)
    button:SetText("Spawn Buggy")
    button:SetPos(25, 50)
    button:SetSize(250, 50)
    button.DoClick = function()
        ent:SpawnVehicle(ply, "buggy")
    end

    -- Create a button for the sports car
    local button2 = vgui.Create("DButton", frame)
    button2:SetText("Spawn Sports Car")
    button2:SetPos(25, 110)
    button2:SetSize(250, 50)
    button2.DoClick = function()
        ent:SpawnVehicle(ply, "sportscar")
    end
end


-- Function to spawn a vehicle
function ENT:SpawnVehicle(ply, vehicle)
    -- Check if the player has the necessary permissions
    if not table.HasValue({"superadmin", "admin"}, ply:GetUserGroup()) then 
        ply:ChatPrint("You do not have permission to use this spawner.")
        return 
    end

    -- Spawn the vehicle
    ply:ConCommand("gm_spawn " .. vehicle)
end

-- the text below goes in [garrysmod>cfg>autoexec.lua]
--include("path/to/orange_bugatti_spawn.lua")
