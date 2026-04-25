-- WindUI.lua

local WindUI = {}
WindUI.__index = WindUI

-- 组件基类
local Widget = {}
Widget.__index = Widget

function Widget:new(properties)
    local widget = setmetatable({}, self)
    widget.x = properties.x or 0
    widget.y = properties.y or 0
    widget.width = properties.width or 100
    widget.height = properties.height or 30
    widget.text = properties.text or ""
    return widget
end

-- 按钮类
local Button = setmetatable({}, Widget)
Button.__index = Button

function Button:new(properties)
    local button = Widget.new(self, properties)
    button.onClick = properties.onClick or function() end
    return button
end

function Button:draw()
    love.graphics.setColor(0.2, 0.5, 1) -- 设置按钮颜色
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1) -- 设置文本颜色
    love.graphics.print(self.text, self.x + (self.width / 2) - love.graphics.getFont():getWidth(self.text) / 2, self.y + (self.height / 2) - love.graphics.getFont():getHeight(self.text) / 2)
end

function Button:onMouseClick(mx, my)
    if mx >= self.x and mx <= self.x + self.width and my >= self.y and my <= self.y + self.height then
        self.onClick()
    end
end

-- 标签类
local Label = setmetatable({}, Widget)
Label.__index = Label

function Label:new(properties)
    local label = Widget.new(self, properties)
    return label
end

function Label:draw()
    love.graphics.setColor(1, 1, 1) -- 设置文本颜色
    love.graphics.print(self.text, self.x, self.y)
end

-- 窗口类
local Window = {}
Window.__index = Window

function Window:new(properties)
    local window = setmetatable({}, self)
    window.title = properties.title or "WindUI Window"
    window.width = properties.width or 400
    window.height = properties.height or 300
    window.widgets = properties.widgets or {}
    return window
end

function Window:draw()
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 0, 0, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(self.title, 10, 10)

    -- 绘制所有的控件
    for _, widget in ipairs(self.widgets) do
        widget:draw()
    end
end

function Window:onMouseClick(mx, my)
    for _, widget in ipairs(self.widgets) do
        if widget.onMouseClick then
            widget:onMouseClick(mx, my)
        end
    end
end

-- 注册所有组件
WindUI.Widget = Widget
WindUI.Button = Button
WindUI.Label = Label
WindUI.Window = Window

return WindUI