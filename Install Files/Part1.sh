apt update --yes
yes | apt-get install python3.10-tk
apt-get install psmisc --yes

cd /workspace

git clone https://github.com/bmaltais/kohya_ss.git

cd /workspace/kohya_ss

git checkout master

python3 -m venv venv

source venv/bin/activate

pip install setuptools

yes | apt-get install python3.10-tk

./setup.sh -n


