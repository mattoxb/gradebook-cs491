cf: 01-test.csv 02-io.csv 03-stl.csv 04-complete.csv 05-divide.csv 06-bsts.csv 07-disjoint.csv 08-basic-graphs.csv 09-traversals.csv 10-binary-lifting.csv 11-sssp.csv 12-apsp.csv 13-traversals-2.csv 14-mst.csv 15-greedy.csv 16-bits.csv

%.csv: %.json ../data-files/handles.csv
	python ../utils/getScores.py $< > $@ 
