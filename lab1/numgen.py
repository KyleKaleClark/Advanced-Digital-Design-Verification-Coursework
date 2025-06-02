import random as r

#You might have to rerun this like multiple times until the odds/even counts match because its a verilog course not a python course so good enough man

d_out = []
even = []
odd = []

for i in range(0, 100, 2):
	d_out.append(i)
	
for i in range(1, 99, 2):
	d_out.append(i)

print(d_out)


r.shuffle(d_out)

d_out = d_out[0:80]
print(len(d_out))

for d in d_out:
	if (d%2 == 0):
		even.append(d)
	else:
		odd.append(d)

print("shuffled")
print(d_out)

print("/n//data stream")
for d in d_out:
	print("d_in = 8'h"+str(hex(d)[2:])+"; #20;")
	
	
print("odds: ", len(odd))
print("evens:", len(even))
	
expected = []
for i in range(len(even)):
	expected.append(even[i])
	expected.append(odd[i])
	
print("expected", list(map(hex, expected)))
