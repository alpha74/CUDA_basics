## Function Execution Space Specifiers

*[Source: NVIDIA CUDA Documentation](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#function-declaration-specifiers)*

- `Function Execution Space Specifiers` denote whether a function executes on host or on the device and whether it is callable from the host or the device.

- [Source Code](https://github.com/alpha74/CUDA_basics/blob/master/7_function_call_inside_kernel/func_call_inside_kernel.cu)

### Types:

 `__device__` :
- Declares a function that is:
  - Executed on device.
  - Callable from device only.

  - Compiler inlines any __device__ function when deemed appropriate.
  

`__global__` :
- Declares a function as being a kernel:
  - Executed on the device.
  - Callable from host.
  - Callable from device for devices of compute capability 3.2 or higher.
  
  - Must have a void return type, and cannot be member of a class.
  - A call to this type of function is asynchronous, meaning it returns before the device has completed its execution.
  - Any call to this function must specify its `Execution Configuration`.
  

`__host__` :
- Declares a function as:
  - Executed on host.
  - Callable from host only.
  
  - A function declared without any of the Specifiers is treated as of this type.
  
---  
  
`__noinline__` :
- This qualifier can be used as a hint for compiler not to inline the function.


`__forceinline__` :
- This qualifier can be used to force compiler to inline the function.
