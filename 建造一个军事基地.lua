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
                Title = "<font color='#00AAFF'>NM建造一个军事基地</font>",
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
            MainWindow:Tag({ Title = "建造一个军事基地", Color = Color3.fromHex("#00FF66") })
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
    Y = Tabs.HB:Tab({ Title = "自动收集", Icon = "dollar-sign" }),    
    A = Tabs.NM:Tab({ Title = "装饰商店", Icon = "pickaxe" }),   
    S = Tabs.NM:Tab({ Title = "生产商店", Icon = "flask-conical" }),   
    D = Tabs.NM:Tab({ Title = "单位商店", Icon = "palette" }),  
    F = Tabs.NM:Tab({ Title = "特别的商店", Icon = "feather" }),              
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 获取你的地皮
local function GetPlayerPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in pairs(plots:GetChildren()) do
        if string.find(plot.Name, LocalPlayer.Name) then
            return plot
        end
    end
    return nil
end

local plot = GetPlayerPlot()
if not plot then
    print("找不到你的地皮")
    return
end

-- 获取建筑文件夹
local structures = plot:FindFirstChild("baseplate") and plot.baseplate:FindFirstChild("Structures")
if not structures then
    print("找不到建筑文件夹")
    return
end

-- 获取收集远程事件
local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Shared")
if remote then
    remote = remote:FindFirstChild("Resources")
    if remote then
        remote = remote:FindFirstChild("PlotResources")
        if remote then
            remote = remote:FindFirstChild("Remotes")
            if remote then
                remote = remote:FindFirstChild("Collect")
            end
        end
    end
end

if not remote then
    print("找不到收集事件")
    return
end

local isCollecting = false

Toggle = TabHandles.Y:Toggle({
    Title = "自动收集生产",
    Desc = "开启后自动收集所有建筑产出",
    Locked = false,
    Callback = function(value)
        isCollecting = value
        if value then
            print("开始自动收集")
            task.spawn(function()
                while isCollecting do
                    for _, building in pairs(structures:GetChildren()) do
                        pcall(function()
                            remote:FireServer(building)
                        end)
                        task.wait(0.05)
                    end
                    task.wait(0.1)
                end
            end)
        else
            print("停止自动收集")
        end
    end
})


Section = TabHandles.A:Section({
Title = "装饰品",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.A:Button({
    Title = "购买大型道路『50』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Large Road"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买大型彩绘道路『100』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Large Painted Road"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买墙角『100』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Wall Corner"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买墙壁段『100』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Wall Segment"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买方形箱子『150』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Square Box"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买道路交叉口『250』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Road Intersection"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买桶『300』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Barrel"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买大型人行道『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Large Sidewalk"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买小石头『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Small Rock"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买小树『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Small Tree"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买中型红树『1.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Medium Red Tree"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买中型树『1.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Medium Tree"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买中型黄树『1.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Medium Yellow Tree"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买大型树『2.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Large Tree"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买小型人行道『150』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Small Sidewalk"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买墙壁岗哨『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Wall Guard Post"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买墙壁塔楼『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Wall Tower"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买小型集装箱『750』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Small Container"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买沙袋『1.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Sandbags"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买路灯『1.200』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Lamppost"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买微小石头『2.500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Tiny Rock"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买水塔『2.500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Water Tower"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买巨型人行道『2.500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Huge Sidewalk"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买外部通风口『10.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Exterior Vent"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买无线电塔『10.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Radio Tower"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买起重机『12.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Crane"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买装饰悍马车『12.500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Decorative Humvee"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买筒仓",
    Desc = "远程购买一次『15.000』",
    Callback = function()
        local args = {
            "Silo"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买防空炮塔『20.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Anti-Air Turret"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买放射性材料『25.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Radioactive Material"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买大型岩石『50.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Large Rock"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买装饰坦克『75.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Decorative Tank"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买通风系统『75.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Ventilation System"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买叉车『100.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Forklift"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买泄漏放射性材料『125.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Leaking Radioactive Material"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买装饰喷气机『200.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Decorative Jet"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买装饰支奴干直升机『250.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Decorative Chinook"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买核弹『500.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Nuclear Bomb"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买饼干摊『100』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Cookie Stand"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.A:Button({
    Title = "购买护盾发生器『15.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Shield Generator"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Section = TabHandles.S:Section({
Title = "生产现金",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.S:Button({
    Title = "购买太阳能板『250』",
    Desc = "远程购买一次",
    Callback = function()
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure")
        remote:FireServer("Solar Array")
        print("已发送购买请求")
    end
})

Button = TabHandles.S:Button({
    Title = "购买铁矿『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Iron Mines"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买水培设施『750』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Hydroponics Facility"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买高级太阳能板『1.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Advanced Solar Array"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买钢铁厂『4.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Steel Factory"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买精炼厂『12.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Refinery"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买发电厂『20.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Power Plant"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买仓储设施『50.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Storage Facility"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买雷达站『75.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Radar Complex"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买石油钻机『75.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Oil Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买研究实验室『1.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Research Lab"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买工业钻头『1.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Industrial Drill"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买粒子加速器『2.500.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Particle Accelerator"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买材料研究部『7.500.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Materials Research Wing"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.S:Button({
    Title = "购买企业园区『75.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Corporate Campus"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Section = TabHandles.D:Section({
Title = "生成军人单位",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.D:Button({
    Title = "购买兵营『500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Barracks"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买侦察瞭望塔『750』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Scout Watchtower"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买重步兵建筑『3.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Heavy Infantry Building"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买狙击手巢穴『5.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Sniper's Nest"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买ATV帐篷『7.500』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "ATV Tent"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买特种部队大院『35.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Special Forces Compound"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买悍马车工厂『50.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Humvee Plant"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买弹药库『75.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Munitions Depot"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买机械化军械库『150.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Mechanized Armory"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买休伊直升机停机坪『175.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Huey Helipad"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买轻型坦克工厂『300.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Light Tank Factory"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买防空大院『750.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Air Defense Compound"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买车辆仓库『1.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Vehicle Depot"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买无人机中心『1.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Drone Center"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买喷气机机库『1.500.00』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Jet Hangar"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买航空管制塔『10.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "ATC Tower"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.D:Button({
    Title = "购买巨兽堡垒『50.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Behemoth Fortress"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Section = TabHandles.F:Section({
Title = "补给站或物流仓库",
TextSize = 24,
FontWeight = Enum.FontWeight.SemiBold,
})

Button = TabHandles.F:Button({
    Title = "购买物流仓库『20.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Logistics Warehouse"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买补给站『20.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Supply Depot"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买物流中心『250.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Logistics Hub"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买物流中心『1.500.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Logistics Center"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

Button = TabHandles.F:Button({
    Title = "购买区域仓库『50.000.000』",
    Desc = "远程购买一次",
    Callback = function()
        local args = {
            "Regional Depot"
        }
        game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Resources"):WaitForChild("VendorResources"):WaitForChild("Remotes"):WaitForChild("PurchaseStructure"):FireServer(unpack(args))
    end
})

