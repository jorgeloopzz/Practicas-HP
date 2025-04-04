#include "aliens.h"

u8 update_aliens_pos ( u8 game_enable, u8 game_over )
{
   u8 i;
   u8 aliens_change_dir = 0;
   u8 ship_dead = 0;
   if (game_enable == 1) {
	  if (aliens.dir == 0) {    // right
		  if (( aliens.p_x + ALIENS_WIDTH ) < ( HD - 1 ) ) {
		     aliens.p_x++;
		  }
		  else {
            aliens.p_x--;
            aliens.dir = 1;
			aliens_change_dir = 1;
		  }
	  }
      else {                     // left
		 if (( aliens.p_x ) > 0 ) {
		    aliens.p_x--;
		 }
         else {
            aliens.p_x++;
            aliens.dir = 0;
			aliens_change_dir = 1;
		 }
      }
      
	  if (aliens_change_dir != 0) {
         for (i = 2; i >= 0; i--) {
            if ((aliens.alive[i] & 0x03FF) != 0x0000) {
               if ((aliens.p_y + ((i + 1)*(ALIENS_HEIGHT/3)) + (ALIENS_HEIGHT/3)/2) < (ship.p_y)) {
                  aliens.p_y = aliens.p_y + (ALIENS_HEIGHT/3)/2;
               }
               else {
                  ship_dead = 1;
               }
               break;
            }
	     }
	  }	 
   }
   else {
       if (game_over == 0) {
	      aliens.dir = 0;
		  aliens.p_x = 0;
		  aliens.p_y = 0;
		  for (u8 i=0; i<3; i++) {
			 aliens.alive[i] = 0x03FF;
		  }
       }
   }
   return ship_dead;
}
