local _b=require("utils").tHex local ab,bb,cb,db,_c=string.sub,string.rep,math.max,math.min,table.unpack;local ac={}local bc=0 local function cc(dc,_d,ad)local bd=dc.._d..ad;if(bc>100)then ac={}bc=0 end;if not ac[bd]then ac[bd]=string.sub(dc,_d,ad)bc=bc+1 end;return ac[bd]end return function(dc)local _d=dc or term.current()local ad,bd=_d.getSize()local cd={} local dd={}local __a={}local a_a;local b_a={}local c_a=false local function d_a()a_a=bb(" ",ad)for n=0,15 do local daa=2 ^n;local _ba=_b[daa] b_a[daa]=bb(_ba,ad)end end;d_a() local function _aa()d_a()local daa=a_a;local _ba=b_a[colors.white] local aba=b_a[colors.black] for currentY=1,bd do dd[currentY]=dd[currentY]or{} cd[currentY]=cd[currentY]or{} dd[currentY][1]=ab(dd[currentY][1]==nil and daa or  dd[currentY][1]..daa:sub(1,ad-dd[currentY][1]:len()),1,ad) dd[currentY][2]=ab(dd[currentY][2]==nil and _ba or  dd[currentY][2].._ba:sub(1,ad-dd[currentY][2]:len()),1,ad) dd[currentY][3]=ab(dd[currentY][3]==nil and aba or  dd[currentY][3]..aba:sub(1,ad-dd[currentY][3]:len()),1,ad)__a[currentY]=true end end;_aa() local function aaa(daa,_ba,aba,bba,cba,dba,_ca) aba=cc(aba,cb(1 -dba+1,1),cb(_ca-dba+1,1)) bba=cc(bba,cb(1 -dba+1,1),cb(_ca-dba+1,1)) cba=cc(cba,cb(1 -dba+1,1),cb(_ca-dba+1,1)) if#aba==#bba and#aba==#cba then if _ba>=1 and _ba<=bd then if daa+#aba>0 and daa<=ad then local aca=daa<1 and 1 -daa+1 or 1;local bca= daa+#aba>ad and ad-daa+1 or#aba local cca=dd[_ba]local dca=cc(cca[1],1,daa-1)..cc(aba,aca,bca)local _da=cc(cca[2],1, daa-1)..cc(bba,aca,bca)local ada=cc(cca[3],1,daa- 1)..cc(cba,aca,bca) if daa+#aba<=ad then dca=dca..cc(cca[1],daa+#aba,ad)_da=_da..cc(cca[2], daa+#aba,ad)ada=ada.. cc(cca[3],daa+#aba,ad)end if(dd[_ba][1]~=dca or dd[_ba][2]~=_da or dd[_ba][3]~=ada)then dd[_ba][1]=dca;dd[_ba][2]=_da dd[_ba][3]=ada;__a[_ba]=true end end end end end local function baa(daa,_ba,aba,bba) if aba>=1 and aba<=bd and _ba+#bba>0 and _ba<=ad then local cba=cb(1,1 -_ba+1)local dba=db(#bba,ad-_ba+1) local _ca=dd[aba][daa]local aca=cc(_ca,1,_ba-1)..cc(bba,cba,dba) if _ba+#bba<=ad then aca=aca..cc(_ca,_ba+#bba,ad)end if(dd[aba][daa]~=aca)then dd[aba][daa]=aca;__a[aba]=true end end end local caa={setSize=function(daa,_ba)ad,bd=daa,_ba;_aa()end,setBg=function(daa,_ba,aba)baa(3,daa,_ba,aba)end,setText=function(daa,_ba,aba) baa(1,daa,_ba,aba)end,setFg=function(daa,_ba,aba)baa(2,daa,_ba,aba)end,blit=function(daa,_ba,aba,bba,cba,dba,_ca) aaa(daa,_ba,aba,bba,cba,dba,_ca)end,drawBackgroundBox=function(daa,_ba,aba,bba,cba)local dba=bb(type(cba)=="string"and cba or _b[cba],aba) if( type(cba)=="string")and(#cba>1)then dba=ab(dba,1,aba)end;for n=1,bba do baa(3,daa,_ba+ (n-1),dba)end end,drawForegroundBox=function(daa,_ba,aba,bba,cba) local dba=bb( type(cba)=="string"and cba or _b[cba],aba) if(type(cba)=="string")and(#cba>1)then dba=ab(dba,1,aba)end;for n=1,bba do baa(2,daa,_ba+ (n-1),dba)end end,drawTextBox=function(daa,_ba,aba,bba,cba) local dba=bb(cba,aba)if(#cba>1)then dba=ab(dba,1,aba)end;for n=1,bba do baa(1,daa,_ba+ (n-1),dba)end end,update=function() local daa,_ba=_d.getCursorPos()local aba=false if(_d.getCursorBlink~=nil)then aba=_d.getCursorBlink()end;_d.setCursorBlink(false) for n=1,bd do if(c_a)then cd[n][1]=dd[n][1] cd[n][2]=dd[n][2]cd[n][3]=dd[n][3]_d.setCursorPos(1,n) _d.blit(_c(dd[n]))__a[n]=false else if(__a[n])then if ( (cd[n][1]~=dd[n][1])or(cd[n][2]~=dd[n][2])or(cd[n][3]~=dd[n][3]))or(c_a)then cd[n][1]=dd[n][1]cd[n][2]=dd[n][2] cd[n][3]=dd[n][3]_d.setCursorPos(1,n)_d.blit(_c(dd[n]))end;__a[n]=false end end end;c_a=false;_d.setBackgroundColor(colors.black) _d.setCursorBlink(aba)_d.setCursorPos(daa,_ba)end,forceRender=function() c_a=true end,setTerm=function(daa)_d=daa end}return caa end