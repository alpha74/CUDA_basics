// Getting information about CUDA

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

int main()
{
	cudaDeviceProp prop;

	int devcount;

	cudaGetDeviceCount(&devcount);

	for (int i = 0; i < devcount; i++)
	{
		cudaGetDeviceProperties(&prop, i);

		printf("\n\n Name: %s", prop.name);
		printf("\n Multiprocessor count: %d", prop.multiProcessorCount);
		printf("\n Clock rate: %d", prop.clockRate);
		printf("\n Compute Cap: %d.%d", prop.major, prop.minor);
	}
}
