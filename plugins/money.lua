do
-- TODO: More currencies

-- See http://webrates.truefx.com/rates/connect.html
local function getCur(from, to, amount)
	local from, to = string.gsub(string.upper(from), "%s+", ""), string.gsub(string.upper(to), "%s+", "")
	local url = "http://www.freecurrencyconverterapi.com/api/v2/convert?q=" .. from .. "_" .. to .. "&compact=y"
	local res,code = http.request(url)
	local returnText = "ERROR: either \"" .. from .. "\" or \"" .. to .. "\" is incorrectly spelled or written"
	if string.match(res, ":[%d+.]+") then
		local conversion = tonumber(string.match(res, "[%d+.]+"))
		local total = tonumber(amount) * conversion
		returnText = amount .. " " .. from .. " is " .. total .. " " .. to
	end
	return returnText
end

local function run(msg, matches)
  return getCur(matches[1], matches[3], matches[2])
end

return {
    description = "Real-time currency conversion", 
    usage = "!money(or !m) [USD or uther currecy] [amount] [EUR or other currency]",
    patterns = {
      "^!money (%w+) (%d+[%d%.]*) (%w+)$",
      "^!m (%w+) (%d+[%d%.]*) (%w+)$"
    }, 
    run = run 
}

end
