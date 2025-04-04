#ifndef __MISSILE_H_
#define __MISSILE_H_

#include "xil_types.h"
#include "aliens.h"
#include "ship.h"

extern const int HD;
extern const int VD;
extern const int MISSILE_WIDTH;
extern const int MISSILE_HEIGHT;

typedef struct{
    u16 p_x;
    u16 p_y;
    u8  shot;
}missile_t;
extern missile_t missile;

u8 update_missile_pos ( u8 game_enable, u8 game_over );
u8 check_alien_dead ( );

#endif

