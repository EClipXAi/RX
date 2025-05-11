#!/bin/bash

pip install huggingface_hub ipywidgets hf_transfer hf_xet

export HF_HUB_ENABLE_HF_TRANSFER=1

python Flux.py --dir /workspace
