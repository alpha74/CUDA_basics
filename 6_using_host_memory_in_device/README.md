# cudaHostAlloc()
### Using Host memory in Device

This function allows to use host memory for computations in device kernel.

## Steps of usage:
1. Declare int pointers, one for host, and other for device.
2. Use cudaHostAlloc() for allocation memory using host pointer.
3. Use **cudaHostGetDevicePointer() to get corresponding pointer in device memory, to be stored in device pointer**.
4. Initialize the vector(or anything) using host pointer normally.
5. Launch the kernel using the corresponding device pointer.
6. Free host memory after usage using **cudaFreeHost( host_pointer )**.

- It will look like this:
```
// Declare pointers
int *a ;
int *dev_a ;

// Allocate on host
cudaHostAlloc( (void**)&a, size * sizeof( int ), cudaHostAllocDefault ) ;
// Some other flags: cudaHostAllocWriteCombined | cudaHostAllocMapped 

// Get corresponding Device pointer
cudaHostGetDevicePointer( &dev_a, a, 0 )

// Initialize memory normally 
...

// Launch  kernel 
...
...

// Free memory
cudaFreeHost( a ) ;
```


## malloc() vs cudaHostAlloc():
- cudaHostAlloc() works like **malloc()**.
- malloc() allocates standard pageable host memory.
- cudaHostAlloc() allocates page-locked host memory, i.e, the memory page will never will swapped out.

## Caution:
- Its usage will opt out the features of virtual memory.
- System can run out of memory faster, as buffers can never be swapped to disk.
- Applications can fail on system having small amount of physical memory.
- Performance of other applications in the system maybe affected.
