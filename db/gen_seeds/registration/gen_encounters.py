from numpy.random import normal
import random
import sys

PARAMS = { "Alex": False, "Brittany": False, "Carl": False, "David": False, "Esther": False }

HEADER = """#Registrations by registrar
---
name: {}
---
"""

TODAY_ENTRY = """- patient_name: {patient_name}
  registration_data:
    patient_status: {status}
    time_start: {start} minutes ago 
    time_end:   {end} minutes ago
"""

PAST_ENTRY = """- patient_name: {patient_name}
  registration_data:
    patient_status: {status}
    time_start: {days_ago} days ago {hour}:00 am
    time_end:   {days_ago} days ago {hour}:00 am
"""

#PAST_ENTRY = """- start_time: {days_ago} days ago {hour}:00 am
#  end_time:   {days_ago} days ago {hour}:{end:02d} am
#  department: {department}
#"""

def gen_current(outfile):
    elapsed = 0
    pname = random.choice(PARAMS.keys())
    if (PARAMS[pname]):
	stat = "returning"
    else: 
	stat = "new"	
	PARAMS[pname] = True
    val = get_val()
    outfile.write(TODAY_ENTRY.format(patient_name=pname,
                                     status=stat,
                                     start=elapsed+val,
                                     end=elapsed
                                     ))
    elapsed += val

def gen_past(outfile, days_ago=1):
    for hour in range(1,3):
        hour = random.randint(1,9)
        pname = random.choice(PARAMS.keys())
        if (PARAMS[pname]):
            stat = "returning"
        else: 
            stat = "new"	
            PARAMS[pname] = True
        end = get_val()
        outfile.write(PAST_ENTRY.format(patient_name=pname,
                                        status=stat,
                                        days_ago=days_ago,
                                        hour=hour+2,
                                        ))

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
