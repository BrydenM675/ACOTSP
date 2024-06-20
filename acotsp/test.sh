#!/bin/bash
arg=${1:-1}

for x in $(seq 1 $arg) ; do

    if [ -e "out.txt" ]; then rm out.txt; fi
    if [ ! -d "results" ]; then mkdir results; fi

    # iterate over files lists in "tsps"
    for file in $(cat tsps); do
        printf "file: $file\n"

        let num=$(echo $file | sed "s/[a-zA-Z]*//g")
        let opt=$(bc <<< "`../opt_tour.sh ${file}` * 1.05 / 1")

        # execute serial version
        printf "Serial\n"
        ./acotsp -r 1 --quiet -l 0 --ants 992 -o $opt -t 5000 \
            -i ../tsplib/${file}.tsp > ./results/${num}_ser

        # iterate over desired core counts (old)
        for i in 64 32 16 8 4 2; do
            printf "cores: $i\n"
        
            export OMP_NUM_THREADS=$i
            ./old_acotsp -r 1 --quiet -l 0 --ants 992 -o $opt -t 5000 \
                -i ../tsplib/${file}.tsp > ./results/old_${num}_${i}

        done

        # iterate over desired core counts (new)
        for i in 64 32 16 8 4 2; do
            printf "cores: $i\n"
        
            export OMP_NUM_THREADS=$i
            ./omp_acotsp -r 1 --quiet -l 0 --ants 992 -o $opt -t 5000 \
                -i ../tsplib/${file}.tsp > ./results/${num}_${i}

        done
    done

    # printf "\n ----- Saving $x -----\n\n"
    # ./results.sh ${x}.csv
    # if [ $x -lt $arg ]; then
        # rm -r ./results/
    # fi
done
