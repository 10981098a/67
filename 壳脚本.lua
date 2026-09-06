local OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/jrdKakD6"))()
local SoundService = game:GetService("SoundService")
local OpenSound = Instance.new("Sound")
OpenSound.SoundId = "rbxassetid://12222285"
OpenSound.Volume = 0.6
OpenSound.Parent = SoundService
task.wait(0.1)
OpenSound:Play()

local player = game.Players.LocalPlayer

local Window = OrionLib:MakeWindow({
	Name = "林脚本",
	HidePremium = false,
	SaveConfig = true,
	IntroText = "林脚本",
	ConfigFolder = "林脚本",
	Icon = "rbxassetid://15613380753"
})

local MainTab = Window:MakeTab({
	Name = "玩家功能",
	Icon = "rbxassetid://15613380753",
	PremiumOnly = false
})

--速度滑块
MainTab:AddSlider({
	Name = "移动速度",
	Min = 16,
	Max = 200,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "数值",
	Callback = function(Value)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = Value
		end
	end    
})

--跳跃滑块
MainTab:AddSlider({
	Name = "跳跃高度",
	Min = 50,
	Max = 200,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "数值",
	Callback = function(Value)
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.JumpPower = Value
		end
	end    
})

MainTab:AddTextbox({
	Name = "跳跃高度设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		local num = tonumber(Value)
		if num and player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.JumpPower = num
		end
	end
})

MainTab:AddTextbox({
	Name = "移动速度设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		local num = tonumber(Value)
		if num and player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.WalkSpeed = num
		end
	end
})

MainTab:AddTextbox({
	Name = "重力设置",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
		local num = tonumber(Value)
		if num then
			game.Workspace.Gravity = num
		end
	end
})

MainTab:AddToggle({
	Name = "夜视",
	Default = false,
	Callback = function(Value)
		if Value then
		    game.Lighting.Ambient = Color3.new(1, 1, 1)
		else
		    game.Lighting.Ambient = Color3.new(0, 0, 0)
		end
	end
})

MainTab:AddButton({
	Name = "点击传送工具",
	Callback = function()
		local mouse = player:GetMouse()
		local tool = Instance.new("Tool")
		tool.RequiresHandle = false
		tool.Name = "[FE] TELEPORT TOOL"
		tool.Activated:Connect(function()
			local pos = mouse.Hit.Position+Vector3.new(0,2.5,0)
			player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
		end)
		tool.Parent = player.Backpack
	end
})

MainTab:AddButton({
	Name = "立即死亡",
	Callback = function()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.Health = 0
		end
	end
})

MainTab:AddButton({
	Name = "回满血",
	Callback = function()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character.Humanoid.Health = 10000
		end
	end
})

local Noclip = false
local Stepped
MainTab:AddToggle({
	Name = "穿墙",
	Default = false,
	Callback = function(Value)
		Noclip = Value
		if Value then
			Stepped = game:GetService("RunService").Stepped:Connect(function()
				if Noclip and player.Character then
					for _,v in pairs(player.Character:GetChildren()) do
						if v:IsA("BasePart") then
							v.CanCollide = false
						end
					end
				end
			end)
		else
			if Stepped then Stepped:Disconnect() end
			if player.Character then
				for _,v in pairs(player.Character:GetChildren()) do
					if v:IsA("BasePart") then
						v.CanCollide = true
					end
				end
			end
		end
	end
})

MainTab:AddButton({
	Name = "反挂机",
	Callback = function()
		local vu = game:GetService("VirtualUser")
		player.Idled:Connect(function()
		   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		   task.wait(1)
		   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		end)
	end
})