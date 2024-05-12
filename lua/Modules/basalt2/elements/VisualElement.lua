 local ba=require("basaltLoader").load("BasicElement")local ca=require("utils").splitString local da=require("utils").subText;local _b=require("expect").expect local ab=setmetatable({},ba)ab.__index=ab;ab:initialize("VisualElement") ab:addProperty("background","color",colors.black) ab:addProperty("foreground","color",colors.white) ab:addProperty("x","number",1,nil,function(cb,db)cb:reposition("x",db)end) ab:addProperty("y","number",1,nil,function(cb,db)cb:reposition("y",db)end)ab:combineProperty("Position","X","Y") ab:addProperty("visible","boolean",true) ab:addProperty("width","number",1,nil,function(cb,db)cb:resize("width",db)end) ab:addProperty("height","number",1,nil,function(cb,db)cb:resize("height",db)end)ab:addProperty("preRenderData","table",{}) ab:addProperty("postRenderData","table",{})ab:combineProperty("Size","width","height") ab:addProperty("transparency","boolean",false)ab:addProperty("ignoreOffset","boolean",false) ab:addProperty("focused","boolean",false, nil,function(cb,db)if(db)then cb:get_focus()else cb:lose_focus()end end)ab:addListener("click","mouse_click") ab:addListener("drag","mouse_drag")ab:addListener("scroll","mouse_scroll") ab:addListener("hover","mouse_move")ab:addListener("leave","mouse_move2") ab:addListener("clickUp","mouse_up")ab:addListener("key","key") ab:addListener("keyUp","key_up")ab:addListener("char","char") ab:addListener("getFocus","get_focus")ab:addListener("loseFocus","lose_focus") ab:addListener("release","mouse_release")ab:addListener("resize","resize") ab:addListener("reposition","reposition") function ab:new(cb,db,_c)local ac=ba:new(cb,db,_c)setmetatable(ac,self) self.__index=self;ac:create("VisualElement") ac:setType("VisualElement")return ac end;function ab:preRender()end function ab:render()local cb,db=self:getSize() self:addTextBox(1,1,cb,db," ") self:addBackgroundBox(1,1,cb,db,self:getBackground()) self:addForegroundBox(1,1,cb,db,self:getForeground())end;function ab:postRender()end function ab:processRender()self:preRender()for cb,db in pairs(self:getPreRenderData())do self["add"..db.cmd](self,unpack(db.args))end;self:render()for cb,db in pairs(self:getPostRenderData())do self["add"..db.cmd](self,unpack(db.args))end;self:postRender()end;local bb="pre" for _=1,2 do for cb,db in pairs({"Text","Bg","Fg"})do ab[bb..db]=function(_c,ac,bc,cc) local dc=_c:getPreRenderData()if(bb=="post")then dc=_c:getPostRenderData()end table.insert(dc,{cmd=db,args={ac,bc,cc}})_c:updateRender()return _c end end for cb,db in pairs({"BackgroundBox","TextBox","ForegroundBox"})do ab[bb..db]=function(_c,ac,bc,cc,dc,_d) local ad=_c:getPreRenderData()if(bb=="post")then ad=_c:getPostRenderData()end table.insert(ad,{cmd=db,args={ac,bc,cc,dc,_d}})_c:updateRender()return _c end end ab[bb.."Blit"]=function(cb,db,_c,ac,bc,cc)if(#ac~=#bc)or(#ac~=#cc)then error("Text, Foreground and Background must have the same length!")end local dc=cb:getPreRenderData()if(bb=="post")then dc=cb:getPostRenderData()end table.insert(dc,{cmd="Blit",args={db,_c,ac,bc,cc}})cb:updateRender()return cb end;bb="post"end;function ab:clearPreRender()_b(1,self,"table")self:setPreRenderData({}) self:updateRender()return self end;function ab:clearPostRender() _b(1,self,"table")self:setPostRenderData({})self:updateRender() return self end function ab:calculatePosition() local cb,db=self:getPosition()local _c=self:getIgnoreOffset() if not(_c)then if self.parent~=nil then local ac,bc=self.parent:getOffset()cb=cb-ac;db=db-bc end end;return cb,db end for cb,db in pairs({"BackgroundBox","TextBox","ForegroundBox"})do ab["add"..db]=function(_c,ac,bc,cc,dc,_d)local ad= _c.parent or _c;local bd,cd=_c:calculatePosition()ad["draw"..db](ad, ac+bd-1,bc+cd-1,cc,dc,_d)end end for cb,db in pairs({"Text","Bg","Fg"})do ab["add"..db]=function(_c,ac,bc,cc,dc)local _d=_c.parent or _c local ad,bd=_c:calculatePosition()local cd,dd=_c:getSize()local __a=_c:getTransparency()if not(dc)then cc,ac=da(cc,ac,cd)end;if not(__a)then _d["set"..db](_d,ac+ad-1,bc+bd-1,cc)return end;local a_a=ca(cc) for b_a,c_a in pairs(a_a)do if(c_a=="Text")then if (c_a.value~="")and(c_a.value~="\0")then _d["set"..c_a](_d,ac+c_a.x+ad-2, bc+bd-1,c_a.value)end else if(c_a.value~="")and(c_a.value~=" ")then _d["set"..c_a](_d, ac+c_a.x+ad-2,bc+bd-1,c_a.value)end end end end end function ab:addBlit(cb,db,_c,ac,bc)local cc=self.parent or self local dc,_d=self:calculatePosition()local ad=self:getTransparency()if not(ad)then cc:blit(cb+dc-1,db+_d-1,_c,ac,bc)return end;local bd=ca(_c,"\0")local cd=ca(ac) local dd=ca(bc)for __a,a_a in pairs(bd)do if(a_a.value~="")or(a_a.value~="\0")then cc:setText( cb+a_a.x+dc-2,db+_d-1,a_a.value)end end for __a,a_a in pairs(dd)do if (a_a.value~="")or(a_a.value~=" ")then cc:setBg(cb+a_a.x+dc-2,db+_d-1,a_a.value)end end;for __a,a_a in pairs(cd)do if(a_a.value~="")or(a_a.value~=" ")then cc:setFg(cb+a_a.x+dc- 2,db+_d-1,a_a.value)end end end function ab:getRelativePosition(cb,db)_b(1,self,"table")_b(2,cb,"number","nil") _b(3,db,"number","nil") if(cb==nil)and(db==nil)then cb,db=self:calculatePosition()end;local _c,ac=self:calculatePosition()local bc=cb- (_c-1) local cc=db- (ac-1)return bc,cc end function ab:getAbsolutePosition(cb,db)_b(1,self,"table")_b(2,cb,"number","nil") _b(3,db,"number","nil") if(cb==nil)and(db==nil)then cb,db=self:calculatePosition()end;local _c,ac=self:calculatePosition()local bc=cb+ (_c-1) local cc=db+ (ac-1) if self:isType("Container")then local dc,_d=self:getOffset()bc=bc+dc;cc=cc+_d end;if self.parent~=nil then bc,cc=self.parent:getAbsolutePosition(bc,cc)end;return bc,cc end function ab:isInside(cb,db)_b(1,self,"table")_b(2,cb,"number") _b(3,db,"number")local _c,ac=self:calculatePosition()local bc,cc=self:getSize() local dc,_d=self:getVisible(),self:getEnabled() return cb>=_c and cb<=_c+bc-1 and db>=ac and db<=ac+cc-1 and dc and _d end function ab:mouse_click(cb,db,_c) if self:isInside(db,_c)then self:setProperty("clicked",true)self:setProperty("dragging",true) self:updateRender() self:fireEvent("click",cb,self:getRelativePosition(db,_c))return true end end function ab:mouse_drag(cb,db,_c)if self:getProperty("dragging")then self:fireEvent("drag",cb,self:getRelativePosition(db,_c))return true end end function ab:mouse_up(cb,db,_c) if self:isInside(db,_c)then self:fireEvent("clickUp",cb,self:getRelativePosition(db,_c))self:updateRender()return true end end function ab:mouse_release(cb,db,_c)self:setProperty("dragging",false) self:setProperty("clicked",false) self:fireEvent("release",cb,self:getRelativePosition(db,_c))return true end function ab:mouse_scroll(cb,db,_c)if self:isInside(db,_c)then self:fireEvent("scroll",cb,self:getRelativePosition(db,_c))return true end end function ab:mouse_move(cb,db,_c) if self:isInside(db,_c)then self:setProperty("hovered",true)self:updateRender() self:fireEvent("hover",self:getRelativePosition(db,_c))return true end if(self:getProperty("hovered"))then self:setProperty("hovered",false)self:updateRender() self:fireEvent("leave",self:getRelativePosition(db,_c))return true end end function ab:reposition(cb,db,_c)self:fireEvent("reposition",db,_c)end function ab:resize(cb,db,_c)self:fireEvent("resize",db,_c)end;function ab.get_focus(cb)cb:fireEvent("getFocus")end;function ab.lose_focus(cb) cb:fireEvent("loseFocus")end for cb,db in pairs({"key","key_up","char"})do ab[db]=function(_c,...) if (_c.enabled)and(_c.visible)then if(_c.parent==nil)or(_c:getFocused())then _c:fireEvent(db,...)return true end end end end;return ab