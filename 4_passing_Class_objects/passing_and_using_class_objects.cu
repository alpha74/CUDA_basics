
// Testing class objects passing

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>
#include <stdio.h>

using namespace std;

class Marks
{
	public:
		int m1;
		int m2;

		// Default ctor
		Marks()
		{
			m1 = 0;
			m2 = 0;
		}
};

const int N = 10;

__global__ void add(Marks *A, int * sum)
{
	int tid = blockIdx.x;

	printf("\n blockIdx.x = %d", tid);

	if (tid < N)
	{
		printf("\n tid: %d", tid);
		sum[tid] = A[tid].m1 + A[tid].m2;
	}
}

int main()
{
	Marks A[ N ];
	Marks *dev_A;

	int sum[N];
	int *dev_sum;

	// Device memory
	cudaMalloc((void**)&dev_A, N * sizeof(Marks));
	cudaMalloc((void**)&dev_sum, N * sizeof(int));

	// Setting marks
	for (int i = 0; i < N; i++)
	{
		A[i].m1 = 9;
		A[i].m2 = 8;
	}

	cudaMemcpy(dev_A, A, N * sizeof(Marks), cudaMemcpyHostToDevice);
	add << <N, 1 >> > (dev_A, dev_sum);

	cudaMemcpy(sum, dev_sum, N * sizeof(int), cudaMemcpyDeviceToHost);

	cout << "\n Sums: \n ";
	for (int i = 0; i < N; i++)
		cout << "\n " << i + 1 << ": " << sum[i];
}
