// Passing array of a Class and assigning elements at odd/even elements to another array.
// @alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>
#include "stdio.h"

using namespace std;

class Coord
{
	int x;
	int y;

	public:
		Coord() 
		{
			x = 0;
			y = 0;
		}
		void set(int a, int b)
		{
			x = a;
			y = b;
		}
		void print()
		{
			printf(" (%d,%d) ", x, y);
		}
};

__global__ void foo( int lim, Coord C[], Coord *oddi, Coord *eveni)
{
	int tid = blockIdx.x;

	if (tid < lim)
	{
		if (tid % 2 == 0)
		{
			eveni[tid / 2] = C[tid];
		}
		else
		{
			oddi[tid / 2] = C[tid];
		}
	}
}

int main()
{
	const int N = 20;

	// Declare an array of size N
	Coord C[N];
	Coord result_odd[ N/2], result_even[ N/2 ];

	// Initialize the elements
	for (int i = 0; i < N; i++)
	{
		if (i % 2 == 0)
		{
			C[i].set(2, 2);
		}
		else
			C[i].set(-1, -1);
	}

	// Declare and allocate device memory
	Coord *dev_C;
	Coord *dev_odd, *dev_even;

	cudaMalloc((void**)&dev_C, N * sizeof(Coord));
	cudaMalloc((void**)&dev_odd, N / 2 * sizeof(Coord));
	cudaMalloc((void**)&dev_even, N / 2 * sizeof(Coord));

	cudaMemcpy(dev_C, C, N * sizeof(Coord), cudaMemcpyHostToDevice);
	cudaMemcpy(dev_odd, C, N/2 * sizeof(Coord), cudaMemcpyHostToDevice);	// Adding part of the array for comparison.
	cudaMemcpy(dev_even, C, N / 2 * sizeof(Coord), cudaMemcpyHostToDevice);	// Adding part of the array for comparison.

	foo <<<N, 1 >>> ( N, dev_C, dev_odd, dev_even );

	// Copying back the results
	cudaMemcpy(&result_even, dev_even, N/2 * sizeof(Coord), cudaMemcpyDeviceToHost);
	cudaMemcpy(&result_odd, dev_odd, N/2 * sizeof(Coord), cudaMemcpyDeviceToHost);

	cout << "\n At even pos: ";
	for (int i = 0 ; i < N / 2; i++)
	{
		result_even[i].print();
	}

	cout << "\n At odd pos: ";
	for (int i = 0; i < N / 2; i++)
	{
		result_odd[i].print();
	}

	cout << "\n ";

	// Freeing device memory

	cudaFree(dev_C);
	cudaFree(dev_odd);
	cudaFree(dev_even);

	return 0;
}
