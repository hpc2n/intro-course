// gpu.nf
process GPU_TEST {
    label 'gpu'

    output:
    stdout

    script:
    """
    echo "=== GPU Check ==="
    nvidia-smi

    echo ""
    echo "=== PyTorch + CUDA ==="
    python3 -c "
import torch
print('PyTorch version:', torch.__version__)
print('CUDA available:', torch.cuda.is_available())
if torch.cuda.is_available():
    print('CUDA version:', torch.version.cuda)
    print('Device count:', torch.cuda.device_count())
    print('Device name:', torch.cuda.get_device_name(0))
    x = torch.rand(3, 3).cuda()
    print('Tensor on GPU:', x.device)
"
    """
}

workflow {
    GPU_TEST() | view
}
