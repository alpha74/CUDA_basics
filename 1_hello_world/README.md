## Hello World Program

Basic hello world program code explanation.

- [Source Code](https://github.com/alpha74/CUDA_basics/blob/master/1_hello_world/hello_world.cu)



#### 1. Comments:
- Syntax of comments remains same: // for single line comments and /* */ for multi-line comments.


#### 2. include directives:
- `#include "cuda_runtime.h"` and `#include "device_launch_parameters.h"` :
  - Both are directives to CUDA compiler.
  
- `#include<stdio.h>` :
  - Standard Input/Output C header file.


#### 3. `__global__ void kernel()`:
- __global__ keyword tells the compiler that this function needs to be compiled with CUDA compiler.
- This is a declaration of the function.
- The function is defined after main().


#### 4. `kernel<<<1,1>>>` :
- Tells the compiler to launch a GRID of 1x1 threads.
