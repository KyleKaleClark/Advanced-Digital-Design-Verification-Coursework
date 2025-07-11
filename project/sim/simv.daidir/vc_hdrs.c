#ifndef _GNU_SOURCE
#define _GNU_SOURCE
#endif
#include <stdio.h>
#include <dlfcn.h>
#include "svdpi.h"

#ifdef __cplusplus
extern "C" {
#endif

/* VCS error reporting routine */
extern void vcsMsgReport1(const char *, const char *, int, void *, void*, const char *);

#ifndef _VC_TYPES_
#define _VC_TYPES_
/* common definitions shared with DirectC.h */

typedef unsigned int U;
typedef unsigned char UB;
typedef unsigned char scalar;
typedef struct { U c; U d;} vec32;

#define scalar_0 0
#define scalar_1 1
#define scalar_z 2
#define scalar_x 3

extern long long int ConvUP2LLI(U* a);
extern void ConvLLI2UP(long long int a1, U* a2);
extern long long int GetLLIresult();
extern void StoreLLIresult(const unsigned int* data);
typedef struct VeriC_Descriptor *vc_handle;

#ifndef SV_3_COMPATIBILITY
#define SV_STRING const char*
#else
#define SV_STRING char*
#endif

#endif /* _VC_TYPES_ */

#ifndef __VCS_IMPORT_DPI_STUB_push
#define __VCS_IMPORT_DPI_STUB_push
__attribute__((weak)) int push(/* INPUT */int A_1)
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)(/* INPUT */int A_1) = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)(int A_1)) dlsym(RTLD_NEXT, "push");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_(A_1);
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "push");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_push */

#ifndef __VCS_IMPORT_DPI_STUB_pop
#define __VCS_IMPORT_DPI_STUB_pop
__attribute__((weak)) int pop()
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)() = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)()) dlsym(RTLD_NEXT, "pop");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_();
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "pop");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_pop */

#ifndef __VCS_IMPORT_DPI_STUB_rst_r_ptr
#define __VCS_IMPORT_DPI_STUB_rst_r_ptr
__attribute__((weak)) int rst_r_ptr()
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)() = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)()) dlsym(RTLD_NEXT, "rst_r_ptr");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_();
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "rst_r_ptr");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_rst_r_ptr */

#ifndef __VCS_IMPORT_DPI_STUB_rst_w_ptr
#define __VCS_IMPORT_DPI_STUB_rst_w_ptr
__attribute__((weak)) int rst_w_ptr()
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)() = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)()) dlsym(RTLD_NEXT, "rst_w_ptr");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_();
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "rst_w_ptr");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_rst_w_ptr */

#ifndef __VCS_IMPORT_DPI_STUB_is_empty
#define __VCS_IMPORT_DPI_STUB_is_empty
__attribute__((weak)) int is_empty()
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)() = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)()) dlsym(RTLD_NEXT, "is_empty");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_();
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "is_empty");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_is_empty */

#ifndef __VCS_IMPORT_DPI_STUB_is_full
#define __VCS_IMPORT_DPI_STUB_is_full
__attribute__((weak)) int is_full()
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)() = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)()) dlsym(RTLD_NEXT, "is_full");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_();
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "is_full");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_is_full */

#ifndef __VCS_IMPORT_DPI_STUB_get_r_ptr
#define __VCS_IMPORT_DPI_STUB_get_r_ptr
__attribute__((weak)) int get_r_ptr()
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)() = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)()) dlsym(RTLD_NEXT, "get_r_ptr");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_();
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "get_r_ptr");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_get_r_ptr */

#ifndef __VCS_IMPORT_DPI_STUB_get_w_ptr
#define __VCS_IMPORT_DPI_STUB_get_w_ptr
__attribute__((weak)) int get_w_ptr()
{
    static int _vcs_dpi_stub_initialized_ = 0;
    static int (*_vcs_dpi_fp_)() = NULL;
    if (!_vcs_dpi_stub_initialized_) {
        _vcs_dpi_fp_ = (int (*)()) dlsym(RTLD_NEXT, "get_w_ptr");
        _vcs_dpi_stub_initialized_ = 1;
    }
    if (_vcs_dpi_fp_) {
        return _vcs_dpi_fp_();
    } else {
        const char *fileName;
        int lineNumber;
        svGetCallerInfo(&fileName, &lineNumber);
        vcsMsgReport1("DPI-DIFNF", fileName, lineNumber, 0, 0, "get_w_ptr");
        return 0;
    }
}
#endif /* __VCS_IMPORT_DPI_STUB_get_w_ptr */


#ifdef __cplusplus
}
#endif

