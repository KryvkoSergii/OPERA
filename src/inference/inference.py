from src.benchmark.model_util import extract_opera_feature
import numpy as np
import torch
from src.model.models_eval import LinearHead

def inference(file_path):
    audio_file = np.array([file_path])

    dimension = 768

    features = extract_opera_feature(
        audio_file,
        pretrain="operaCT",
        input_sec=8,
        dim=dimension
    )

    x = np.array(features, dtype=np.float32)

    ckpt_path = "cks/linear/kauh/linear_operaCT768_32_0.0001_50_1e-05-epoch=39-valid_auc=0.83.ckpt"

    model = LinearHead(feat_dim=dimension, classes=2).load_from_checkpoint(
        ckpt_path,
        map_location=torch.device("cpu")
    )

    model.eval()

    with torch.no_grad():
        logits = model(torch.tensor(x))
        probs = torch.softmax(logits, dim=1)
        print("Prediction probabilities:", probs)

if __name__ == '__main__':
    import argparse
    from pathlib import Path

    parser = argparse.ArgumentParser()
    parser.add_argument("--file", type=str)
    args = parser.parse_args()

    inference(file_path=args.file)