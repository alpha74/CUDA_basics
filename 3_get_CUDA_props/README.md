## cudaGetDeviceProperties()

### Getting CUDA Device properties

- [Source Code](https://github.com/alpha74/CUDA_basics/blob/master/3_get_CUDA_props/get_CUDA_props.cu)

A very important API offered. It provides lots of information on installed CUDA device.

#### cudaDeviceProp:
- Is a pre-defined struct which is used for fecthing the device details.
- Used for getting all the properties of all CUDA device supported, like: Clock rate, cores, compute capability etc.
- Can also be used for choosing an appropriate CUDA device.
- Use **cudaGetDeviceCount()** to get number of CUDA devices attached to system.
