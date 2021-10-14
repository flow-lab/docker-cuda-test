#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <iostream>

// Just for testing
// code from https://stackoverflow.com/questions/13320321/printf-in-my-cuda-kernel-doesnt-result-produce-any-output

__global__
void set1(int *t) {
    t[threadIdx.x] = 1;
}

inline bool failed(cudaError_t error) {
    if (cudaSuccess == error)
        return false;

    fprintf(stderr, "CUDA error: %s\n", cudaGetErrorString(error));
    return true;
}

int main() {
    int blockSize;
    for (blockSize = 1; blockSize < 1 << 12; blockSize++) {
        printf("Testing block size of %d\n", blockSize);
        int *t;
        if (failed(cudaMallocManaged(&t, blockSize * sizeof(int)))) {
            failed(cudaFree(t));
            break;
        }
        for (int i = 0; i < blockSize; i++)
            t[0] = 0;
        set1 <<<1, blockSize>>>(t);
        if (failed(cudaPeekAtLastError())) {
            failed(cudaFree(t));
            break;
        }
        if (failed(cudaDeviceSynchronize())) {
            failed(cudaFree(t));
            break;
        }

        bool hasError = false;
        for (int i = 0; i < blockSize; i++)
            if (1 != t[i]) {
                printf("CUDA error: t[%d] = %d but not 1\n", i, t[i]);
                hasError = true;
                break;
            }
        if (hasError) {
            failed(cudaFree(t));
            break;
        }

        failed(cudaFree(t));
    }
    blockSize--;
    if (blockSize <= 0) {
        printf("CUDA error: block size cannot be 0\n");
        return 1;
    }
    printf("Block maximum size is %d", blockSize);
    return 0;
}