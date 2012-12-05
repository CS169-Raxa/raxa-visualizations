from numpy.random import normal
import sys

HEADER = """# Drug seed file
---
name: {name}
quantity: {quantity}
units: {units}
---
"""

ENTRY = """- amount: {delta}
  timestamp: {when} hours ago
"""

def gen_history(outfile, until=168, rate=10, spread=3):
    for when in range(until):
        val = -get_val(loc=rate, scale=spread, min=-rate, max=rate*2)
        outfile.write(ENTRY.format(delta=val, when=when))

def get_val(loc=15, scale=5, min=3, max=23):
    result = None
    while result is None or result < min or result > max:
        result = int(normal(loc=loc, scale=scale))
    return result

if __name__ == '__main__':
    if len(sys.argv) < 5:
        print "python gen_drug.py NAME QUANTITY UNITS OUTFILE [AVGRATE] [SPREAD]"
        sys.exit(1)
    name = sys.argv[1]
    quantity = sys.argv[2]
    units = sys.argv[3]
    outfile = sys.argv[4]
    if len(sys.argv) >= 6:
        avgrate = float(sys.argv[5])
    if len(sys.argv) >= 7:
        spread = float(sys.argv[6])
    with open(outfile, 'w') as outfile:
        outfile.write(HEADER.format(name=name, quantity=quantity, units=units))
        gen_history(outfile, rate=avgrate, spread=spread)
