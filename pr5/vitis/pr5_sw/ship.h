#ifndef __SHIP_H_
#define __SHIP_H_

#include "xil_types.h"

typedef struct{
    u16 p_x;
    u16 p_y;
    u8  player_left;
    u8  player_right;
    u8  player_shoot;
}ship_t;
extern ship_t ship;

extern const int HD;
extern const int VD;
extern const int SHIP_WIDTH;
extern const int SHIP_HEIGHT;

void update_ship_pos ( u8 game_enable, u8 game_over );

#endif
