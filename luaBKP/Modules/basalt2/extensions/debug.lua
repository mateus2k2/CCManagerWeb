local c={frames={}} local function d()local _a=c.basalt.getMainFrame() local aa=_a:getName() if(c.frames[aa]==nil)then c.frames[aa]={} c.frames[aa].window=_a:addMovableFrame():setSize(45,14):setBackground(colors.cyan):setZ(100):setVisible(false) c.frames[aa].window:addLabel():setText("Debug Log"):setPosition(1,1):setSize(45,1):setForeground(colors.cyan):setBackground(colors.black) c.frames[aa].debugLog=c.frames[aa].window:addList():setPosition(2,3):setSize(42,12):setBackground(colors.white):setForeground(colors.black):setSelectionColor(colors.white,colors.black) c.frames[aa].closeButton=c.frames[aa].window:addButton():setForeground(colors.black):setBackground(colors.red):setSize(1,1):setText("x"):setPosition("{parent.w}",1):onClick(function() c.frames[aa].window:setVisible(false)end) c.frames[aa].label=_a:addLabel():setBackground(colors.black):setForeground(colors.white):setVisible(false):onClick(function() c.frames[aa].window:setVisible( not c.frames[aa].window:getVisible())end)if(c.basalt.extensionExists("borders"))then c.frames[aa].window:setBorder(true)end end;return c.frames[aa]end c.debug=function(...)local _a="" for da,_b in pairs({...})do _a=_a..tostring(_b).." "end;local aa=c.basalt.getMainFrame()local ba=d()local ca=ba.label ca:setPosition(1,aa:getHeight()):setText( "[Debug]: ".._a):setVisible(true) if(ba.debugLog~=nil)then ba.debugLog:addItem(_a)end end c.openDebugPanel=function(_a)if(_a==nil)then _a=true end d():setVisible(_a==true and true or false)end;return{Basalt=c}