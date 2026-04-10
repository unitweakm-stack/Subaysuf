#include <substrate.h>
#include <mach-o/dyld.h>

// Pul funksiyasi
int (*old_get_coins)(void *instance);
int get_coins(void *instance) {
    return 999999999; 
}

// Kalitlar funksiyasi
int (*old_get_keys)(void *instance);
int get_keys(void *instance) {
    return 999999999;
}

static __attribute__((constructor)) void init() {
    // 3.61.0 versiyasi uchun taxminiy offsetlar
    unsigned long coins_offset = 0x1CB2E40; 
    unsigned long keys_offset = 0x1CB2EC0;

    unsigned long base = (unsigned long)_dyld_get_image_header(0);
    
    if (base != 0) {
        MSHookFunction((void *)(base + coins_offset), (void *)get_coins, (void **)&old_get_coins);
        MSHookFunction((void *)(base + keys_offset), (void *)get_keys, (void **)&old_get_keys);
    }
}
