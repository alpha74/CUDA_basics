// Using function calls inside kernel
// Author: alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>
#include <stdio.h>

using namespace std;

__device__ int fact(int n )
{
	int res = 1;

	for (int i = n; i > 1; i--)
	{
		res = res * i;
	}
	return res;
}

#define size 100

// Calculate factorial of numbers in an array. Using a fact() function.
__global__ void array_fact(int *arr )
{
	int tid = threadIdx.x + blockDim.x * blockIdx.x;

	while (tid < size)
	{
		// Decreasing the number to prevent numbers greater than range.
		arr[tid] = fact(tid/20 + 1 );
		
		tid += gridDim.x * blockDim.x ;
	}

}

int main()
{
	int arr[size];
	int *dev_arr;

	// Allocate array
	cudaMalloc((void **)&dev_arr, size * sizeof(int));

	// Launch kernel
	array_fact << <5, 20 >> > (dev_arr );

	// Wait for GPU execution
	cudaDeviceSynchronize();

	// Copy and print contents
	cudaMemcpy(arr, dev_arr, size * sizeof(int), cudaMemcpyDeviceToHost);

	cout << "\n factorial array: ";
	for (int i = 0; i < size; i++)
	{
		cout << " " << arr[i];
	}

	// Free memory
	cudaFree(dev_arr);
}
