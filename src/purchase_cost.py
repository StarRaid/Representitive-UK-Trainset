#((power/25)*((year-1900)/4)*((speed/100)^2)*(capacity/50))/speed

def cost():
	power = int(input("Power: "))
	speed = int(input("Speed: "))
	year = int(input("Year: "))
	capacity = int(input("Capacity: "))
	loadspeed = int(input("Loading Speed: "))
	print(int(((power/25)*((year-1900)/4)*(int(speed/100)^2)*(capacity/50))/450))
	
while True:
	cost()