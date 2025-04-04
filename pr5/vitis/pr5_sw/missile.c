#include "missile.h"

u8 update_missile_pos (  u8 game_enable, u8 game_over)
{
   u8 alien_dead = 0;
   if (game_enable == 1) {
      if (missile.shot == 0) {
          missile.p_x = (ship.p_x) + (SHIP_WIDTH / 2) - (MISSILE_WIDTH / 2);
          missile.p_y = (ship.p_y);
    	  if (ship.player_shoot == 1) {
            missile.shot = 1;
         }
      }
      else {
         if (missile.p_y >= 2) {
            alien_dead = check_alien_dead ( );
            if (alien_dead == 0) {
               missile.p_y = (missile.p_y - 2);
            }
            else {
               missile.shot = 0;
            }
         }
         else {
            missile.shot = 0;
         }
      }
   }
   else {
      if (game_over == 0) {
		 missile.p_x = (HD / 2) - (MISSILE_WIDTH / 2),
		 missile.p_y = (VD - 1) - SHIP_HEIGHT, 
         missile.shot = 0;
      }
   }
   return alien_dead;
}

u8 check_alien_dead ( )
{
  u8 alien_dead = 0;
    if (((missile.p_x >= aliens.p_x) &&
         (missile.p_x < (aliens.p_x + ALIENS_WIDTH))) &&
		((missile.p_y >= aliens.p_y) &&
         (missile.p_y <= (aliens.p_y + ALIENS_HEIGHT))))
    {
      u16 alien_r_x = (missile.p_x - aliens.p_x)/(ALIENS_WIDTH/10);
      u16 alien_r_y = (missile.p_y - aliens.p_y)/(ALIENS_HEIGHT/3);
      u16 alive = aliens.alive[alien_r_y];
      if (((alive >> (alien_r_x)) & 0x0001) == 0x0001) {
        alien_dead = 1;
        aliens.alive[alien_r_y] = alive & ~(0x0001 << alien_r_x);
      }
    }
  return alien_dead;
}


