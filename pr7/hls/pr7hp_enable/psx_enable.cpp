#include "psx_enable.h"

void psx_enable(bool *enable) {
   #pragma HLS INTERFACE ap_none port=enable
   #pragma HLS INTERFACE ap_ctrl_none port=return

   #pragma HLS PIPELINE II=1

	static ap_uint<8> counter = 0;

	if (counter < (PSX_ENABLE_PERIOD - 1)) {
		counter++;
		*enable = 0;
	} else {
		counter = 0;
		*enable = 1;
	}
}
	
