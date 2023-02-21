# Steps in Thread Execution

Simple programs to demonstrate the steps in execution of a thread of kernel.

### Observations: 

- [steps_in_thread_execution.cu](https://github.com/alpha74/CUDA_basics/blob/master/9_steps_of_thread_execution/steps_in_thread_execution.cu)
- [steps_in_thread_execution_multi.cu](https://github.com/alpha74/CUDA_basics/blob/master/9_steps_of_thread_execution/steps_in_thread_execution_multi.cu)

- All single statements are executed in same level.
- The order of execution depends on `tid`.
- On observing printed `tid`, we can note the pattern of execution.


### Conclusions:
- This pattern may be useful in deciding how much variables are to be allocated, eg: Host-Allocated.
