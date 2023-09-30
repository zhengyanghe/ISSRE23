# FUZZYB and CELER

## Contents
1. [Introduction](#introduction)
2. [Environment Configuration](#environment-configuration)
3. [Benchmark Info](#benchmark-info)
4. [Running FUZZYB and CELER](#fuzzyb-celer)
5. [Contributor](#contributor)

## Introduction
Soft error rate has been increasing due to the shrinking size of transistors, leading to an elevated risk of catastrophic failures in modern computer systems. 
Error detection by duplicating instructions (EDDI) is a software-based technique to mitigate soft errors with a low runtime performance overhead and has been widely adopted in many safety- and mission-critical real-time systems such as space applications.
However, these systems are commonly sensitive to runtime performance overheads the protection techniques incur. 
Few studies have investigated the performance of EDDI across various system designs and operational parameters, hence lacking a complete understanding in the literature. 
In this paper, we conduct comprehensive experiments to study the variation of EDDI runtime performance overhead and characterize the root causes.
We find that there exist significant variations in performance overheads of EDDI, due to a few architectural and program-level factors.
Based on the findings, we propose two practical techniques FUZZYB and CELER: FUZZYB uses an input searching technique to bound EDDI runtime performance overhead across different inputs for a given program; while CELER reduces EDDI runtime performance overheads using compiler transformation.
To know more about how **FUZZYB** and **CELER** works, you may refer to our [ISSRE'23 paper]().


## Environment Configuration

he dependencies that needed for FUZZYB and CElER are listed as below:
- Ubuntu 16.04
- Python 2.7 and 3.5 (with PyYaml 4.2b4 installed)
- Cmake (minimum v2.8)
- LLVM 3.4

Among those dependencies, LLVM 3.4 is the key dependency for FUZZYB and CELER.

## Benchmark Info
> In the following benchmark table:
>- *Name in Paper*: means the benchmark name shown in our ISSRE'23 paper.
>- *Name in Code*: means the benchmark name used in code.

In this repository, you should use *Name in Code* while running the code.

| **Benchmark (Name in Paper)**  | **Benchmark (Name in Code)** | **Suite** | **Program Input** | **No. of Static Instrunctions** | **Benchmark Workload** |
|--|--|--|--|--|--|
| [kNN](https://github.com/JuliaParallel/rodinia/tree/master/openmp/nn)                         | nn                | Rodinia   | list6553600.txt 6 220 789	       | 349  | small    |
| [Backprop](https://github.com/JuliaParallel/rodinia/tree/master/openmp/backprop)              | backprop          | Rodinia   | 3744752                          | 1680 | medium   |
| [BFS](https://github.com/JuliaParallel/rodinia/tree/master/openmp/bfs)                        | bfs               | Rodinia   | graph9586688.t                   | 383  | small    |
| [Kmeans](https://github.com/JuliaParallel/rodinia/tree/master/openmp/kmeans)                  | kmeans            | Rodinia   | 57141 43 3                       | 1018 | medium   |
| [Needle](https://github.com/JuliaParallel/rodinia/tree/master/openmp/nw)                      | needle            | Rodinia   | 2752 134 1                       | 1069 |  small   |
| [B+tree](https://github.com/JuliaParallel/rodinia/tree/master/openmp/b+tree)                  | b+tree            | Rodinia   | 5714026 1287 11562 13507	       | 6622 | large    |
| [Pathfinder](https://github.com/JuliaParallel/rodinia/tree/master/openmp/pathfinder)          | pathfinder        | Rodinia   | 571831 435                       | 372  | small    |
| [LUD](https://github.com/JuliaParallel/rodinia/tree/master/openmp/lud)                        | lud               | Rodinia   | -v -s 1573                       | 1161 | medium   |
| [MYOCYTE](https://github.com/JuliaParallel/rodinia/tree/master/openmp/myocyte)                | myocyte           | Rodinia   | 229 172 1 1                      | 7541 | large    |
| [FFT](https://github.com/staceyson/splash2/tree/master/codes/kernels/fft)                     | fft               | SPLASH-2  | -m24 -p8 -n281076736 -l96        | 2138 | small    |
| [COMD](http://downloads.mantevo.org/CoMD_ref-1.1b.html)                                       | comd              | Mantevo   | -x 14 -y 11 -z 14 -N 14	       | 11457| large    |
| [HPCCG](https://github.com/Mantevo/HPCCG)                                                     | hpccg             | Mantevo   | 74 55 74                         | 1975 | large    |
| [Xsbench](https://github.com/ANL-CESAR/XSBench/tree/master/openmp-threading)                  | xsbench           | CESAR     | -t 1 -s small -g 11429 -l 8578   | 2366 | large    |
| [Blackscholes](https://github.com/bamos/parsec-benchmark)                                     | blackscholes      | PARSEC    | 1 98282.txt output.txt	       | 740  | medium   |
| [BT](https://www.nas.nasa.gov/software/npb.html)                                              | BT                | NPB       | default input                    | 26013 | large   |
| [LU](https://www.nas.nasa.gov/software/npb.html)                                              | LU                | NPB       | default input                    | 24017 | large   |
| [SP](https://www.nas.nasa.gov/software/npb.html)                                              | SP                | NPB       | default input                    | 21630 | large   |
| [EP](https://www.nas.nasa.gov/software/npb.html)                                              | EP                | NPB       | default input                    | 912  | medium   |
| [FFT2](https://github.com/embecosm/mibench/tree/master/telecomm/FFT)                          | fft2              | MiBench   | 58 131072	                       | 744  | medium   |
| [STENCIL](http://impact.crhc.illinois.edu/parboil/parboil_download_page.aspx)                 | stencil           | Parboil   | -i 128x128x32.bin 128 128 32 100 -o output.dat| 1747  | medium |
| [MCF](https://www.spec.org/cpu2006/Docs/429.mcf.html)                                         | mcf               | SPEC      | inp.in		                   | 3917  | large   |
| [LBM](https://www.spec.org/cpu2006/Docs/470.lbm.html)                                         | lbm               | SPEC      | 86 100_100_130_ldc.of 0 0        | 7899  | large   |


## FUZZYB
> This section is to execute FUZZYB on above benchmarks.

After changing directory to FUZZYB-launcher by executing ```cd FUZZYB-launcher```, There are three steps to generate FUZZYB selection on selected benchmarks. We here use Pathfinder from Rodinia as example:

1. Fuzzing for finding the inputs that bounding the upper performance overhead of EDDI. This step contains feature collection experiments and may take you some time.
    ```bash
    python3 01-fuzzing-finding-IIS.py pathfinder 20
    ```
2. Cost-and-benefit reprioritization and Knapsack selection for generating protection information.
    ```bash
    python3 02-knapsack-selection.py pathfinder 20
    ```
3. Code transformation for selective instruction duplication to protect the selected IR Pathfinder.
    ```bash
    python3 03-SID-code-transformation.py pathfinder 20
    ```
Then, the protected IR can be checked by the results printed on the screen.

### Section III - Preliminary Study
Results in this section refers to Figure 2 in paper.
1. Change directory to the folder related to Section III.
    ```bash
    cd AD-AE-evaluation/s3-preliminary
    ```
2. Execute scripts for running and results colelction. This step contains massive fault-injection experiments and may take you some time. After that the results will be printed automatically.
    ```bash
    python3 run.py BENCHMARK-NAME-IN-CODE 20
    # e.g.:
    #   python3 run.py pathfinder 20
    #   python3 run.py nn 20
    #   python3 run.py needle 20
    #   python3 run.py lu 20
    #   ......
    ```

### Section VI  - Evaluation
Results in this section refers to Figure 6 in paper. We here use pathfinder as example, other benchmarks are totally the same.
1. Change directory to the folder related to Section VI.
    ```bash
    cd AD-AE-evaluation/s6-evaluation
    ```
2. Fuzzing for finding incubative instructions (IIS). This step contains masssive fault-injection experiments and may take you some time. Please press **ENTER** after the FI results are finished (if you wait for like 10 minutes and nothing new is printed on the screen, and that means finished).
    ```bash
    python3 01-fuzzing-finding-IIS.py pathfinder 20
    ```
3. Cost-and-benefit reprioritization and Knapsack selection for generating protection information.
    ```bash
    python3 02-knapsack-selection.py pathfinder 20
    ```
4. Random fault injection experiments for evaluating the MINPSID. This step contains massive fault-injection experiments and may take you some time. After that the results will be printed automatically.
    ```bash
    python3 03-randomFI-evaluation.py pathfinder 20
    ```
Note that only MINPSID results in Figure 6 will be printed here, the Baseline (i.e. existing SID method) results can be found in Figure 2 (Section III).

### Section VII - Case Study: Real-World Input.
Results in this section refers to Figure 9 in paper. We here use bfs as example, the execution of kmeans are totally the same.
1. Change directory to the folder related to Section VI.
    ```bash
    cd AD-AE-evaluation/s7-case-study-real-world
    ```
2. Fuzzing for finding incubative instructions (IIS). This step contains masssive fault-injection experiments and may take you some time. Please press **ENTER** after the FI results are finished (if you wait for like 10 minutes and nothing new is printed on the screen, and that means finished).
    ```bash
    python3 01-fuzzing-finding-IIS.py bfs 20
    ```
3. Cost-and-benefit reprioritization and Knapsack selection for generating protection information.
    ```bash
    python3 02-knapsack-selection.py bfs 20
    ```
4. Random fault injection experiments for evaluating the MINPSID. This step contains massive fault-injection experiments and may take you some time. After that the results will be printed automatically.
    ```bash
    python3 03-randomFI-evaluation.py bfs 20
    ```

## Contributor
[Zhengyang He](https://hyfshishen.github.io/) from the University of Iowa.
