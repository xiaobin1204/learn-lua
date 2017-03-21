local _M = { _VERSION = '0.01' }

function _M.add(a, b)  --两个 number 型变量相加
  return a + b
end

function _M.update_A ()  -- 更新变量值
  A = 365
end

return _M
