local S = {}



local function splitNice(pos,dims,sections)
	local m = sections
	local bins = {1,1,1}

	local p = 2
	while m > 1 do
		for i = 1,3,1 do
			while m % p == 0 and dims[i] % p == 0 do
				bins[i] = p * bins[i]
				m = m / p
				dims[i] = dims[i] / p
			end
		end
		p = p + 1
	end

	t1 = {}
	for i = 1,bins[1],1
	do
		for j = 1,bins[2],1
		do
			for k = 1,bins[3],1
			do
				xPos = pos[1] + (i-1)*dims[1]
				yPos = pos[2] + (j-1)*dims[2]
				zPos = pos[3] + (k-1)*dims[3]
				table.insert(t1,{{xPos,yPos,zPos},dims})
			end
		end
	end

	return t1
end

local function findSplit(maxDim,remain,sections)
	local ratio = sections/maxDim

	for n = maxDim,1,-1
	do
		local m = math.floor(ratio * n)
		for j = 0,1,1
		do
			m2 = m-j
			if m2 ~= 0 and n*remain[1]*remain[2]%m2 == 0
			then
				return n, m2
			end
			m2 = m + j
			if m2 ~= 0 and n*remain[1]*remain[2]%m2 == 0
			then
				return n, m2
			end
		end
	end
end

function splitVol(pos,dims,sections)

	-- print(pos[1],pos[2],pos[3])
	for n = 1,#dims,1
	do
		if dims[n] == 0 then return {} end
	end

	local maxDim = math.max(dims[1],dims[2],dims[3])
	local remain = {dims[1],dims[2],dims[3]}
	for m = 1,#dims,1
	do
		if remain[m] == maxDim
		then
			table.remove(remain,m)
			break
		end
	end
	-- print(sections)
	local bad = false
	local splitPoint, sections1 = findSplit(maxDim,remain,sections)
	-- print(splitPoint, sections1)
	if splitPoint == nil
	then
		splitPoint = math.ceil(maxDim/2)
		sections1 = math.floor(sections/2)
		bad = true
		-- print("This is bad.")
		return
	end
	-- print(sections,sections1)
	-- print(pos[1],pos[2],pos[3])
	local dimz1 = {dims[1],dims[2],dims[3]}
	local dimz2 = {dims[1],dims[2],dims[3]}
	local pos2 = {pos[1],pos[2],pos[3]}
	for m = 1,#dims,1
	do
		if dims[m] == maxDim
		then
			dimz1[m] = splitPoint
			dimz2[m] = dims[m]-splitPoint
			pos2[m] = pos[m]+splitPoint
		end
	end

	local t1 = {}
	if bad == true
	then
		t1 = splitVol(pos,dimz1,sections1)
	else
		t1 = splitNice(pos,dimz1,sections1)
	end
	local t2 = splitVol(pos2,dimz2,sections-sections1)
	local lenT1 = #t1
	for n = 1,#t2,1
	do
		t1[lenT1+n] = t2[n]
	end

	return t1
end

-- local jobs = splitVol({0,0,0},{25,20,53},60)
--
-- print(#jobs)
--
-- for k = 1,#jobs,1
-- do
-- 	print("job: " .. k)
-- 	print(jobs[k][1][1],jobs[k][1][2],jobs[k][1][3])
-- 	print(jobs[k][2][1],jobs[k][2][2],jobs[k][2][3])
-- 	print("Volume: " .. jobs[k][2][1]*jobs[k][2][2]*jobs[k][2][3])
-- end

return S
