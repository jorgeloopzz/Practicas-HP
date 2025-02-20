#include <stdio.h>
#include "xparameters.h"
#include "xiomodule.h"
#include "xil_printf.h"


int main()
{
	XIOModule gpo;

    int f;
	xil_printf("- pr2hp_platform_sw start\r\n");

	// Initialize XIOModule
    XIOModule_Initialize(&gpo, XPAR_IOMODULE_0_DEVICE_ID);
    XIOModule_Start(&gpo);

	f = 128;
	xil_printf("  f = %d\r\n", f);
	XIOModule_DiscreteWrite(&gpo, 1, (u8) f);

	while (1)
    {
		if (scanf("%d", &f) != EOF) {
    		xil_printf("  f = %d\r\n", f);
        	if ((f > 1) && (f < 256)) {
        		XIOModule_DiscreteWrite(&gpo, 1, (u8) f);
        	}
        	else {
        		xil_printf("  f is not valid (256 > f > 1)\r\n");
        	}

        }
    }

    return 0;
}
