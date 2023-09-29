# FUZZYB and CELER

## Contents
1. [Introduction](#introduction)
2. [Environment Configuration](#environment-configuration)
3. [Benchmark Info](#benchmark-info)
3. [Running FUZZYB and CELER](#fuzzyb-celer)
4. [Contributor](#contributor)
5. [Citation](#citation)

## Introduction
Soft error rate has been increasing due to the shrinking size of transistors, leading to an elevated risk of catastrophic failures in modern computer systems. 
Error detection by duplicating instructions (EDDI) is a software-based technique to mitigate soft errors with a low runtime performance overhead and has been widely adopted in many safety- and mission-critical real-time systems such as space applications.
However, these systems are commonly sensitive to runtime performance overheads the protection techniques incur. 
Few studies have investigated the performance of EDDI across various system designs and operational parameters, hence lacking a complete understanding in the literature. 
In this paper, we conduct comprehensive experiments to study the variation of EDDI runtime performance overhead and characterize the root causes.
We find that there exist significant variations in performance overheads of EDDI, due to a few architectural and program-level factors.
Based on the findings, we propose two practical techniques FUZZYB and CELER: FUZZYB uses an input searching technique to bound EDDI runtime performance overhead across different inputs for a given program; while CELER reduces EDDI runtime performance overheads using compiler transformation.
To know more about how **FUZZYB** and **CELER** works, you may refer to our [ISSRE'23 paper]().

<p align="center"><img src="./images/workflow.jpg"/></p>

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
| [kNN](https://github.com/JuliaParallel/rodinia/tree/master/openmp/nn)                         | nn                | Rodinia   | filelist.txt 5 30 90             | 349  | small    |
| [Backprop](https://github.com/JuliaParallel/rodinia/tree/master/openmp/backprop)              | backprop          | Rodinia   | 65536                            | 1680 | medium  |
| [BFS](https://github.com/JuliaParallel/rodinia/tree/master/openmp/bfs)                        | bfs               | Rodinia   | graph1M.txt                      | 383  | small    |
| [Kmeans](https://github.com/JuliaParallel/rodinia/tree/master/openmp/kmeans)                  | kmeans            | Rodinia   | -i kdd_cup                       | 1018 | medium  |
| [Needle](https://github.com/JuliaParallel/rodinia/tree/master/openmp/nw)                      | needle            | Rodinia   | 2048 10 2                        | 1069 |  small  |
| [Particlefilter](https://github.com/JuliaParallel/rodinia/tree/master/openmp/particlefilter)  | particlefilter    | Rodinia   | -x 128 -y 128 -z 10 -np 10000    | 1869 | medium  |
| [Pathfinder](https://github.com/JuliaParallel/rodinia/tree/master/openmp/pathfinder)          | pathfinder        | Rodinia   | 1000 10                          | 372  | small    |
| [LUD](https://github.com/JuliaParallel/rodinia/tree/master/openmp/lud)                        | lu                | Rodinia   | -v -s 256                        | 1161 | medium  |
| [FFT](https://github.com/staceyson/splash2/tree/master/codes/kernels/fft)                     | fft               | SPLASH-2  | -m10 -p1 -n65536 -l4 -t          | 2138 | small    |
| [HPCCG](https://github.com/Mantevo/HPCCG)                                                     | hpccg             | Mantevo   | 64 64 64                         | 1975 | large    |
| [Xsbench](https://github.com/ANL-CESAR/XSBench/tree/master/openmp-threading)                  | xsbench           | CESAR     | -t 1 -s small -g 512 -l 1500     | 2366 | large    |

## MINPSID
> This section is to execute MINPSID on above benchmarks.

After changing directory to MINPSID-launcher by executing ```cd MINPSID-launcher```, There are three steps to generate MINPSID protection on selected benchmarks. We here use Pathfinder from Rodinia as example:

1. Fuzzing for finding incubative instructions (IIS). This step contains masssive fault-injection experiments and may take you some time. Please press **ENTER** after the FI results are finished (if you wait for like 10 minutes and nothing new is printed on the screen, and that means finished).
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

## Reproducing Paper Results
> This section is for SC'22 AD/AE review steps.

We provide step by step commands for running MINPSID and result-generation scripts.
There are three key evaluations in this paper:
- **Figure 2 in Section III**: This is showing why existing SID method cannot garantee protection across multiple input in each benchmark.
- **Figure 6 in Section VI**: This is showing how MINPSID outperforms existing SID method across multiple input in each benchmark.
- **Figure 9 in Section VII**: This is showing that MINPSID can also achieve promising result in real-world input scenarios.

The time-cost is different across different benchmarks, which can be found in Table above. Besides, please use *Name in Code* (also shown in above Table) to execute each benchmark. Before you start, please download the MINPSID code by following commands:
```bash
git clone https://github.com/hyfshishen/MINPSID.git
```

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
[Yafan Huang](https://hyfshishen.github.io/) from the University of Iowa.

## Citation
- **[SC'22]** [Mitigating Silent Data Corruptions in HPC Applications across Multiple Program Inputs](https://ieeexplore.ieee.org/document/10046091)

- **[PPoPP'22]** [Hardening selective protection across multiple program inputs for HPC applications](https://dl.acm.org/doi/10.1145/3503221.3508414)
