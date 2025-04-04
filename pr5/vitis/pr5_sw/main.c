// Incorporación de archivos de cabecera .h
#include "xparameters.h"
#include "xiomodule.h"
#include "pr3hpAXI.h"
#include "xil_printf.h"

#include "aliens.h"
#include "missile.h"
#include "ship.h"

// Definición de constantes globales
const int HD = 1024;
const int VD = 576;
const int SHIP_WIDTH = 64;
const int SHIP_HEIGHT = 64;
const int MISSILE_WIDTH = 8;
const int MISSILE_HEIGHT = 32;
const int ALIENS_WIDTH = 10*64;
const int ALIENS_HEIGHT = 3*64;


// Definición de variables globales
ship_t ship =       {.p_x = (HD / 2) - (SHIP_WIDTH / 2),
		             .p_y = (VD - 1) - SHIP_HEIGHT,
					 .player_left = 0,
					 .player_right = 0,
					 .player_shoot = 0 } ;
missile_t missile = {.p_x = (HD / 2) - (MISSILE_WIDTH / 2),
		             .p_y = (VD - 1) - SHIP_HEIGHT,
					 .shot = 0 };
aliens_t aliens =   {.p_x = 0,
                     .p_y = 0,
                     .dir = 0,
                     .alive[0] = 0x03FF,
                     .alive[1] = 0x03FF,
                     .alive[2] = 0x03FF };


XIOModule iomodule;



// Función ISR_galaxian()
static void ISR_galaxian( void )
{
	// Definición de variables locales
	u8 start = 0;
    u8 sel = 0;
    u8 ship_dead = 0;
    u8 alien_dead = 0;

    typedef enum {
        starting_state,
        playing_state,
        gameover_state
    } game_states;
	static game_states  state = starting_state;

	static u8 game_enable = 0;
	static u8 game_over = 0;
	static u8 rgb_led = 0;
    static u8 score = 0;
	

	// Actualización del valor de las variables asociadas a las señales
	// establecidas en el puerto GPI1 de la instancia iomodule 
	// ship.player_shoot, ship.player_right, ship.player_left, sel, start
	
    // -- Add C code

	
	// Actualización de las funciones de control de los objetos ship,
	// missile y alien
	update_ship_pos ( game_enable, game_over );
	ship_dead = update_aliens_pos ( game_enable, game_over );
    alien_dead = update_missile_pos ( game_enable, game_over );


    // Actualización del estado de la partida
	// state, game_enable, game_over, rgb_led, score 
    switch (state) {
      case starting_state:

	    // -- Add C code
		
        break;
      case playing_state:
	  
	    // -- Add C code
		
		break;
      case gameover_state:
	  
	    // -- Add C code
		
		break;
        }


	// Actualización de las señales en el puerto GPO1 de la instancia
	// iomodule 
	// rgb_led[2:0], score[7:0]
    
	// -- Add C code



	// Actualización de los registros integrados en la interfaz
	// AXI4-Lite Slave del IP pr3hp_v1_0
    // slv_reg0 - ship_y[10:0], ship_x[10:0]
    // slv_reg1 - missile_y[10:0], missile_x[10:0]
    // slv_reg2 - aliens_y[10:0], aliens_x[10:0]
    // slv_reg3 - aliens2_alive[9:0], aliens1_alive[9:0], aliens0_alive[9:0]

	// -- Add C code


}



// Función principal main()
int main()
{
    // Inicialización de la instancia iomodule
	XIOModule_Initialize(&iomodule, XPAR_IOMODULE_0_DEVICE_ID);
    XIOModule_SetOptions(&iomodule, XIN_SVC_ALL_ISRS_OPTION);
    XIOModule_Start(&iomodule);

    // Configuración del controlador de interrupciones
	microblaze_register_handler(XIOModule_DeviceInterruptHandler, XPAR_IOMODULE_0_DEVICE_ID);
    XIOModule_Connect(&iomodule, XIN_IOMODULE_PIT_1_INTERRUPT_INTR, (XInterruptHandler) ISR_galaxian, NULL);
    XIOModule_Enable(&iomodule, XIN_IOMODULE_PIT_1_INTERRUPT_INTR);
    microblaze_enable_interrupts();

    // Inicialización del temporizador programable
    XIOModule_SetResetValue(&iomodule, 0, 500000);
	XIOModule_Timer_SetOptions(&iomodule, 0, XTC_AUTO_RELOAD_OPTION);
    XIOModule_Timer_Start(&iomodule, 0);


    // Bucle infinito
    while (1)
    {

    }

    return 0;
}

