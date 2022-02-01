wait();
local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new("ScreenGui", game.CoreGui); ScreenGui.Name = "ModMenu"
local Frame = Instance.new("Frame", ScreenGui)
local Main = Instance.new("ScrollingFrame", ScreenGui)
Main.Size = UDim2.new(0.3, 0, 0.4, 0)
Main.Position = UDim2.new(0.65, 0, 0.2, 0)
ScreenGui.Parent = nil
local MainEvent = game.ReplicatedStorage.MainEvent
local CurrentCamera = workspace.CurrentCamera
local Plr = game.Players.LocalPlayer
function enableGUI()
    local v5 = 0
    local players = game.Players:GetChildren()

    table.sort(players, function(p1, p2)
        return p1:GetFullName() < p2:GetFullName()
    end)

    local v7, v8, v9 = pairs(players)
    while true do
        local v10, Target = v7(v8, v9)
        if not v10 then
            break;
        end;
        v9 = v10;

        local v12 = Instance.new("TextButton");
        v12.Size = UDim2.new(0.25, 0, 0, 45);
        v12.Position = UDim2.new(0, 0, 0, v5 * 50);
        v12.BackgroundColor3 = BrickColor.Red().Color;
        v12.Text = Target.Name;
        v12.TextScaled = true;
        v12.Parent = Main;
    
        local View = v12:Clone();
        View.Text = "Spectate"
        View.Position = UDim2.new(0.75, 0, 0, v5 * 50);
        View.Size = UDim2.new(0.25, 0, 0, 45);
        View.BackgroundColor3 = BrickColor.White().Color;
        View.Parent = Main;
        
        local v14 = v12:Clone();
        v14.Size = UDim2.new(0.25, 0, 0, 45);
        v14.Position = UDim2.new(0.25, 0, 0, v5 * 50);
        v14.BackgroundColor3 = BrickColor.Green().Color;
        v14.Text = "UnBan";
        v14.Parent = Main;

        local v15 = Instance.new("TextBox");
        v15.Size = UDim2.new(0.25, 0, 0, 45);
        v15.Position = UDim2.new(0.5, 0, 0, v5 * 50);
        v15.Text = "Ban/UnBan Note Here";
        v15.Font = v12.Font;
        v15.TextScaled = true;
        v15.Parent = Main;

        v5 = v5 + 1;
        local u4 = false;
        v12.MouseButton1Click:connect(function()
            if u4 == false then
                u4 = true;
                MainEvent:FireServer("BANREMOTE", Target, v15.Text);
                wait(0.5);
                u4 = false;
            end;
        end);

        v14.MouseButton1Click:connect(function()
            MainEvent:FireServer("UNBANREMOTE", Target, v15.Text);
        end);

        View.MouseButton1Click:connect(function()
            CurrentCamera.CameraSubject = Target.Character.Humanoid;
        end);    
    end;
    Main.CanvasSize = UDim2.new(0, 0, 0, v5 * 50);
    ScreenGui.Parent = game.CoreGui
end;

enableGUI()
--Frame.FindServer.MouseButton1Click:connect(function()
--    MainEvent:FireServer("FindServer", Frame.PlayerName.Text);
--end);
--Frame.JoinServer.MouseButton1Click:connect(function()
--    MainEvent:FireServer("JoinServer", Frame.ServerId.Text);
--end);
local u5 = false;
UserInputService.InputBegan:connect(function(p3, p4)
    if not p4 and p3.UserInputType == Enum.UserInputType.Keyboard and p3.KeyCode == Enum.KeyCode.B and u5 == false then
        u5 = true;
        if ScreenGui.Parent == nil then
            enableGUI();
        else
            ScreenGui.Parent = nil;
            for v16, v17 in pairs(Main:GetChildren()) do
                v17:Destroy();
            end;
        end;
        wait(0.2);
