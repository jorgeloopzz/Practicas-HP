#include "psx_control_axi.h"

void psx_control_axi(bool enable,
                     bool *ATT, 
                     bool *SCLK, 
				     bool DAT, 
				     bool *COM,
				     ap_uint<16> *psx_buttons)
{
  #pragma HLS INTERFACE mode=ap_none port=enable
  #pragma HLS INTERFACE mode=ap_none register port=ATT
  #pragma HLS INTERFACE mode=ap_none register port=SCLK
  #pragma HLS INTERFACE mode=ap_none port=DAT
  #pragma HLS INTERFACE mode=ap_none register port=COM
  #pragma HLS INTERFACE mode=s_axilite port=psx_buttons
  #pragma HLS INTERFACE mode=s_axilite port=return

  #pragma HLS PIPELINE II=1


  static enum {IDLE, COMDAT} state = IDLE;
  static ap_uint<10> cycle_counter = 0;
  static ap_uint<4> bit_count = 0;
  static ap_uint<4> byte_count = 0;
  static ap_uint<8> COMdata = 0;
  static ap_uint<16> DATdata = 0;
  static bool sclk_next = 0;
  static ap_uint<16> psx_buttons_next = 0;
			

  switch(state) {
     case IDLE:
	    sclk_next = 1;
	    if (enable == 1) {
	       if (cycle_counter < PSX_NCLK_IDLE) { 
	          *ATT = 1;     
		      cycle_counter++;
	       } else {
	          *ATT = 0;     
              bit_count = 0;
              byte_count = 0;
		      cycle_counter = 0;
		      state = COMDAT;
           }
        }	
        break;	 
     case COMDAT: 
	    if (enable == 1) {
	       if (cycle_counter < PSX_NCLK_COMDAT) {
	          sclk_next = 1;
		      cycle_counter++;
	       } else {
		      COMdata = (byte_count == 0) ? 0x01 : (byte_count == 1) ? 0x42 : 0xFF;
	          sclk_next = !sclk_next;	 
              if (sclk_next == 0) { 
		         *COM = COMdata.test(bit_count);
		      }
              if (sclk_next == 1) { 
                  DATdata = (DATdata << 1) | !DAT;
                 if (++bit_count == 8) {
                     bit_count = 0;
				     cycle_counter = 0;
                     if (++byte_count == 5) { 
                        byte_count = 0;
                        psx_buttons_next = DATdata.reverse();
                        state = IDLE; 
                     }
                 }
              }
		   }				
	    }
        break;	 
  }
  *SCLK = sclk_next;
  *psx_buttons = psx_buttons_next;
}  
