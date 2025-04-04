#ifndef __ALIENS_H_
#define __ALIENS_H_

#include "xil_types.h"
#include "ship.h"

typedef struct{
    u16 p_x;
    u16 p_y;
    u8  dir;
    u16 alive[3];
}aliens_t;
extern aliens_t aliens;

extern const int HD;
extern const int VD;
extern const int ALIENS_WIDTH;
extern const int ALIENS_HEIGHT;


u8 update_aliens_pos ( u8 game_enable, u8 game_over );

#endif

