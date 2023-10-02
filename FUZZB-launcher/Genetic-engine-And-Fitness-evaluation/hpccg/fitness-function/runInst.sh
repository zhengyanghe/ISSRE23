#!/bin/sh
CUR_DIR="$(pwd)"

cd $CUR_DIR


if [ "$#" -ne 3 ]; then
  echo "You should provide three input args for kmeans file"
  exit 1
fi

echo "\n\n===== Input: $1 $2 $3=====\n"
rm -rf testout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout --append ./hpccg $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout --append ./hpccg $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout --append ./hpccg $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout --append ./hpccg $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout --append ./hpccg $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout --append ./hpccg $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout-pro --append ./full-protected $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout-pro --append ./full-protected $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout-pro --append ./full-protected $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout-pro --append ./full-protected $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout-pro --append ./full-protected $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
perf stat -e cpu-cycles -e L1-dcache-loads -e L1-dcache-stores -e l2_rqsts.code_rd_miss -e branch-loads -e dTLB-loads -e instructions -o testout-pro --append ./full-protected $1 $2 $3 > stdout
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'"
rm stdout 
echo "\n <<<<<  sum phase completed! please see the 'Result' folder >>>> \n"

exit 0


