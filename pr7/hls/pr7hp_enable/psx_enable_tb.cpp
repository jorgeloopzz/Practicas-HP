#include <stdio.h>
#include <stdlib.h>
#include "psx_enable.h"


int main() {
    FILE *fp;
	int status = 0;

    fp = fopen("out.dat","w");
	bool enable;

	for (int i = 0; i <(4 * PSX_ENABLE_PERIOD); i++) {
		psx_enable(&enable);
        printf("%i", enable);
        fprintf(fp,"%i", enable);
	}
    printf("\n");
    fprintf(fp,"\n");
    fclose(fp);

    printf("Comparing against output data \n");
    if (system("fc out.dat out_gold.dat")) {
	  fprintf(stdout, "*******************************************\n");
	  fprintf(stdout, "FAIL: Output DOES NOT match the golden output\n");
	  fprintf(stdout, "*******************************************\n");
      status = 1;
    } else {
	  fprintf(stdout, "*******************************************\n");
	  fprintf(stdout, "PASS: The output matches the golden output!\n");
	  fprintf(stdout, "*******************************************\n");
      status = 0;
    }
  
	return status;
}
