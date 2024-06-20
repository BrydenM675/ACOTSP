# ACOTSP
Parallel version of ACOTSP by Thomas Stuetzle.
See README.orig for original readme.

Makefile builds both a fully serial and OpenMP version of the program.

### Files
* `tsps` - specific problem sets from TSPLIB to run with test script
  * Use filename without .tsp extension
  * Assumed to be in `../tsplib/`
* `test.sh` - run performance tests - expects `opt_tour.sh` 
              and tsplib in parent directory
  * Pass a number if more than one trial is desired
* `results.sh` - aggregate results into csv
  * Pass a file name
* `prof.txt` - some of the top output from gprof
* `find.sh` - used to simplify grep calls to find information in the source code

### DISCLAIMERS
The CUDA code supplied here is not complete and will not compile.
The plan was a Proof of Concept so there are some assumptions hardcoded in.
The max cities is currently 1000, the number of nearest neighbor ants is 20.

### Links
[ACOTSP](http://www.aco-metaheuristic.org/aco-code/public-software.html)
