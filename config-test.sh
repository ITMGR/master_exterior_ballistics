#!/bin/bash

sep="-----------------------------------------------"
tmp=`mktemp -p /tmp config.XXXX`
cat <<EOF >$tmp
[projectile]
mass = 928.927
caliber = 406.4
drag_function = KD8
density_function = UK

[form_factor]
2.3000000000000003 = 0.709893
5.1 = 0.923971
8.5 = 0.966435
12.5 = 0.950629
17.5 = 0.95898
23.7 = 0.965627
32.4 = 0.989613
39.2 = 1.002287

[initial_conditions]
altitude = 0.0001
mv = 769.62
air_density_factor = 1.0

[simulation]
timestep = 0.1
EOF

echo -e "\nProjectile from a config file\n$sep"

echo -e "\nSingle\n$sep\n"

meb single --config $tmp -f 0.996695 -l 35.4617

echo -e "\nMatch Range\n$sep\n"

meb match-range --config $tmp --target-range 15000 -F 15,0.87 20,0.9

echo -e "\nFind Form Factors\n$sep\n"

meb find-ff --config $tmp \
    --shot 2.3,4572 \
           5.1,9144 \
           8.5,13716 \
           12.5,18288 \
           17.5,22860 \
           23.7,27432 \
           32.4,32004 \
           39.2,34290

echo -e "\nRange Table (range increment)\n$sep\n"

meb range-table --config $tmp \
    --start 4572 \
    --end 35000 \
    --increment 4572

echo -e "\nRange Table (angle increment)\n$sep\n"

meb range-table-angle --config $tmp \
    --start 5 \
    --end 45 \
    --increment 5

echo -e "\nMax Range\n$sep\n"

meb max-range --config $tmp

echo -e "\n$sep\n"

#rm -f $tmp
