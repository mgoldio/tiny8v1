#!/bin/bash

touch seedsweep.txt

module load altera
quartus_map tiny8v1

for i in {4000..5000}
    do
        printf "Running with seed %d.\n" $i >> seedsweep.txt

        quartus_fit --seed=$i tiny8v1
        quartus_sta tiny8v1

        grep "; Slow 1100mV 85C Model Fmax Summary" "output_files/tiny8v1.sta.rpt" -A5 -B1 >> seedsweep.txt
        printf "\n\n" >> seedsweep.txt
    done
