 local da,_b,ab,bb,cb,db,_c=string.sub,string.find,string.reverse,string.rep,table.insert,string.len,math.floor;local ac={tHex={}} for i=0,15 do ac.tHex[2 ^i]=("%x"):format(i)end;function ac.split(bc,cc)local dc={} for _d in(bc..cc):gmatch("(.-)"..cc)do cb(dc,_d)end;return dc end;function ac.removeTags(bc)return bc:gsub("{[^}]+}","")end function ac.wrapText(bc,cc) bc=ac.removeTags(bc)local dc={}local _d=ac.split(bc,"\n") for ad,bd in pairs(_d)do if#bd==0 then table.insert(dc,"")else local cd=ac.split(bd," ")local dd=""for __a,a_a in ipairs(cd)do if#dd+#a_a>cc then table.insert(dc,dd)dd=a_a else if#dd>0 then dd=dd.." "end;dd=dd..a_a end end;if#dd>0 then table.insert(dc,dd)end end end;return dc end function ac.deepcopy(bc,cc)cc=cc or{}if bc==nil then return nil end if type(bc)~='table'then return bc end;if cc[bc]then return cc[bc]end;if bc.__noCopy then return bc end;local dc={} cc[bc]=dc;for _d,ad in pairs(bc)do dc[ac.deepcopy(_d,cc)]=ac.deepcopy(ad,cc)end setmetatable(dc,ac.deepcopy(getmetatable(bc),cc))return dc end function ac.getCenteredPosition(bc,cc,dc)local _d=string.len(bc) local ad=_c((cc-_d+1)/2 +0.5)local bd=_c(dc/2 +0.5)return ad,bd end function ac.subText(bc,cc,dc)if(cc+#bc<1)or(cc>dc)then return""end if cc<1 then if(cc==0)then bc=da(bc,2)else bc=da(bc,1 -cc)end;cc=1 end;if cc+#bc-1 >dc then bc=da(bc,1,dc-cc+1)end return bc,cc end function ac.orderedTable(bc)local cc={}for dc,_d in pairs(bc)do cc[#cc+1]=_d end;return cc end function ac.rpairs(bc)return function(cc,dc)dc=dc-1;if dc~=0 then return dc,cc[dc]end end,bc,#bc+1 end;function ac.tableCount(bc)local cc=0 if(bc~=nil)then for dc,_d in pairs(bc)do cc=cc+1 end end;return cc end function ac.uuid() return string.gsub(string.format('%x-%x-%x-%x-%x',math.random(0,0xffff),math.random(0,0xffff),math.random(0,0xffff), math.random(0,0x0fff)+0x4000,math.random(0,0x3fff)+0x8000),' ','0')end;return ac