// Using host memory from device kernel
// Author: alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>
#include <stdio.h>

using namespace std;

const int N = 100;

__global__ void add_next(int *a, int *r)
{
	int tid = threadIdx.x + blockDim.x * blockIdx.x;

	if (tid < N)
	{
		if (tid == 0)
			r[tid] = 0;
		else
			r[tid] = a[tid] + a[tid - 1];	// Staggered addition
	}
}

int main()
{
	int *a, *result;
	int *dev_a, *dev_result;

	// Allocate memory on host
	cudaHostAlloc((void**)&a, N * sizeof( int ) ,cudaHostAllocDefault );
	cudaHostAlloc((void**)&result, N * sizeof( int ), cudaHostAllocDefault);

	// Get corresponding Device pointers
	cudaHostGetDevicePointer(&dev_a, a, 0);
	cudaHostGetDevicePointer(&dev_result, result, 0);

	// Initialize the array
	for (int i = 0; i < N; i++)
	{
		a[i] = 1 ;
	}

	// Launch kernel
	add_next << <4, 25 >> > (dev_a, dev_result);

	// Printing result
	cudaDeviceSynchronize();

	cout << "\n\n Result: ";
	for (int i = 0; i < N ; i++)
	{
		cout << "\n " << result[i];
	}

	// Freeing memory
	cudaFreeHost(a);
	cudaFreeHost(result);
}
