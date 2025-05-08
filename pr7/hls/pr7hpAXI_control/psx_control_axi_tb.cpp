#include <stdio.h>
#include <stdlib.h>
#include "psx_control_axi.h"

#define PSX_NBITS 5*8
#define PSX_NCLK  PSX_NCLK_IDLE + 5*(PSX_NCLK_COMDAT + 8*2)
#define PSX_DAT_INPUT "in.dat"


class psx_control_sim {
private:
    ap_uint<PSX_NBITS> response;
    ap_uint<6> bit_counter;
    
public:
    psx_control_sim() : bit_counter(0) {}
   
    void set_response(ap_uint<16> psx_buttons) {
        response = (0xFF415A0000 | psx_buttons); 
    }
    
    ap_uint<1> clock_data(ap_uint<1> ATT, ap_uint<1> SCLK, ap_uint<1> COM) {
        static ap_uint<1> last_SCLK = 1;
        ap_uint<1> DAT_out = 1;
        
        if(ATT == 0) {
            if(last_SCLK == 1 && SCLK == 0) {
                if(bit_counter < PSX_NBITS) {
                    DAT_out = response[(PSX_NBITS - 1) - bit_counter];
                    bit_counter++;
                }
            }
            if(bit_counter >= PSX_NBITS) {
                bit_counter = 0;
            }
        } else {
            bit_counter = 0;
        }   
        last_SCLK = SCLK;
        return DAT_out;
    }
};


int main() {
    FILE *fp_in;
    FILE *fp_out;
    fp_in = fopen(PSX_DAT_INPUT,"r");
    fp_out = fopen("out.dat","w");
	int status = 0;
	
    bool ATT, SCLK, COM, DAT;
    bool enable = 1;
    int psx_buttons_in;
    ap_uint<16> psx_buttons;

    const int num_tests = 5;
    ap_uint<16> test_pattern[num_tests];
	
    psx_control_sim psx_sim;
    
	
    for(int test = 0; test < num_tests; test++) {   
   fscanf(fp_in,"0x%04X\n", &psx_buttons_in);
   test_pattern[test] = ap_uint<16>(psx_buttons_in);
   
        psx_sim.set_response(test_pattern[test].reverse()); // LSB first
        
        for(int i = 0; i <= PSX_NCLK; i++) {
            DAT = psx_sim.clock_data(ATT, SCLK, COM);
	        psx_control_axi(enable, &ATT, &SCLK, DAT, &COM, &psx_buttons);
        }
        psx_buttons.b_not();
        printf("0x%04X\n", psx_buttons);   
        fprintf(fp_out,"0x%04X\n", psx_buttons);
    }
    fclose(fp_in);	
    fclose(fp_out);	


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

