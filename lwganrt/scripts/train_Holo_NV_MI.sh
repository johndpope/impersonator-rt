#! /bin/bash
# Train Holoportator in Novel View Synthesis and Motion Imitation modes

# basic configs
#gpu_ids=0,1     # if using multi-gpus, increasing the batch_size
gpu_ids=0

# dataset configs
dataset_model=Holo
data_dir=/home/kazendi/Anton/Data/HoloVideo/Data  # need to be replaced!!!!!
images_folder=avatars
smpls_folder=smpl_aligned_lwgan
train_ids_file=train.txt
test_ids_file=val.txt

# saving configs
checkpoints_dir=~/builds/impersonator/outputs   # directory to save models, need to be replaced!!!!!
name=Holo_NV_MI   # the directory is ${checkpoints_dir}/name, which is used to save the checkpoints.

# model configs
model=holoportator_trainer
gen_name=holoportator
image_size=256

# pretrained G and D
load_G_path="./outputs/Holo1/net_epoch_27_id_G.pth"
load_D_path="./outputs/Holo1/net_epoch_27_id_D.pth"

# training configs
batch_size=14
lambda_rec=10.0
lambda_tsf=10.0
lambda_face=5.0
lambda_style=0.0
lambda_mask=1.0
#lambda_mask=2.5
lambda_mask_smooth=1.0
nepochs_no_decay=5  # fixing learning rate when epoch ranges in [0, 5]
nepochs_decay=25    # decreasing the learning rate when epoch ranges in [6, 25+5]

python3 train.py --gpu_ids ${gpu_ids}        \
    --data_dir  ${data_dir}                 \
    --images_folder    ${images_folder}     \
    --smpls_folder     ${smpls_folder}      \
    --checkpoints_dir  ${checkpoints_dir}   \
    --train_ids_file   ${train_ids_file}    \
    --test_ids_file    ${test_ids_file}     \
    --load_path        ${load_G_path}       \
    --load_D_path      ${load_D_path}       \
    --model            ${model}             \
    --gen_name         ${gen_name}          \
    --name             ${name}              \
    --dataset_mode     ${dataset_model}     \
    --image_size       ${image_size}        \
    --batch_size       ${batch_size}        \
    --lambda_face      ${lambda_face}       \
    --lambda_tsf       ${lambda_tsf}        \
    --lambda_style     ${lambda_style}      \
    --lambda_rec       ${lambda_rec}         \
    --lambda_mask      ${lambda_mask}       \
    --lambda_mask_smooth  ${lambda_mask_smooth} \
    --nepochs_no_decay ${nepochs_no_decay}  --nepochs_decay ${nepochs_decay}  \
    --mask_bce     --use_vgg       --use_face
