// Passing Arguments to Kernel and Adding two numbers
// Author: alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void add(int, int, int *);	// Add two numbers

int main()
{
	int c;		// Final result will be stored here
	int *dev_c;	// Allocation of device memory done here.

	cudaMalloc((void**)&dev_c, sizeof(int));

	add << <1, 1 >> > (23, 10, dev_c);

	cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);

	printf("Result: %d", c);
	cudaFree(dev_c);
}

__global__ void add(int a, int b, int *c)
{
	*c = a + b;
}
