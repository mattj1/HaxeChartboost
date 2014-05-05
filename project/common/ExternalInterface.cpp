#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#include <hx/CFFI.h>
#include <stdio.h>

#include "chartboost_common.h"

using namespace chartboost;

static value chartboost_init(value appId, value appSignature) 
{
	#ifdef IPHONE
	Chartboost_Init(val_string(appId), val_string(appSignature));
	#endif

	return alloc_null();
}
DEFINE_PRIM (chartboost_init, 2);

static value chartboost_show_interstitial() 
{
	Chartboost_showInterstitial();

	return alloc_null();
}
DEFINE_PRIM (chartboost_show_interstitial, 0);

// ==================================================================

extern "C" void chartboost_main() 
{
	val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT(chartboost_main);

extern "C" int HaxeChartboost_register_prims() { return 0; }
