# a append
# w write overwrite
#r read
for i in xrange(1, 10):
    with open("name", "w") as f:
        f.write("this " + str(i))
