## Setup

1. Get a T4 GPU on GCP (hong kong seems to work) - 4 vcpu + 26gb mem, 100GB disk
2. SSH in and accept the nvidia driver

### Running native

3. Install poetry: ```
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz
tar -xvf Python-3.10.0.tgz
cd Python-3.10.0
sudo ./configure --enable-optimizations
sudo make -j 4
sudo make altinstall
python3.10 --version
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/home/ben/.local/bin:$PATH"
```
4. Setup a new poetry project with `poetry init --python=3.10`
5. `poetry shell`
6. `pip install imaginAIry`
7. `imagine "a forest"`

For me this actually errors :'(

### Running in Docker

```
git clone https://github.com/brycedrennan/imaginAIry.git
cd imaginAIry/
docker build . -t imaginairy
cd ../
docker run -it --gpus all -v $HOME/.cache/huggingface:/root/.cache/huggingface -v $HOME/.cache/torch:/root/.cache/torch -v `pwd`/outputs:/outputs imaginairy /bin/bash
imagine --model SD-2.0 'a forest'
```


``` 
   13  imagine --steps 15 -r 9 --model SD-1.5 --init-image outputs/charlie.jpg --mask-prompt 'cat' --mask-mode keep --init-image-strength 0.1 'cat walking on fire'
   14  imagine -r 9 --model SD-1.5 --init-image outputs/robin.jpg --mask-prompt 'girl' --mask-mode keep --init-image-strength 0.2 'girl riding a reindeer in snow'
   15  imagine -r 9 --model SD-1.5 --init-image outputs/robin.jpg --mask-prompt 'face' --mask-mode keep --init-image-strength 0.05 'christmas angel'
   16  imagine -r 9 --model SD-1.5 --init-image outputs/mum.jpg --mask-prompt 'woman' --mask-mode keep --fix-faces --upscale --init-image-strength 0.05 'woman welcomes you to christmas grotto'
```
