#ifndef __INC_COMMON_H__
#define __INC_COMMON_H__

// =============================================================================
// Public macro definitions
// =============================================================================
#define M_IWRAM_INITIALIZED_VAR __attribute__((section(".iwramData")))
#define M_IWRAM_CONST_VAR __attribute__((section(".iwramRodata")))
#define M_IWRAM_UNINITIALIZED_VAR __attribute__((section(".iwramBss")))
#define M_IWRAM_FUNCTION __attribute__((section(".iwramText")))

#define M_EWRAM_INITIALIZED_VAR __attribute__((section(".ewramData")))
#define M_EWRAM_CONST_VAR __attribute__((section(".ewramRodata")))
#define M_EWRAM_UNINITIALIZED_VAR __attribute__((section(".ewramBss")))
#define M_EWRAM_FUNCTION __attribute__((section(".ewramText")))

#endif
