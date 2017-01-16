/* voc 2.1.0 [2016/12/23] for gcc ILP32 on cygwin xtpam */

#define SHORTINT INT8
#define INTEGER  INT16
#define LONGINT  INT32
#define SET      UINT32

#include "SYSTEM.h"
#include "Out.h"


static void (*test_run)(void);
static INT32 (*test_fn)(INT32, INT32*);
static INT32 test_code;
static INT16 test_pc;


static void test_CompileTest (void);
static void test_OpRegRm (INT16 op, INT16 dr, INT16 sr, INT16 off);
static void test_Pop (INT16 r);
static void test_Push (INT16 r);
static void test_Put32 (INT16 i);
static void test_Put8 (INT16 b);
static void test_SimpleTest (void);
static INT32 test_ofn (INT32 i, INT32 *j);

#define test_allocexec(l)	(ADDRESS)mmap(0, l, PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
#include <sys/mman.h>

static void test_SimpleTest (void)
{
	__PUT(test_code, 0xc3, CHAR);
	__PUT((ADDRESS)&test_run, test_code, INT32);
	(*test_run)();
}

static void test_Put8 (INT16 b)
{
	__PUT(test_code + test_pc, (CHAR)__MASK(b, -256), CHAR);
	test_pc += 1;
}

static void test_Put32 (INT16 i)
{
	test_Put8(i);
	i = __ASHR(i, 8);
	test_Put8(i);
	i = __ASHR(i, 8);
	test_Put8(i);
	i = __ASHR(i, 8);
	test_Put8(i);
}

static void test_OpRegRm (INT16 op, INT16 dr, INT16 sr, INT16 off)
{
	INT16 regrm, dispcount;
	if (off < -128 || off >= 128) {
		dispcount = 4;
	} else if (off != 0 || sr == 5) {
		dispcount = 1;
	} else {
		dispcount = 0;
	}
	test_Put8(op);
	switch (dispcount) {
		case 0: 
			regrm = 0;
			break;
		case 1: 
			regrm = 64;
			break;
		default: 
			regrm = 128;
			break;
	}
	regrm += __ASHL(dr, 3);
	regrm += sr;
	test_Put8(regrm);
	if (sr == 4) {
		test_Put8(36);
	}
	switch (dispcount) {
		case 0: 
			break;
		case 1: 
			test_Put8(off);
			break;
		default: 
			test_Put32(off);
			break;
	}
}

static void test_Push (INT16 r)
{
	test_Put8(r + 80);
}

static void test_Pop (INT16 r)
{
	test_Put8(r + 88);
}

static INT32 test_ofn (INT32 i, INT32 *j)
{
	return i + *j;
}

static void test_CompileTest (void)
{
	INT32 i, j, k;
	test_pc = 0;
	test_OpRegRm(139, 0, 4, 4);
	test_OpRegRm(139, 3, 4, 8);
	test_OpRegRm(3, 0, 3, 0);
	test_Put8(195);
	__PUT((ADDRESS)&test_fn, test_code, INT32);
	i = 5;
	j = 7;
	k = test_ofn(i, &j);
	k = (*test_fn)(i, &j);
}


export int main(int argc, char **argv)
{
	__INIT(argc, argv);
	__MODULE_IMPORT(Out);
	__REGMAIN("test", 0);
/* BEGIN */
	test_code = test_allocexec(1024);
	test_SimpleTest();
	test_CompileTest();
	__FINI;
}
