local blacklist = {
    "BadPlayer1",
    "Hacker123",
    "CheaterABC",
    "",
    "要拉黑的用户名2"
}

local function checkBlacklist()
    local localPlayer = game.Players.LocalPlayer
    local username = localPlayer.Name
    
    for _, blacklistedName in ipairs(blacklist) do
        if username == blacklistedName then
            game.Players.LocalPlayer:Kick("你已被拉黑名单小宝贝~")
            return true
        end
    end
    return false
end

if checkBlacklist() then
    return  
end

function Antihook()
    return "Hook"
end

hookfunction(Antihook, function()
    return "No Hook"
end)

hookfunction(game.HttpGet, print)

if not isfunctionhooked(Antihook) or not isfunctionhooked(game.HttpGet) then
    game:shutdown("别搞我")
    while true do end
end

restorefunction(game.HttpGet)

if isfunctionhooked(game.HttpGet) or isfunctionhooked(request) or isfunctionhooked(tostring) then
    game:shutdown("666")
    while true do end
end

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

            local MainWindow = WindUI:CreateWindow({
                Title = "<font color='#00AAFF'>NM石油帝国</font>",
                Icon = "rbxassetid://4483362748",
                Author = "NM Script",
                Size = UDim2.fromOffset(400, 400),
                Transparent = true,        
                Acrylic = true,
            })

            MainWindow:EditOpenButton({
                Title = "打开",
                Icon = "crown",
                CornerRadius = UDim.new(0, 16),
                StrokeThickness = 2,
                Draggable = true
            })

            -- 添加标签
            MainWindow:Tag({ Title = "石油帝国", Color = Color3.fromHex("#00FF66") })
            MainWindow:Tag({ Title = "CNM", Color = Color3.fromHex("#FFAA00") })
            MainWindow:Tag({ Title = "1.0", Color = Color3.fromHex("#FFAA00") })
        local TimeTag = MainWindow:Tag({
        Title = "00:00",
        Color = Color3.fromHex("#ff0000")
    })
    
    local hue = 0
    task.spawn(function()
        while true do
            local now = os.date("*t")
            local hours = string.format("%02d", now.hour)
            local minutes = string.format("%02d", now.min)
            
            hue = (hue + 0.01) % 1
            local color = Color3.fromHSV(hue, 1, 1)
            
            TimeTag:SetTitle(hours .. ":" .. minutes)

            task.wait(0.06)
        end
    end)

local Tabs = {
    HB = Window:Section({ Title = "自动", Opened = true }),
    NM = Window:Section({ Title = "购买", Opened = true }),    
}

local TabHandles = {
    Y = Tabs.HB:Tab({ Title = "自动出售", Icon = "dollar-sign" }),    
    G = Tabs.HB:Tab({ Title = "娱乐修改", Icon = "dollar-sign" }),        
    A = Tabs.NM:Tab({ Title = "钻头商店", Icon = "pickaxe" }),   
    S = Tabs.NM:Tab({ Title = "精炼商店", Icon = "flask-conical" }),   
    D = Tabs.NM:Tab({ Title = "装饰品商店", Icon = "palette" }),  
    F = Tabs.NM:Tab({ Title = "图腾商店", Icon = "feather" }),                    
}

local Section = TabHandles.G:Section({
Title = "娱乐修改并没有什么作用就是纯修改给朋友炫耀看",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

local player = game:GetService("Players").LocalPlayer

local cash = player.leaderstats:WaitForChild("Cash")
local gasoline = player.leaderstats:WaitForChild("Gasoline")
local gasolinePerSecond = player.Values:WaitForChild("GasolinePerSecond")
local offlineGasoline = player.Values:WaitForChild("OfflineGasoline")

local Input = TabHandles.G:Input({
    Title = "修改现金",
    Desc = "当前：" .. cash.Value,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            cash.Value = num
            InputCash:SetDesc("当前：" .. num)
        end
    end
})

local Input = TabHandles.G:Input({
    Title = "修改汽油",
    Desc = "当前：" .. gasoline.Value,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            gasoline.Value = num
            InputGas:SetDesc("当前：" .. num)
        end
    end
})

local Input = TabHandles.G:Input({
    Title = "修改汽油秒产量",
    Desc = "当前：" .. gasolinePerSecond.Value,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            gasolinePerSecond.Value = num
            InputGasSec:SetDesc("当前：" .. num)
        end
    end
})

local Input = TabHandles.G:Input({
    Title = "修改离线汽油",
    Desc = "当前：" .. offlineGasoline.Value,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            offlineGasoline.Value = num
            InputOffline:SetDesc("当前：" .. num)
        end
    end
})

Section = TabHandles.Y:Section({
Title = "自动出售",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

local isSelling = false
local sellTask = nil

Toggle = TabHandles.Y:Toggle({
    Title = "自动卖气油",
    Desc = "开启后自动卖气油",
    Locked = false,
    Callback = function(value)
        if value then
            isSelling = true
            sellTask = task.spawn(function()
                while isSelling do
                    game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("BaseService"):WaitForChild("RE"):WaitForChild("SellGas"):FireServer()
                    task.wait(0.1)
                end
            end)
        else
            isSelling = false
            if sellTask then
                task.cancel(sellTask)
                sellTask = nil
            end
        end
    end
})

Section = TabHandles.A:Section({
Title = "自动远程购买钻头",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.A:Button({
    Title = "购买基本钻头『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Basic Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})


Button = TabHandles.A:Button({
    Title = "购买强力钻头『1.800』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Strong Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})


Button = TabHandles.A:Button({
    Title = "购买增强型钻头『3.600』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Enhanced Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})


Button = TabHandles.A:Button({
    Title = "购买速度钻头『7.200』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Speed Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})


Button = TabHandles.A:Button({
    Title = "购买强化钻头『12.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Enhanced Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})


Button = TabHandles.A:Button({
    Title = "购买工业钻头『20.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Industrial Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})


Button = TabHandles.A:Button({
    Title = "购买双工业钻头『30.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Double Industrial Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买涡轮钻头『80.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Turbo Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买巨型钻头『140.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Mega Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买巨型绿宝石钻头『400.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Mega Emerald Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买地狱钻头『1.225.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Hell Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买等离子钻头『4.500.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Plasma Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买超长钻头『40M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Huge Long Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买巨型等离子钻头『95M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Mega Plasma Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买多重钻头『280M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Multi Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买熔岩钻头『900M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Lava Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买冰霜等离子钻头『2.4B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Ice Plasma Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买水晶钻头『9B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Crystal Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买钻石钻头『27.5B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Diamond Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买红宝石钻头『85.5B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Ruby Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买融合钻头『187.5B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DrillShop",
            "Fusion Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Section = TabHandles.S:Section({
Title = "精炼店",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.S:Button({
    Title = "购买基础精炼厂 『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Basic Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买高级精炼厂『2.500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Enhanced Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买强化精炼厂『6.250』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Reinforced Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买高级精炼厂『20.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Advanced Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买等离子精炼厂『50.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Plasma Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买工业精炼厂『200.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Industrial Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买能源精炼厂『700.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Energy Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买巨型精炼厂『3.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Mega Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买量子精炼厂『5.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Quantum Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买冰霜精炼厂『8.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Ice Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买地狱精炼厂『16M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Hell Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买巨型量子精炼厂『90M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Mega Quantum Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买巨型能源精炼厂『150M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Mega Energy Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买熔岩精炼厂『360M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Lava Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买水晶精炼厂『600M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Crystal Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买钻石精炼厂『5B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Diamond Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买红宝石精炼厂『50B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Ruby Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买融合精炼厂『285B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "RefineryShop",
            "Fusion Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Section = TabHandles.D:Section({
Title = "精练商店",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.D:Button({
    Title = "购买无线电塔『1.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Radio Tower"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买基础风力发电机『900.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Basic Wind Turbine"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买中型风力发电机『5.400.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Medium Wind Turbine"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买金色风力发电机『60M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Golden Wind Turbine"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Section = TabHandles.D:Section({
Title = "仅供装饰",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.D:Button({
    Title = "购买树木『10』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Trees"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买灯柱『3.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Light Pole"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买盆栽花卉『5.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Potted Flowers"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买集装箱堆『10.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Container Stack"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买花园拱门『100.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Garden Arch"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买鸭子雕像『10M』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Duck Statue"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买喷泉『1B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Fountain"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买石油纪念碑『100B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Oil Monument"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买王座『500B』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "DecorationShop",
            "Throne"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Section = TabHandles.F:Section({
Title = "图腾商店",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.F:Button({
    Title = "购买木质现金图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Wooden Cash Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买石制现金图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Stone Cash Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买铜制现金图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Copper Cash Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买黄金现金图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Golden Cash Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买钻石现金图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Diamond Cash Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买红宝石现金图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Ruby Cash Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买水晶现金图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Crystal Cash Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Section = TabHandles.F:Section({
Title = "暂离图腾",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.F:Button({
    Title = "购买木质AFK图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Wooden Afk Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买石制AFK图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Stone Afk Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买黄金AFK图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Golden Afk Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买钻石AFK图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Diamond Afk Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买红宝石AFK图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Ruby Afk Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买植物AFK图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Plant Afk Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买天堂AFK图腾",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "TotemShop",
            "Heaven Afk Totem"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase"):FireServer(unpack(args))
    end
})

