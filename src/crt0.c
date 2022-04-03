// =============================================================================
// File inclusion
// =============================================================================
#include <stddef.h>
#include <stdint.h>

// =============================================================================
// Private function declarations
// =============================================================================
/**
 * @brief Performs platform initialization.
 *
 * @details Copies the .ewramData and .iwramData sections to EWRAM and IWRAM
 *          respectively, and clears out .ewramBss and .iwramBss sections.
 */
static void init(void);

/**
 * @brief Performs memory copy.
 *
 * @details This function is optimized and will only work with word-aligned
 *          memory blocks with a word-aligned size.
 *
 * @param[out] p_dst The destination buffer.
 * @param[in] p_src The source buffer.
 * @param[in] p_n The number of bytes to copy.
 */
static void _memcpy(void *p_dst, const void *p_src, size_t p_n);

/**
 * @brief Sets all bytes in the destination buffer to the value of p_c.
 *
 * @details This function is optimized and will only work with word-aligned
 *          memory blocks with a word-aligned size.
 *
 * @param[out] p_dst The destination buffer.
 * @param[in] p_c The byte.
 * @param[in] p_n The number of bytes to set in the destination buffer.
 */
static void _memset(void *p_dst, int p_c, size_t p_n);

// =============================================================================
// Extern function declarations
// =============================================================================
extern void main(void);

// =============================================================================
// Extern symbol declarations
// =============================================================================
extern int g_sectionStart_virtualAddress_iwram;
extern int g_sectionStart_virtualAddress_iwramBss;
extern int g_sectionStart_virtualAddress_ewram;
extern int g_sectionStart_virtualAddress_ewramBss;
extern int g_sectionStart_romAddress_iwram;
extern int g_sectionStart_romAddress_ewram;
extern int g_sectionSize_iwram;
extern int g_sectionSize_iwramBss;
extern int g_sectionSize_ewram;
extern int g_sectionSize_ewramBss;

// =============================================================================
// Public function definitions
// =============================================================================
void _start(void) {
    init();
    main();
}

// =============================================================================
// Private function definitions
// =============================================================================
static void init(void) {
    // Copy .iwram section
    _memcpy(
        &g_sectionStart_virtualAddress_iwram,
        &g_sectionStart_romAddress_iwram,
        (size_t)&g_sectionSize_iwram
    );

    // Copy .ewram section
    _memcpy(
        &g_sectionStart_virtualAddress_ewram,
        &g_sectionStart_romAddress_ewram,
        (size_t)&g_sectionSize_ewram
    );

    // Clear .iwramBss section
    _memset(
        &g_sectionStart_virtualAddress_iwramBss,
        0,
        (size_t)&g_sectionSize_iwramBss
    );

    // Clear .ewramBss section
    _memset(
        &g_sectionStart_virtualAddress_ewramBss,
        0,
        (size_t)&g_sectionSize_ewramBss
    );
}

static void _memcpy(void *p_dst, const void *p_src, size_t p_n) {
    size_t l_nbWords = p_n >> 2;
    uint32_t *l_dst = (uint32_t *)p_dst;
    uint32_t *l_src = (uint32_t *)p_src;

    for(size_t l_i = 0; l_i < l_nbWords; l_i++) {
        l_dst[l_i] = l_src[l_i];
    }
}

static void _memset(void *p_dst, int p_c, size_t p_n) {
    size_t l_nbWords = p_n >> 2;
    uint32_t *l_dst = (uint32_t *)p_dst;

    uint32_t l_value = p_c;
    l_value |= (l_value << 8);
    l_value |= (l_value << 16);

    for(size_t l_i = 0; l_i < l_nbWords; l_i++) {
        l_dst[l_i] = l_value;
    }
}
