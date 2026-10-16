/* Compile check: KVB_LCD.h must be self-contained in C. */
#include "KVB_LCD.h"

void kvb_header_check_c(void)
{
	lsd_Display_Init(LANDSCAPE_RIGHT);
}
