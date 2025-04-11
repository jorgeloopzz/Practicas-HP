#include "ship.h"

void update_ship_pos ( u8 game_enable, u8 game_over )
{
  // Control de las acciones asociadas al objeto ship

  // -- Add C code
	if (game_enable == 1) {

		// Desplazamiento a la derecha
		if (ship.player_right == 1 && (ship.p_x + SHIP_WIDTH) < (HD - 2)) {
				ship.p_x = ship.p_x + 2;
		} else

			// Desplazamiento a la izquierda
			if (ship.player_left == 1 && ship.p_x > 1) {
				ship.p_x = ship.p_x - 2;
			}

	} else {

		// Fin de partida
		if (game_over == 1) {
			ship.p_x = (HD / 2) - (SHIP_WIDTH / 2);
			ship.p_y = (VD - 1) - SHIP_HEIGHT;
			ship.player_right = 0;
			ship.player_left = 0;
			ship.player_shoot = 0;
		}
	}
}
