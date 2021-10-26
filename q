if game.Players.LocalPlayer.UserId == 2565434097 or game.Players.LocalPlayer.UserId == 1420800618 
or game.Players.LocalPlayer.UserId == 2505647130 or game.Players.LocalPlayer.UserId == 855930044 or game.Players.LocalPlayer.UserId == 1698335686 or game.Players.LocalPlayer.UserId == 418342072  or game.Players.LocalPlayer.UserId == 2262090794 
or game.Players.LocalPlayer.UserId == 221003611 or game.Players.LocalPlayer.UserId == 2817334614  or game.Players.LocalPlayer.UserId == 897984183 or game.Players.LocalPlayer.UserId == 2914728013  or game.Players.LocalPlayer.UserId == 1084001826 or game.Players.LocalPlayer.UserId == 1877943239 or game.Players.LocalPlayer.UserId == 1032022266
or game.Players.LocalPlayer.UserId == 660134820 or game.Players.LocalPlayer.UserId == 2033452319 or game.Players.LocalPlayer.UserId == 1789812869 or game.Players.LocalPlayer.UserId == 1417529870 or game.Players.LocalPlayer.UserId == 1948877543 or game.Players.LocalPlayer.UserId == 1519954037 or game.Players.LocalPlayer.UserId == 2421938321 
or game.Players.LocalPlayer.UserId == 2396450805 or game.Players.LocalPlayer.UserId == 92548152 or game.Players.LocalPlayer.UserId == 2789841899 or game.Players.LocalPlayer.UserId == 631505066 or game.Players.LocalPlayer.UserId == 171929423 or game.Players.LocalPlayer.UserId == 374383626 then
else
game.Players.LocalPlayer:Kick("Not Whitelisted.")
end
game.StarterGui:SetCore("SendNotification", {
	Title = "Private Silent Aim",
	Text = 'Enabled!',
	Duration = 2,
    })
-- // Dependencies
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/progamergamerpro120414151616124/peopletalk2467/main/whysomeanbro"))()
Aiming.TeamCheck(false)
-- // Services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
-- // Vars
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera
local DaHoodSettings = {
    SilentAim = true,
    AimLock = true,
    Prediction = 0.165,

}
getgenv().DaHoodSettings = DaHoodSettings
-- // Overwrite to account downed
function Aiming.Check()
    -- // Check A
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end
    -- // Check if downed
    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
    -- // Check B
    if (KOd or Grabbed) then
        return false
    end
    -- //
    return true
end
-- // Hook
local __index
__index = hookmetamethod(game, "__index", function(t, k)
    -- // Check if it trying to get our mouse's hit or target and see if we can use it
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        -- // Vars
        local SelectedPart = Aiming.SelectedPart
        -- // Hit/Target
        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            -- // Hit to account prediction
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)
            -- // Return modded val
            return (k == "Hit" and Hit or SelectedPart)
        end
    end
    -- // Return
    return __index(t, k)
end)
-- // Aimlock
RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then
        -- // Vars
        local SelectedPart = Aiming.SelectedPart
        -- // Hit to account prediction
        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)
        -- // Set the camera to face towards the Hit
        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
            end
        end)
