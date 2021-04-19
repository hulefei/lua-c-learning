#!C:\\Lua\\lua54\\lua.exe
print("metatable")

t = {}

print(getmetatable(t))

t1 = {}
setmetatable(t,  t1)

print(getmetatable(t))
print(getmetatable(t) == t1)

print(getmetatable("a"))
print(getmetatable("b"))
print(getmetatable(10))


-- print(#t)

for  i = 0, 10, 4 do
    print(i)
end

a = {"aaa", "bbb", "ccc"}

for i, v in pairs(a) do
    print(i .. ":" .. v)
end



local tab = {x = 100, y = 200}
local tab2 = {x = 10, y = 20}

-- 使用表中默认方法，每个表都会创建一个内部表
function defaultValueTest(t1, t2) 
    function setDefault(t, d)
        local mt = {__index = function() return d end}
        setmetatable(t, mt)
    end

    print(t1.x )
    print(t1.width)
    
    setDefault(t1, 0)
    setDefault(t2, 1)
    
    print(t1.x .. ":" .. t1.width)
    print(t2.x .. ":" .. t2.width)
    
    print(getmetatable(t1))
    print(getmetatable(t2))
end

defaultValueTest(tab, tab2)

------------------------------------------
-- 使用一个公共元表，在设置设置默认元表时，将默认值只放到对象表中，在使用__idnex表时，在对象表中获取默认值
local gmt = {__index = function(t) return t.___ end}

function setGlobalDefault(t, d)
    t.___ = d --//___可以替换成全局变量
    setmetatable(t, gmt)
end

-- 使用表中默认方法，使用同一个元表
function defaultValueTest2(t1, t2)

    print(t1.x)
    print(t1.width)
    
    setGlobalDefault(t1, 0)
    setGlobalDefault(t2, 1)
    
    print(t1.x .. ":" .. t1.width)
    print(t2.x .. ":" .. t2.width)
    
    print(getmetatable(t1))
    print(getmetatable(t2))
end

defaultValueTest2(tab, tab2)

------------------------------------------

--将"___"替换成全局key

local key = {}
local gmt2 = {__index = function(t) return t[key] end}

function setGlobalDefault2(t, d)
    t[key] = d --//___可以替换成全局变量
    setmetatable(t, gmt)
end

function defaultValueTest3(t1, t2)

    print(t1.x)
    print(t1.width)
    
    setGlobalDefault(t1, 0)
    setGlobalDefault(t2, 1)
    
    print(t1.x .. ":" .. t1.width)
    print(t2.x .. ":" .. t2.width)
    
    print(getmetatable(t1))
    print(getmetatable(t2))
end

defaultValueTest3(tab, tab2)


