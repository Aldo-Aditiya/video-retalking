#!/bin/bash

apt-get update

cd /root/video-retalking
mkdir checkpoints
cd checkpoints

aws s3 cp https://kemkes-stunting-video-production.s3.us-east-2.amazonaws.com/video_retalking_models_1.zip video_retalking_models_1.zip
unzip video_retalking_models_1.zip
aws s3 cp https://kemkes-stunting-video-production.s3.us-east-2.amazonaws.com/video_retalking_models_2.zip video_retalking_models_2.zip
unzip video_retalking_models_2.zip
rm -rf video_retalking_models_1.zip
rm -rf video_retalking_models_2.zip



