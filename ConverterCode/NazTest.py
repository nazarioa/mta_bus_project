import re

pattern = ''
read_file = '../B63.csv'
store_file = 'Import_B01.sql'

target = open(store_file, 'w')

print 'Hello world!'
huh = re.compile(',([0-9]{1,})/([0-9]{1,})/([0-9]{1,}) ([0-9]{1,}:[0-9]{1,}),')
huh2 = re.compile(',');
thefile = open(read_file)
for line in thefile:
    corrected_line = huh.sub(',20\g<3>/\g<2>/\g<1> \g<4>,', line.strip())
    quoted_line = huh2.sub('","', corrected_line)

    new_line = 'insert into raw_data (vehicle_id,timestamp,latitude,longitude,phase,trip_id,direction_id,trip_headsign,shape_dist_traveled,stop_id,stop_sequence,dist_from_stop,extra_1,extra_2,extra_3) values("' + quoted_line + '");\n'

    target.write(new_line);
    next(thefile)
