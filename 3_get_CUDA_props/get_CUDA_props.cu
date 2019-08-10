// Getting information about CUDA Device
// Author: alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

int main()
{
	cudaDeviceProp prop;

	int devcount;
	
	// Returns the number of CUDA devices attached to system
	cudaGetDeviceCount(&devcount);

	// Iterate and fetch the details of each deviceID
	for (int i = 0; i < devcount; i++)
	{
		cudaGetDeviceProperties(&prop, i);

		printf("\n\n Name: %s", prop.name);
		printf("\n Multiprocessor count: %d", prop.multiProcessorCount);
		printf("\n Clock rate: %d", prop.clockRate);
		printf("\n Compute Cap: %d.%d", prop.major, prop.minor);
	}
}
