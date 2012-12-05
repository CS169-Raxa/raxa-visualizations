from numpy.random import normal
import random
import sys

PARAMS = {
    "Registration": {'loc': 15, 'scale': 5, 'min': 3, 'max': 23},
    "Screening":    {'loc': 15, 'scale': 5, 'min': 3, 'max': 23},
    "Outpatient":   {'loc': 30, 'scale': 10, 'min': 13, 'max': 43},
    "Laboratory":   {'loc': 30, 'scale': 10, 'min': 13, 'max': 43}
}

HEADER = """#Encounters for patient
---
name: {}
---
"""

TODAY_ENTRY = """- start_time: {start} minutes ago
  end_time:   {end} minutes ago
  department: {department}
"""


PAST_ENTRY = """- start_time: {days_ago} days ago {hour}:00 am
  end_time:   {days_ago} days ago {hour}:{end:02d} am
  department: {department}
"""

def gen_current(outfile):
    last_dep = None
    elapsed = 0
    for i in range(random.randint(7,15)):
        curr = random.choice(PARAMS.keys())
        while curr == last_dep:
            curr = random.choice(PARAMS.keys())
        last_dep = curr
        params = PARAMS[curr]
        val = get_val(**params)
        outfile.write(TODAY_ENTRY.format(start=elapsed+val,
                                         end=elapsed,
                                         department=curr))
        elapsed += val
    #elapsed += random.randint(180, 600)
    #for i in range(random.randint(3,7)):
    #    curr = random.choice(PARAMS.keys())
    #    while curr == last_dep:
    #        curr = random.choice(PARAMS.keys())
    #    last_dep = curr
    #    params = PARAMS[curr]
    #    val = get_val(**params)
    #    outfile.write(TODAY_ENTRY.format(start=elapsed+val,
    #                                     end=elapsed,
    #                                     department=curr))
    #    elapsed += val

def gen_past(outfile, days_ago=1):
    for dep, params in PARAMS.items():
        for hour in range(1, 4):
            end = get_val(**params)
            outfile.write(PAST_ENTRY.format(days_ago=days_ago,
                                            hour=hour,
                                            end=end,
                                            department=dep))

def get_val(loc=15, scale=5, min=3, max=23):
    result = None
    while result is None or result < min or result > max:
        result = int(normal(loc=loc, scale=scale))
    return result


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print "python gen_encounters.py NAME OUTFILE"
        sys.exit(1)
    name = sys.argv[1]
    outfile = sys.argv[2]
    with open(outfile, 'w') as outfile:
        outfile.write(HEADER.format(name))
        gen_current(outfile)
        for i in range(1, 7):
            gen_past(outfile, i)
