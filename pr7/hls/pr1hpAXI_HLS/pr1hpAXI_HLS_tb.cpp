#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <map>

#include "pr1hpAXI_HLS.h"

using namespace std;

map<ap_uint<8>,int> digit = {
							{0b00000011, 0},
					 		{0b10011111, 1},
					 		{0b00100101, 2},
					 		{0b00001101, 3},
					 		{0b10011001, 4},
					 		{0b01001001, 5},
					 		{0b01000001, 6},
					 		{0b00011111, 7},
					 		{0b00000001, 8},
					 		{0b00001001, 9}
						    };
		

int main () {
    FILE *fp;
	int status = 0;

    fp = fopen("out.dat","w");

    ap_uint<8> bin [] = {5, 25, 150, 250}; // Test inputs
	ap_uint<8> an;
	ap_uint<8> sseg;

	for (int i = 0; i < (sizeof(bin) / sizeof(ap_uint<8>)); i++) {
	   for (int j = 0; j < (8*N_RATE); j++) {
          pr1hpAXI_HLS(bin[i], &an, &sseg);
	      if (j % N_RATE == 0) {
		     printf("%i (0x%02x)\n", digit[sseg], an);
		     fprintf(fp,"%i (0x%02x)\n", digit[sseg], an);
		  }	 
	  }
	}
    fclose(fp);	

	
    printf ("Comparing against output data \n");
    if (system("fc out.dat out_gold.dat")) {
	  printf("*******************************************\n");
	  printf("FAIL: Output DOES NOT match the golden output\n");
	  printf("*******************************************\n");
      status = 1;
    } else {
	  printf("*******************************************\n");
	  printf("PASS: The output matches the golden output!\n");
	  printf("*******************************************\n");
      status = 0;
    }
  
	return status;
}
