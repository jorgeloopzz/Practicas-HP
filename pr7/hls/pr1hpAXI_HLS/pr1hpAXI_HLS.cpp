#include "pr1hpAXI_HLS.h"

void pr1hpAXI_HLS(
	ap_uint<8> bin,
	ap_uint<8> *an,
	ap_uint<8> *sseg) {

    #pragma HLS INTERFACE mode=s_axilite port=bin 
    #pragma HLS INTERFACE mode=ap_none port=an
    #pragma HLS INTERFACE mode=ap_none port=sseg
    #pragma HLS INTERFACE mode=s_axilite port=return 


    const ap_uint<8> bcd2disp [] = {(0x03),(0x9F),(0x25),(0x0D),(0x99),(0x49),(0x41),(0x1F),(0x01),(0x19)};
	static ap_uint<8> refresh_count = 0;
    static ap_uint<3> digit = 0;
	ap_uint<8> andispblank = 0xFF;
    ap_uint<8> score_digit[] = {(0x00), (0x00), (0x00)};

	score_digit[0] = ((bin/ap_uint<8>(1))   % ap_uint<8>(10));
    score_digit[1] = ((bin/ap_uint<8>(10))  % ap_uint<8>(10));
    score_digit[2] = ((bin/ap_uint<8>(100)) % ap_uint<8>(10));
		
	if (refresh_count < (N_RATE - 1)) {
		refresh_count++;
	} else {
		refresh_count = 0;
		digit++;
	}
    
	andispblank.set(digit, 0);
	*an = andispblank;

	*sseg = (digit < 3) ? bcd2disp[score_digit[digit]] : ap_uint<8>(0xFF);
}
