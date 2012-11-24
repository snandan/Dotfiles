#group: rails
#group: rails
import commands

(status, output) = commands.getstatusoutput('ls')

filelist = list(output.split())

for file in filelist:
	with open(file, 'r') as f:
		with open ('tmp', 'w') as fo:
			fo.write('#group: rails\n')
			for line in f:
				fo.write(line)
	(s, o) = commands.getstatusoutput ('mv tmp {}'.format (file))


