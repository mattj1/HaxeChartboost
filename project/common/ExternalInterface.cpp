#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#include <hx/CFFI.h>
#include <stdio.h>

#include "chartboost_common.h"

using namespace chartboost;

// Event handling ===================================================

AutoGCRoot *eventHandler = 0;

static value chartboost_set_event_callback(value onEvent)
{
	eventHandler = new AutoGCRoot(onEvent);
	return alloc_null();
}
DEFINE_PRIM(chartboost_set_event_callback, 1);

extern "C" void chartboost_send_event(const char* type, const char* data)
{
    value o = alloc_empty_object();
    alloc_field(o,val_id("type"),alloc_string(type));

    if (data != NULL) alloc_field(o,val_id("data"),alloc_string(data));

    val_call1(eventHandler->get(), o);
}

// ==================================================================

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
	#ifdef IPHONE
	Chartboost_showInterstitial();
	#endif

	return alloc_null();
}
DEFINE_PRIM (chartboost_show_interstitial, 0);

static value chartboost_start_session()
{
	#ifdef IPHONE
	Chartboost_startSession();
	#endif
	
	return alloc_null();
}
DEFINE_PRIM (chartboost_start_session, 0);

// ==================================================================

extern "C" void chartboost_main() 
{
	val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT(chartboost_main);

extern "C" int HaxeChartboost_register_prims() { return 0; }
