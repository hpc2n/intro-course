#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {

	int x,y,sum;

	if (argc!=3) {
		printf("No numbers given! Please give two numbers.\n");
		exit(1);
	}

	x=atoi(argv[1]);
	y=atoi(argv[2]);
	sum=x+y;

	printf("The sum is: %d\n",sum);

	return 0;
	
}
