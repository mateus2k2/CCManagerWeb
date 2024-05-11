local ba=require("basaltLoader") local ca=ba.load("BasicElement")local da=ba.load("VisualElement")local _b=ba.load("List") local ab=require("utils").tHex;local bb=setmetatable({},_b)bb.__index=bb bb:initialize("Dropdown")bb:addProperty("opened","boolean",false) bb:addProperty("dropdownHeight","number",5)bb:addProperty("dropdownWidth","number",15) bb:combineProperty("dropdownSize","dropdownWidth","dropdownHeight") function bb:new(cb,db,_c)local ac=_b:new(cb,db,_c)setmetatable(ac,self) self.__index=self;ac:setType("Dropdown")ac:create("Dropdown") ac:setSize(10,1)ac:setZ(10)return ac end function bb:render()da.render(self)local cb=self:getSelectedIndex() local db=self:getScrollIndex()if self.items[cb]then self:addText(1,1,self.items[cb]) self:addText(self:getWidth(),1,"\16")end if self.opened then self:addText(self:getWidth(),1,"\31") for i=1,self.dropdownHeight do local _c=self.items[i+db-1] if _c then self:addText(1,i+1,_c.. (" "):rep( self.dropdownWidth-_c:len())) if(i+db-1 ==cb)then self:addBg(1,i+1,ab[self.selectionBackground]:rep(self.dropdownWidth)) self:addFg(1,i+1,ab[self.selectionForeground]:rep(self.dropdownWidth))else self:addBg(1,i+1,ab[self.background]:rep(self.dropdownWidth)) self:addFg(1,i+1,ab[self.foreground]:rep(self.dropdownWidth))end end end end end function bb:mouse_click(cb,db,_c)if(da.mouse_click(self,cb,db,_c))then self.opened=not self.opened return true end if self.opened then if ( db>=self.x and db<=self.x+ self.dropdownWidth and _c>=self.y+1 and _c<=self.y+self.dropdownHeight)then self.selectedIndex=_c-self.y+self.scrollIndex-1 self:fireEvent("change",self.items[self.selectedIndex]) self.basalt.thread(function()sleep(0.1)self.opened=false self:updateRender()end)return true end end end function bb:mouse_scroll(cb,db,_c) if(da.mouse_scroll(self,cb,db,_c))then self.selectedIndex=math.max(math.min(self.selectedIndex+cb, #self.items),1)self:updateRender()end if self:getOpened()then if( db>=self.x and db<=self.x+self.dropdownWidth and _c>=self.y+1 and _c<= self.y+self.dropdownHeight)then if cb==-1 then self.scrollIndex=math.max( self.scrollIndex-1,1)else self.scrollIndex=math.min( self.scrollIndex+1,#self.items-self.dropdownHeight+1)end;self:updateRender()end end end;return bb