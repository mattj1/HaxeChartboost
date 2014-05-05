#ifndef CHARTBOOST_COMMON_H
#define CHARTBOOST_COMMON_H

namespace chartboost 
{   
    extern "C"
    {   
        void Chartboost_Init(const char *appID, const char *appSignature);
        
        void Chartboost_showInterstitial();
    }
}

#endif