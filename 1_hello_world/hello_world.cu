// Basic CUDA Program
// Author: alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void kernel();
int main()
{
	printf("\n Hello HOST ");

	kernel <<<1, 1>>> ();

	
	printf("\n");
	return 0;
}

__global__ void kernel()
{
	printf("\n Hello KERNEL" );
}
