FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel
WORKDIR /
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin apt-get upgrade -y
RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Europe/Berlin apt-get install -y git python3-pip ffmpeg libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libavresample-dev libz-dev libjpeg-dev cmake wget zip
RUN pip3 install pip --upgrade
RUN pip install pillow gradio gdown scikit-image
RUN git clone https://github.com/Quackenstein/Segment-and-Track-Anything
WORKDIR /Segment-and-Track-Anything
RUN wget -P ./ckpt https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth
RUN wget -P ./ckpt https://huggingface.co/ShilongLiu/GroundingDINO/resolve/main/groundingdino_swint_ogc.pth
RUN gdown --id '1QoChMkTVxdYZ_eBlZhK2acq9KMQZccPJ' --output ./ckpt/R50_DeAOTL_PRE_YTB_DAV.pth
RUN export PATH=/usr/local/cuda-11.6/bin/:$PATH && TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6+PTX" pip install -e git+https://github.com/IDEA-Research/GroundingDINO.git@main#egg=GroundingDINO
RUN export PATH=/usr/local/cuda-11.6/bin/:$PATH && git clone https://github.com/ClementPinard/Pytorch-Correlation-extension.git && cd Pytorch-Correlation-extension && TORCH_CUDA_ARCH_LIST="3.5;5.0;6.0;6.1;7.0;7.5;8.0;8.6+PTX" python setup.py install
EXPOSE 7860
CMD python3 ./app.py
