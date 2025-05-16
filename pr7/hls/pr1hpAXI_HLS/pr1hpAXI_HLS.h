#ifndef _PR7HP_H_
#define _PR7HP_H_

    #include "ap_int.h"
	
	#define N_RATE   200 
	
    void pr1hpAXI_HLS(ap_uint<8> bin,
	                  ap_uint<8> *an,
	                  ap_uint<8> *sseg
					  );
		 
#endif
