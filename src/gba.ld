OUTPUT_ARCH(arm)

MEMORY {
    rom (rx) : ORIGIN = 0x08000000, LENGTH = 32M
    iwram (rwx) : ORIGIN = 0x03000000, LENGTH = 32k
    ewram (rwx) : ORIGIN = 0x02000000, LENGTH = 256k
}

SECTIONS
{
    .rom 0x08000000 : AT(0x00000000) {
        *(.header)
        . = ALIGN(4);
        *(.text*)
        . = ALIGN(4);
        *(.rodata*)
        . = ALIGN(4);
    } > rom = 0xff

    g_sectionStart_virtualAddress_iwram = 0x03000000;
    g_sectionStart_linearAddress_iwram = LOADADDR(.rom) + SIZEOF(.rom);
    g_sectionStart_romAddress_iwram = g_sectionStart_linearAddress_iwram + 0x08000000;

    .iwram g_sectionStart_virtualAddress_iwram : AT(g_sectionStart_linearAddress_iwram) {
        *(.iwramText*)
        . = ALIGN(4);
        *(.iwramRodata*)
        . = ALIGN(4);
        *(.iwramData*)
        . = ALIGN(4);
    } > iwram = 0xff

    g_sectionStart_virtualAddress_iwramBss = ADDR(.iwram) + SIZEOF(.iwram);

    .iwramBss g_sectionStart_virtualAddress_iwramBss (NOLOAD) : {
        *(.iwramBss*)
        . = ALIGN(4);
    } AT > iwram

    g_sectionStart_virtualAddress_ewram = 0x02000000;
    g_sectionStart_linearAddress_ewram = LOADADDR(.iwram) + SIZEOF(.iwram);
    g_sectionStart_romAddress_ewram = g_sectionStart_linearAddress_ewram + 0x08000000;

    .ewram g_sectionStart_virtualAddress_ewram : AT(g_sectionStart_linearAddress_ewram) {
        *(.ewramText*)
        . = ALIGN(4);
        *(.ewramRodata*)
        . = ALIGN(4);
        *(.ewramData*)
        . = ALIGN(4);
    } > ewram = 0xff

    g_sectionStart_virtualAddress_ewramBss = ADDR(.ewram) + SIZEOF(.ewram);

    .ewramBss g_sectionStart_virtualAddress_ewramBss (NOLOAD) : {
        *(.ewramBss*)
        . = ALIGN(4);
        *(.bss*)
        . = ALIGN(4);
    } AT > ewram

    g_sectionSize_iwram = SIZEOF(.iwram);
    g_sectionSize_iwramBss = SIZEOF(.iwramBss);
    g_sectionSize_ewram = SIZEOF(.ewram);
    g_sectionSize_ewramBss = SIZEOF(.ewramBss);

    /DISCARD/ : {
        *(*)
    }
}
