from math import pi
count = 0
while True:
    count += 1
    try:
        radius = float(input("Cylinder diamater (inch): "))/2.0
        psi = float(input("Boiler pressure (psi): "))
        area = pi*(radius**2)
        if input("Super heated (Y/N): ").lower()[0] == "y":
            hp = 0.0229 * area * psi
        else:
            hp = 0.0212 * area * psi
        print("\n", count, "-", round(hp, 1), "hp\n")
    except KeyboardInterrupt:
        exit()
    except:
        print("\n\n=========\nsomething went wrong ;-;\nyou probably put an input in wrong\n=========\n\n")

