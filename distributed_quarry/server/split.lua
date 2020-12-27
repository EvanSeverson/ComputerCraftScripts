local S = {}

function splitVol(xDim,yDim,zDim,sections)
	local factors = factor(sections)
	for n = 1,#factors,1
	do
		print(factors[n])
	end
	X = {"x",xDim}
	Y = {"y",yDim}
	Z = {"z",zDim}

	Dims = {X,Y,Z}

	for m = 1,3,1
	do
		mindex = m
		for n = m+1,3,1
		do
			if Dims[mindex][2] > Dims[n][2]
			then
				mindex = n
			end
		end
		Dims[m], Dims[mindex] = Dims[mindex], Dims[m]
	end
	factorX = 1
	factorY = 1
	factorZ = 1
	for m = 1,#factors,1
	do
		if factors[#factors-m+1] == nil
		then
			factors[#factors-m+1] = 1
		end

		if Dims[(#Dims-m)%3+1][1] == "x"
		then
			factorX = factorX*factors[#factors-m+1]
		elseif Dims[(#Dims-m)%3+1][1] == "y"
		then
			factorY = factorY*factors[#factors-m+1]
		elseif Dims[(#Dims-m)%3+1][1] == "z"
		then
			factorZ = factorZ*factors[#factors-m+1]
		end
	end

	return X[2]/factorX,Y[2]/factorY,Z[2]/factorZ
end

function factor(n)
	local a = {}
	while n%2 == 0
	do
		table.insert(a,2)
		n = n/2
	end
	local f = 3
	while f*f <= n
	do
		if n%f == 0
		then
			table.insert(a,math.floor(f))
			n = n/f
		else
			f = f+2
		end
	end
	if n ~= 1
	then
		table.insert(a,math.floor(n))
	end
	return a
end

x = 75
y = 20
z = 65

xDims, yDims, zDims = splitVol(75,20,65,15)
xDims2, yDims2, zDims2 = splitVol(xDims, yDims, zDims, 11)

print(x*y*z)
print(xDims*yDims*zDims)
print(xDims2*yDims2*zDims2)
print(x,y,z)
print(xDims,yDims,zDims)
print(xDims2,yDims2,zDims2)

return S
