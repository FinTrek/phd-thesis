# -*- coding: utf-8 -*-
"""
Created on Tue Dec 19 15:58:44 2017

@author: patri
"""

import itertools

with open("main.bbl") as f:
    l = f.readlines()
    
s = "".join(l).split("\\bibitem{")

authors = [a[a.index("\n")+1:a.index("\\newblock")] for a in s[1:]]
authors = [a.strip().strip(".") for a in authors]
authors = [a.replace("~", " ").replace("\n", "").replace("et al", "") for a in authors]

aSplit1 = list(itertools.chain(*[a.split("and ") for a in authors]))
aSplit2 = list(itertools.chain(*[a.strip().split(",") for a in aSplit1]))

authors = [a.replace("{.}","").replace(".","").replace("  ", " ").replace("\\ "," ").strip() for a in aSplit2 if a.strip()]
authors.sort()

lastnames = [a.split(" ")[-1] for a in authors]

clashes = {lname : set([a for a in authors if a.endswith(lname)]) for lname in lastnames}

print([val for val in clashes.values() if len(val) == 2])

counts = {a : authors.count(a) for a in authors}
counts2 = [tuple(reversed(item)) for item in counts.items()]
counts2.sort()
counts2.reverse()

outdata = "\n".join(["{}\t{}".format(f[0],f[1]) for f in counts2])
print(outdata)

with open("cites.csv", "w") as f:
    f.write(outdata)
    
