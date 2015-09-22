function encrypt( string, key )
	v1 = enc(string, key)
	v1 = string.reverse(v1)
	v2 = enc(v1, key)
	return v2
end

function decrypt( string, key )
	v1 = dec(string, key)
	v1 = string.reverse(v1)
	v2 = dec(v1, key)
	return v2
end

function enc( string, key )
	str = ""
	if #string > #key then
		nkey = ""
		while #string > #nkey do
			nkey = nkey..key
		end
		key = nkey
	end
	for s = 1, #string do
		ch = string.sub(string, s, s)
		k = string.sub(key, s, s)
		bChar = string.byte(ch)
		bKey = string.byte(k)
		if s == 1 then
			secKey1 = 1
			secKey2 = 42
		elseif s > 1 and s < #string then
			secKey1 = string.byte(string.sub(str, s-1, s-1))
			--secKey2 = string.byte(string.sub(string, s+1, s+1))
		else
			secKey1 = 42
			secKey2 = 1
		end
		math.randomseed(secKey1 * #string + 42 * bKey / #key)
		bKey = math.random(1, 94)
		bCharU = bChar + bKey
		if bCharU > 126 then
			bCharU = (bCharU - 126) + 31
		end
		eChar = string.char(bCharU)
		if bChar == 10 or bChar == 9 or bChar == 8 then
			eChar = "\n"
		end
		str = str..eChar
	end
	return str
end

function dec( string, key )
	str = ""
	if #string > #key then
		nkey = ""
		while #string > #nkey do
			nkey = nkey..key
		end
		key = nkey
	end
	--string = string.reverse(string)
	for s = 1, #string do
		ch = string.sub(string, s, s)
		k = string.sub(key, s, s)
		bChar = string.byte(ch)
		bKey = string.byte(k)
		if s == 1 then
			secKey1 = 1
			secKey2 = 42
		elseif s > 1 and s < #string then
			secKey1 = string.byte(string.sub(string, s-1, s-1))
			--secKey2 = string.byte(string.sub(str, s+1, s+1))
		else
			secKey1 = 42
			secKey2 = 1
		end
		math.randomseed(secKey1 * #string + 42 * bKey / #key)
		bKey = math.random(1, 94)
		bCharU = bChar - bKey
		if bCharU < 32 then
			bCharU = 126 - (31 - bCharU)
		end	
		eChar = string.char(bCharU)
		if bChar == 10 or bChar == 9 or bChar == 8 then
			eChar = "\n"
		end
		str = str..eChar
	end
	return str
end