#include <stdio.h>

int main(int argc, char** argv) {
 	for(int i = 1; i <= 100; i++) {
 		if(i % 3 == 0 && i % 5 == 0){
			printf("Fizzbuzz");
 		}
		else if(i % 3 == 0){
			printf("Fizz");
		}
		else if(i % 5 == 0){
			printf("Buzz");
		}
		else{
			printf("%d", i);
		}
		printf(", ");
	}

	return 0;
}