// Incorporación de archivos de cabecera .h 
#include "xparameters.h"
#include "xiomodule.h"
#include "xpsx_control_axi.h"
#include "xil_printf.h"


// Declaración de variables globales
XIOModule iomodule;
XPsx_control_axi psx_control_axi;


int main()
{
	// Declaración de variables locales
	u32 psx_buttons = 0;

    // Inicialización de la instancia iomodule
	
	   // -- Add C code 

	// Inicialización de la instancia psx_control_axi 

	   // -- Add C code 


    // Bucle infinito
    while (1)
    {
	   // Actualización de la variable asociada al estado del registro 
	   // psx_buttons en la interfaz AXI4-Lite Slave del IP HLS
	   // pr7hpAXI_control 
	      
		  // -- Add C code 

       // Actualización de las señales en el puerto GPO1 de la instancia
       // iomodule 

		  // -- Add C code 

    }

    return 0;
}

