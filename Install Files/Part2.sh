apt update --yes
yes | apt-get install python3.10-tk
apt-get install psmisc --yes

fuser -k 7860/tcp

cd /workspace/kohya_ss

git checkout dev

source venv/bin/activate

pip install lycoris-lora==3.1.1.post1
pip install huggingface_hub
pip install ipywidgets
pip install hf_transfer
pip install hf_xet

python -m pip install --upgrade pip

git pull

git submodule update --init --recursive

pip uninstall xformers torch torchvision torchaudio --yes

pip install torch==2.7.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128

pip install triton-windows==3.3.0.post19 --upgrade

pip install https://huggingface.co/RougeX/Xformers/blob/main/xformers-0.0.30-cp310-cp310-win_amd64.whl

pip install pydantic==2.10.6

pip install bitsandbytes --upgrade


./gui.sh --listen=0.0.0.0 --share --noverify