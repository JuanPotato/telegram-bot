do
-- TODO: More currencies

-- See http://webrates.truefx.com/rates/connect.html
local function getEURUSD(usd)
  local url = 'http://webrates.truefx.com/rates/connect.html?c=EUR/USD&f=csv&s=n'
  local res,code = http.request(url)
  local rates = res:split(", ")
  local rate = rates[5]..rates[6] 
  local text = symbol
  if usd then
    local eur = tonumber(usd) / tonumber(rate)
    text = usd.." USD = "..eur.." EUR"
  end
  return text
end

local function run(msg, matches)
  if matches[1] == "!usd" then
    return getEURUSD(nil)
  end
  return getEURUSD(matches[1])
end

return {
    description = "Real-time EURUSD market price", 
    usage = "!usd [EUR]",
    patterns = {
      "^!usd$",
      "^!usd (%d+[%d%.]*)$",
    }, 
    run = run 
}

end
