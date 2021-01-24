#include "fft.h" 
#include <math.h> 
#include <stdlib.h>  
 
void fft_compute(const complex* in, complex* out, const int n) { 
	fft(in, out, n, 1); 
} 
 
void fft(const complex* in, complex* out, const int n, const int s){
	if(n == 1) { 
		out[0] = in[0]; 
	} 

	else {
		const int half = n / 2; 
		fft(in, out, half, 2*s); 
		fft(in+s, out+half, half, 2*s); 
 
		for(int i = 0; i < half; ++i) { 
			const complex e = out[i]; 
			const complex o = out[i + half]; 
			const complex w = cexp(0 - (2. * M_PI * i) / n * I); 
			out[i] = e + w * o; out[i + half] = e - w * o; 
		} 
	} 
}
 
 