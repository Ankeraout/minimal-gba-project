OUTPUT_ARCH(arm)

SECTIONS
{
    g_romAddress = 0x08000000;
    g_iwramAddress = 0x03000000;
    g_ewramAddress = 0x02000000;

    g_sectionStart_physicalAddress_text = g_romAddress;
    g_sectionStart_romOffset_text = 0x00000000;

    .text g_sectionStart_physicalAddress_text : AT(g_sectionStart_romOffset_text) {
        *(.header)
        . = ALIGN(4);
        *(.text)
        . = ALIGN(4);
        *(.text.startup)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_rodata = g_sectionStart_physicalAddress_text + SIZEOF(.text);
    g_sectionStart_romOffset_rodata = g_sectionStart_romOffset_text + SIZEOF(.text);

    .rodata g_sectionStart_physicalAddress_rodata : AT(g_sectionStart_romOffset_rodata) {
        *(.rodata)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_iwramText = g_iwramAddress;
    g_sectionStart_romOffset_iwramText = g_sectionStart_romOffset_rodata + SIZEOF(.rodata);

    .iwramText g_sectionStart_physicalAddress_iwramText : AT(g_sectionStart_romOffset_iwramText) {
        *(.iwramText)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_iwramRodata = g_sectionStart_physicalAddress_iwramText + SIZEOF(.iwramText);
    g_sectionStart_romOffset_iwramRodata = g_sectionStart_romOffset_iwramText + SIZEOF(.iwramText);

    .iwramRodata g_sectionStart_physicalAddress_iwramRodata : AT(g_sectionStart_romOffset_iwramRodata) {
        *(.iwramRodata)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_iwramData = g_sectionStart_physicalAddress_iwramRodata + SIZEOF(.iwramRodata);
    g_sectionStart_romOffset_iwramData = g_sectionStart_romOffset_iwramRodata + SIZEOF(.iwramRodata);

    .iwramData g_sectionStart_physicalAddress_iwramData : AT(g_sectionStart_romOffset_iwramData) {
        *(.iwramData)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_iwramBss = g_sectionStart_physicalAddress_iwramData + SIZEOF(.iwramData);
    g_sectionStart_romOffset_ewramText = g_sectionStart_romOffset_iwramData + SIZEOF(.iwramData);

    .iwramBss g_sectionStart_physicalAddress_iwramBss : {
        *(.iwramBss)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_ewramText = g_ewramAddress;

    .ewramText g_sectionStart_physicalAddress_ewramText : AT(g_sectionStart_romOffset_ewramText) {
        *(.ewramText)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_ewramRodata = g_sectionStart_physicalAddress_ewramText + SIZEOF(.ewramText);
    g_sectionStart_romOffset_ewramRodata = g_sectionStart_romOffset_ewramText + SIZEOF(.ewramText);

    .ewramRodata g_sectionStart_physicalAddress_ewramRodata : AT(g_sectionStart_romOffset_ewramRodata) {
        *(.ewramRodata)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_ewramData = g_sectionStart_physicalAddress_ewramRodata + SIZEOF(.ewramRodata);
    g_sectionStart_romOffset_ewramData = g_sectionStart_romOffset_ewramRodata + SIZEOF(.ewramRodata);

    .ewramData g_sectionStart_physicalAddress_ewramData : AT(g_sectionStart_romOffset_ewramData) {
        *(.ewramData)
        . = ALIGN(4);
        *(.data)
        . = ALIGN(4);
    }

    g_sectionStart_physicalAddress_ewramBss = g_sectionStart_physicalAddress_ewramData + SIZEOF(.ewramData);

    .ewramBss g_sectionStart_physicalAddress_ewramBss : {
        *(.ewramBss)
        . = ALIGN(4);
        *(.bss)
        . = ALIGN(4);
    }

    g_sectionSize_text = SIZEOF(.text);
    g_sectionSize_rodata = SIZEOF(.rodata);
    g_sectionSize_iwramText = SIZEOF(.iwramText);
    g_sectionSize_iwramRodata = SIZEOF(.iwramRodata);
    g_sectionSize_iwramData = SIZEOF(.iwramData);
    g_sectionSize_iwramBss = SIZEOF(.iwramBss);
    g_sectionSize_ewramText = SIZEOF(.ewramText);
    g_sectionSize_ewramRodata = SIZEOF(.ewramRodata);
    g_sectionSize_ewramData = SIZEOF(.ewramData);
    g_sectionSize_ewramBss = SIZEOF(.ewramBss);

    g_sectionStart_romAddress_text = g_sectionStart_romOffset_text + g_romAddress;
    g_sectionStart_romAddress_rodata = g_sectionStart_romOffset_rodata + g_romAddress;
    g_sectionStart_romAddress_iwramText = g_sectionStart_romOffset_iwramText + g_romAddress;
    g_sectionStart_romAddress_iwramRodata = g_sectionStart_romOffset_iwramRodata + g_romAddress;
    g_sectionStart_romAddress_iwramData = g_sectionStart_romOffset_iwramData + g_romAddress;
    g_sectionStart_romAddress_ewramText = g_sectionStart_romOffset_ewramText + g_romAddress;
    g_sectionStart_romAddress_ewramRodata = g_sectionStart_romOffset_ewramRodata + g_romAddress;
    g_sectionStart_romAddress_ewramData = g_sectionStart_romOffset_ewramData + g_romAddress;
}