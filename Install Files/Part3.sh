apt update --yes
yes | apt-get install python3.10-tk
apt-get install psmisc --yes

fuser -k 7860/tcp

cd /workspace/kohya_ss

source venv/bin/activate

./gui.sh --listen=0.0.0.0 --share --noverify