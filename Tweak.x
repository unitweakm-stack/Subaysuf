#include <substrate.h>
#include <mach-o/dyld.h>

// Pul funksiyasini almashtiramiz
int (*old_get_coins)(void *instance);
int get_coins(void *instance) {
    return 9999999; // Siz xohlagan pul miqdori
}

static __attribute__((constructor)) void init() {
    // 0x123456 o'rniga haqiqiy offset qo'yiladi
    // Hozirgi Subway Surfers versiyasi uchun offsetni topishingiz kerak
    unsigned long offset = 0x123456; 
    unsigned long base = (unsigned long)_dyld_get_image_header(0);
    
    MSHookFunction((void *)(base + offset), (void *)get_coins, (void **)&old_get_coins);
}
