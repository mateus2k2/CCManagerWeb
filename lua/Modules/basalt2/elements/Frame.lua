 local c=require("basaltLoader").load("Container")local d=setmetatable({},c)d.__index=d;d:initialize("Frame") function d:new(_a,aa,ba) local ca=c:new(_a,aa,ba)setmetatable(ca,self)self.__index=self ca:setType("Frame")ca:create("Frame")ca:setZ(10)ca:setSize(30,12)return ca end;return d