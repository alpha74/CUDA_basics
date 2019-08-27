# cudaGetDeviceProperties()
## Getting CUDA Device properties
A very important feature offered.

## cudaDeviceProp:
- Is a pre-defined struct which is used for fecthing the device details.
- Used for getting all the properties of all CUDA device supported, like: Clock rate, cores, compute capability etc.
- Can also be used for choosing an appropriate CUDA device.
- Use **cudaGetDeviceCount()** to get number of CUDA devices attached to system.
