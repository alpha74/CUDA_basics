# Steps in Thread Execution

Simple programs to demonstrate the steps in execution of a thread of kernel.

### Observations: 

`steps_in_thread_execution.cu` and `steps_in_thread_execution_multi.cu`

- All single statements are executed in same level.
- The order of execution depends on `tid`.
- On observing printed `tid`, we can note the pattern of execution.


### Conclusions:
- This pattern may be useful in deciding how much variables are to be allocated, eg: Host-Allocated.
