// Demonstrates the steps in thread execution. Here less threads are launched than needed.
// Author: alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <iostream>

using namespace std;

__global__ void kernel()
{
	int tid = threadIdx.x + blockDim.x * blockIdx.x;

	while (tid < 20)  // 5 threads are launched and 20 jobs are to be done.
	{

		int a;
		printf("\n [ %d ] Declared a.", tid);

		int b;
		printf("\n [ %d ] Declared b.", tid);

		a = 9;
		printf("\n [ %d ] Initialized a.", tid);

		b = 8;
		printf("\n [ %d ] Initialized b.", tid);


		tid += gridDim.x * blockDim.x;
	}
}

int main()
{
	// Launch kernel
	kernel << <1, 5 >> > ();
}
