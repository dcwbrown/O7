/* voc 2.1.0 [2016/12/23] for gcc ILP32 on cygwin xtpam */

#define SHORTINT INT8
#define INTEGER  INT16
#define LONGINT  INT32
#define SET      UINT32

#include "SYSTEM.h"
#include "Out.h"


static void (*test_run)(void);
static INT32 test_code;



#define test_allocexec(l)	(ADDRESS)mmap(0, l, PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
#include <sys/mman.h>


export int main(int argc, char **argv)
{
	__INIT(argc, argv);
	__MODULE_IMPORT(Out);
	__REGMAIN("test", 0);
/* BEGIN */
	test_code = test_allocexec(1);
	__PUT(test_code, 0xc3, CHAR);
	__PUT((ADDRESS)&test_run, test_code, INT32);
	(*test_run)();
	__FINI;
}
