// Compile check: KVB_LCD.h must be usable from C++ (extern "C" linkage).
#include "KVB_LCD.h"

void kvb_header_check_cxx()
{
	lsd_Display_Init(LANDSCAPE_RIGHT);
}
