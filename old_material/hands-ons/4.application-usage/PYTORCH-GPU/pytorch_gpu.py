#Example provided by: Lucas Egidio
import torch
from torch import nn
import timeit

def test(gpu_test):
    if gpu_test:
        def dev(x):
            if torch.cuda.is_available():
                return x.cuda()
            return x
    else:
        def dev(x):
            return x

    net = dev(torch.nn.Sequential(
        nn.Linear(300,400),
        nn.Sigmoid(),
        nn.Linear(400,400),
        nn.Sigmoid(),
        nn.Linear(400,1000)
    ))

    x_in = dev(torch.randn(100000, 300, requires_grad=True))

    t0 = timeit.default_timer()
    z = net(x_in)
    loss = z.norm()
    loss.backward()

    print(f'Took {timeit.default_timer()-t0} s to run forward and backward in {loss.device}')

test(gpu_test=True)
test(gpu_test=False)
