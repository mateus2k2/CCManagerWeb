local d=require("basaltLoader") local _a=d.load("VisualElement")local aa=setmetatable({},_a)aa.__index=aa aa:initialize("Progressbar")aa:addProperty("progress","number",0) aa:addProperty("progressBackground","color",colors.black)aa:addProperty("minValue","number",0) aa:addProperty("maxValue","number",100) function aa:new(ba,ca,da)local _b=_a:new(ba,ca,da)setmetatable(_b,self) self.__index=self;_b:setType("Progressbar")_b:create("Progressbar") _b:setSize(20,3)return _b end function aa:render()_a.render(self)local ba=self:getWidth() local ca=self:getHeight()local da=self:getProgress()local _b=self:getMinValue() local ab=self:getMaxValue()local bb=self:getProgressBackground()local cb=math.floor((ba-2)* (da-_b)/ (ab-_b)) self:addBackgroundBox(1,1,cb,ca,bb)end;return aa