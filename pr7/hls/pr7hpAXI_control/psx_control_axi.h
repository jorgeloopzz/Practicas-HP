#ifndef _PSX_H_
#define _PSX_H_

   #include "ap_int.h"

   #define PSX_NCLK_IDLE   500
   #define PSX_NCLK_COMDAT 10
 
   void psx_control_axi(bool enable,
                        bool *ATT, 
                        bool *SCLK, 
                        bool DAT, 
                        bool *COM,
                        ap_uint<16> *psx_buttons);
				 
#endif
