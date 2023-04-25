#!/bin/bash
#
#$ -S /bin/bash
#$ -N dcase2023_test
#$ -o /opt/Experimentos/DB2/DCASE2023T4/DESED_task/recipes/dcase2023_task4_baseline/outputs/sed_test.out
#$ -e /opt/Experimentos/DB2/DCASE2023T4/DESED_task/recipes/dcase2023_task4_baseline/outputs/sed_test.err
#$ -q phd.q@jupiter.uam
#$ -l gpu=1
#

#### DCASE 2023 Task 4 SED baseline system

cd /opt/Experimentos/DB2/DCASE2023T4/DESED_task/recipes/dcase2023_task4_baseline

/opt/Experimentos/DB2/utils/initialize_sge.sh

use_gpu=1

#### CRNN Baseline 2023
# conf_file='./confs/default.yaml'
# ckpt_file='./exp/2023_baseline/version_10/epoch=196-step=23246.ckpt'
#ckpt_file='./exp/2023_baseline/version_11/epoch=173-step=20532.ckpt'
#ckpt_file='./exp/2023_baseline/version_12/epoch=193-step=22892.ckpt'

### CRNN Baseline + Teacher model selection
conf_file='./confs/teacher_model_selection.yaml'
ckpt_file='./exp/2023_baseline/version_13/epoch=335-step=39648.ckpt'

/opt/Experimentos/DB2/utils/parse_options.sh

# 2. GPU selection
if [[ ${use_gpu} -ne 0 ]]; then
    id=`nvidia-smi -q | grep "UUID\|Processes"| grep "None" -B1 | tr -d " " | cut -d ":" -f2 | sed -n "1p"`
    echo "GPUs " $id
fi

# 3. Python script
env_name="dbenito_dcase2023"
conda_root="/export/anaconda3"
python_path=${conda_root}"/envs/"${env_name}"/bin/python3"

CUDA_VISIBLE_DEVICES=$id $python_path train_sed.py $qwargs --conf_file $conf_file --test_from_checkpoint $ckpt_file