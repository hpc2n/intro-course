#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]) {

	int x,y,result;

	if (argc!=3) {
		printf("No numbers given! Please give two numbers.\n");
		exit(1);
	}

	x=atoi(argv[1]);
	y=atoi(argv[2]);
	result=x*y;

	printf("The result is: %d\n",result);

	return 0;
	
}
