### This repo is forked from [NVIDIA/waveglow](https://github.com/NVIDIA/waveglow).Visit the [link](https://github.com/NVIDIA/waveglow) for original implmentation.

## WaveGlow: a Flow-based Generative Network for Speech Synthesis

This repo contains the [PyTorch] implementation of waveglow which produces audio samples at a rate of 16
kHz.The model was trained from scratch using [Librispeech train-clean-100](http://www.openslr.org/12) dataset.

## Setup

1. Clone this repo and initialize submodule

   ```command
   git clone https://github.com/NVIDIA/waveglow.git
   cd waveglow
   git submodule init
   git submodule update
   ```

2. Install [Apex]
    ```
   git clone https://github.com/NVIDIA/apex
   cd apex
   pip install -v --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" ./
   cd ../
    ```
3. Install requirements `pip3 install -r requirements.txt`


## Generate audio with Pre-trained model
### Comming soon



## Train the model on Librispeech train-clean-100(16KHz)

1. Download [Librispeech train-clean-100](http://www.openslr.org/resources/12/train-clean-100.tar.gz) dataset.
   ```
   wget http://www.openslr.org/resources/12/train-clean-100.tar.gz
   ```

2. Convert flac files to wav 
   ```run
   ./flac2wav.sh
   ```

3. Make a list of the file names to use for training/testing

   ```command
   ls wav_data/*.wav | tail -n+10 > train_files.txt
   ls wav_data/*.wav | head -n10 > test_files.txt
   ```

3. Train your WaveGlow networks

   ```command
   mkdir checkpoints
   python train.py -c config.json
   ```

   For multi-GPU training replace `train.py` with `distributed.py`.  Only tested with single node and NCCL.

   For mixed precision training set `"fp16_run": true` on `config.json`.

4. Make test set mel-spectrograms

   `python mel2samp.py -f test_files.txt -o . -c config.json`

5. Do inference with your network

   ```command
   ls *.pt > mel_files.txt
   python3 inference.py -f mel_files.txt -w checkpoints/waveglow_10000 -o . --is_fp16 -s 0.6
   ```
