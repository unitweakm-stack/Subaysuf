#include <substrate.h>
#include <mach-o/dyld.h>

int (*old_get_coins)(void *instance);
int get_coins(void *instance) {
    return 999999999; 
}

static __attribute__((constructor)) void init() {
    // DIQQAT: 0x123456 o'rniga o'yin versiyasiga mos offsetni qo'ying
    unsigned long offset = 0x123456; 
    unsigned long base = (unsigned long)_dyld_get_image_header(0);
    
    MSHookFunction((void *)(base + offset), (void *)get_coins, (void **)&old_get_coins);
}
