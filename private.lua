function newAccount (initialBalance)
  local self = {balance = initialBalance}
  local withdraw = function (v)
    self.balance = self.balance - v
  end
  local deposit = function (v)
    self.balance = self.balance + v
  end
  local getBalance = function () return self.balance end
  return {
    withdraw = withdraw,
    deposit = deposit,
    getBalance = getBalance
  }
end

a = newAccount(100)
a.deposit(100)
print(a.getBalance())
print(a.balance)

-- output
-- 200
-- nil
