// Using class members inside device code
// Author: alpha74

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

class Person
{
	private:
		int id;
		int age;
		char citizen_type;

	public:

		// Default ctor
		__host__ __device__ Person()
		{
			id = -1;
			age = -1;
			citizen_type = 'N';
		}

		// Copy ctor
		__host__ __device__ Person(const Person &P)
		{
			id = P.id;
			age = P.age;
			citizen_type = P.citizen_type;
		}

		// Setter
		__host__ __device__ void set(int s_id, int s_age )
		{
			id = s_id;
			age = s_age;
		}

		__host__ __device__ void set_ct(char c)
		{
			citizen_type = c;
		}

		// Display
		__host__ void display()
		{
			cout << "\n ID: " << id << "  Age: " << age << "  Citizen_Type: " << citizen_type;
		}

		// Getter
		__host__ __device__ int get_id()
		{
			return id;
		}

		__host__ __device__ int get_age()
		{
			return age;
		}

		__host__ __device__ char get_ct()
		{
			return citizen_type;
		}

		// Dtor
		__host__ __device__ ~Person()
		{
			;
		}

};

const int N = 100;

// Kernel declaration
__global__ void kernel_set_ct(Person *);
int min(int &, int &);

int main()
{
	Person Public[N];

	// Initialize age and id
	for (int i = 0; i < N; i++)
	{
		Public[i].set(i, min((i * 2 + 10), 89));
	}

	Person *dev_Public;

	// Allocate on device
	cudaMalloc((void **)&dev_Public, N * sizeof(Person));
	// Copy contents
	cudaMemcpy(dev_Public, Public, N * sizeof(Person), cudaMemcpyHostToDevice);

	// Launch kernel
	kernel_set_ct << <5, 10 >> > (dev_Public);

	// Copy back
	cudaMemcpy(Public, dev_Public, N * sizeof(Person), cudaMemcpyDeviceToHost);

	cudaDeviceSynchronize();
	// Display
	cout << "\n Contents: ";

	for (int i = 0; i < N; i++)
	{
		Public[i].display();
	}

	// Deallocate memory
	cudaFree(dev_Public);

	return 0;
}

// Kernel definition
__global__ void kernel_set_ct(Person *Public)
{
	int tid = threadIdx.x + blockDim.x * blockIdx.x;

	// We can also send the limit as a passed argument and then use it, removing the dependency on variable N.
	while (tid < N)
	{
		// Set Citizen type using age:
		int age = Public[tid].get_age();
		char c = 'x';

		// Simple cases
		if (age >= 0 && age <= 12)
			c = 'K';	// Kid

		else if (age >= 13 && age <= 19)
			c = 'T';	// Teen

		else if (age >= 20 && age <= 35)
			c = 'A';	// Adult

		else if (age >= 36 && age <= 55)
			c = 'M';	// Middle

		else
			c = 'S';	// Senior


		// Set
		Public[tid].set_ct(c);

		// Increment tid
		tid += gridDim.x * blockDim.x ;
	}
}

int min(int &a, int &b)
{
	if (a < b)
		return a;
	else
		return b;
}
