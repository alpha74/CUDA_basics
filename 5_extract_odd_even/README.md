## tid

### Extract Odd-Even elements

- [Source Code](https://github.com/alpha74/CUDA_basics/blob/master/5_extract_odd_even/extract_odd_even.cu)


### Objective: 

- Extract elements from main array and place elements at even index and odd index into separate arrays, respectively.


## Cases:

- threadIdx.x returns the ID of current thread's I dimension.
- In the given program, kernel is launched like this: **<<<N,1>>>**.
- Here, N blocks with 1 thread each is launched.
- Hence, we calculate **tid** as:
```
  int tid = blockIdx.x ;
```

- If kernel is launched like this: **<<<1,N>>>**, 1 block with N threads each is launched.
- In this case, **tid** is calculated as:
```
  int tid = threadIdx.x ;
```

- If the kernel was launched like this: **<<<4,20>>>** ( 4 blocks, 20 threads ) : It will launch ( 4 x 20 ) threads.
- **blockDim.x** acts like an offset. Returns number of threads in a block, which is same for each block in a GPU.
- In this case, **tid** will be calculated as:
```
  int tid = threadIdx.x + blockDim.x * blockIdx.x ;
```
