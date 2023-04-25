#!/bin/bash
#
#$ -S /bin/bash
#$ -N dcase2023_tpp_teacher_ms
#$ -o /opt/Experimentos/DB2/DCASE2023T4/DESED_task/recipes/dcase2023_task4_baseline/outputs/sed_tpp_teacher_ms.out
#$ -e /opt/Experimentos/DB2/DCASE2023T4/DESED_task/recipes/dcase2023_task4_baseline/outputs/sed_tpp_teacher_ms.err
#$ -q phd.q@jupiter.uam
#$ -l gpu=1
#

#### DCASE 2023 Task 4 SED baseline system

cd /opt/Experimentos/DB2/DCASE2023T4/DESED_task/recipes/dcase2023_task4_baseline

/opt/Experimentos/DB2/utils/initialize_sge.sh

# 1. Parameters
test_only='False'
use_gpu=1

#start=0 #default 0
n_times=3
seed=42

#conf_file='./confs/teacher_model_selection.yaml' # BS
#conf_file='./confs/sed_fpp_ms_teacher.yaml' # F++
#conf_file='./confs/sed_tpp_ms_teacher.yaml' # T++
# conf_file='./confs/sed_fp_ms_teacher.yaml' # F+
# conf_file='./confs/sed_tp_ms_teacher.yaml' # F++

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

tag=$(date +'%Y%m%d-%H%M%S')

for ((i=${start};i<${n_times};i++)); do
  echo $(date) ' - starting experiment nº '$((1+$i))'/'${n_times}' with seed '$(($seed+$i))
  CUDA_VISIBLE_DEVICES=$id $python_path train_sed.py $qwargs --conf_file $conf_file --seed $(($seed+$i))
done
