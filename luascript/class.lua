print("Hello Class")

Account = { 
    balance = 10, 

    withdraw = function(self, v)
        self.balance = self.balance - v
        print(self.balance)
    end,

    -- deposite = function(self, v)
    --     self.balance = self.balance + v
    --     print(self.balance)
    -- end,
}

function Account:deposite(v)
    self.balance = self.balance + v
    print(self.balance)
end

local mt = {__index = Account}
function Account.deprecateNew(o)
    o = o or {}
    setmetatable(o, mt)
    return o
end

local deprecateAcconutObj1 = Account.deprecateNew()
deprecateAcconutObj1:deposite(1)
local deprecateAccountObj2 = Account.deprecateNew()
deprecateAccountObj2:deposite(2)

print(getmetatable(deprecateAcconutObj1))
print(getmetatable(deprecateAccountObj2))


-------------------------------
-- 改进:1. 不创建新表作为元表，用自身作为元表 2.因为需要自身self值，所以使用:
function Account:new(o) -- => function Account.new(self, o)
    o = o or {}
    self.__index = self
    setmetatable(o, self)
    return o
end

local accountObj1 = Account:new({balance = 100})
accountObj1:deposite(1)
local accountObj2 = Account:new()
accountObj2:deposite(2)

print(getmetatable(accountObj1))
print(getmetatable(accountObj2))

-------------- Inheritance --------------
local SpecialAccount = Account:new({balance = 200})
function SpecialAccount:deposite(v)
    self.balance = self.balance - v * 2
    print("SpecialAccount:" .. self.balance)
end

local specialAccountObj1 = SpecialAccount:new({limit = 100})
specialAccountObj1:deposite(1)
print(getmetatable(SpecialAccount))  -- the metatable of SpecialAccount is self for Account
print(getmetatable(specialAccountObj1)) -- the metatable of specialAccountObj1 is self for SpecialAccount

-------------- Multiple Inheritance --------------
function createClass(...)
    -- 在表list中查找k
    local search = function(k, plist)
        for i = 1, #plist do
            local v = plist[i][k]
            if v then return v end
        end
    end

    local c = {} --新类
    local parents = {...} --父类列表

    -- 在父类列表中查找类缺失的方法
    setmetatable(c, {__index = function (t, k)
        return search(k, parents)
    end})

    -- 将 c 作为其实例的元表
    c.__index = c

    --为新类定义一个新的构造函数
    function c:new(o)
        o = o or {}
        setmetatable(o, c)
        return o
    end

    return c
end

Named = {name="aaa"}
function Named:getname()
    return self.name
end

function Named:setname(n)
    self.name = n
end


-- NamedAccount = createClass(Account, Named)
-- local nameAccount = NamedAccount:new({name="Paul"})
-- nameAccount.setname("xxx")
-- print(nameAccount.getname())
