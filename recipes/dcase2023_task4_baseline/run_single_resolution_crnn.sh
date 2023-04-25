#!/bin/bash
#
#### DCASE 2023 Task 4
#### Single resolution CRNNs
# dbenitog / AUDIAS / 2023
#
# This script calls run_dcase_baseline.sh
# using different conf files (.yaml)
# Each conf file sets a different resolution
# for mel-spectrogram features.

wd=/opt/Experimentos/DB2/DCASE2023T4/DESED_task/recipes/dcase2023_task4_baseline

# Bs resolution
# out=$wd/outputs/sed_bs_teacher_ms.out
# err=$wd/outputs/sed_bs_teacher_ms.err
# conf_file='./confs/teacher_model_selection.yaml' # BS
# qsub -N 'dcase_bs' -o $out -e $err -v conf_file=$conf_file,start=0\
#     ./run_dcase_baseline.sh \

# F++ resolution
# out=$wd/outputs/sed_fpp_teacher_ms.out
# err=$wd/outputs/sed_fpp_teacher_ms.err
# conf_file='./confs/sed_fpp_ms_teacher.yaml' # F++
# qsub -N 'dcase_fpp' -o $out -e $err -v conf_file=$conf_file,start=0\
#     ./run_dcase_baseline.sh \

# sleep 15

# F+ resolution
# out=$wd/outputs/sed_fp_teacher_ms.out
# err=$wd/outputs/sed_fp_teacher_ms.err
# conf_file='./confs/sed_fp_ms_teacher.yaml' # F+
# qsub -N 'dcase_fp' -o $out -e $err -v conf_file=$conf_file,start=0\
#     ./run_dcase_baseline.sh \

# sleep 15

# T+ resolution
# out=$wd/outputs/sed_tp_teacher_ms.out
# err=$wd/outputs/sed_tp_teacher_ms.err
# conf_file='./confs/sed_tp_ms_teacher.yaml' # T+
# qsub -N 'dcase_tp' -o $out -e $err -v conf_file=$conf_file,start=0\
#     ./run_dcase_baseline.sh \

# sleep 15

# T++ resolution
out=$wd/outputs/sed_tpp_teacher_ms.out
err=$wd/outputs/sed_tpp_teacher_ms.err
conf_file='./confs/sed_tpp_ms_teacher.yaml' # T++
qsub -N 'dcase_tpp' -o $out -e $err -v conf_file=$conf_file,start=0\
    ./run_dcase_baseline.sh \
