import re

pattern = ''
read_file = '../B63.csv'
store_file = 'CSVFile_01.csv'

target = open(store_file, 'w')

print 'Hello world!'
huh = re.compile(',([0-9]{1,})/([0-9]{1,})/([0-9]{1,}) ([0-9]{1,}:[0-9]{1,}),')
huh2 = re.compile(',');
with open(read_file) as f:
    for line in f.xreadlines():
        corrected_line = huh.sub(',20\g<3>/\g<2>/\g<1> \g<4>,', line.strip())
        # quoted_line = huh2.sub('","', corrected_line)

        # target.write('"' + quoted_line + '""\n');
        target.write(corrected_line +'\n');

print 'done'
