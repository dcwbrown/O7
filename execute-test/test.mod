MODULE test;

IMPORT Out, SYSTEM;

VAR
  run: PROCEDURE;
  code: SYSTEM.ADDRESS;


PROCEDURE -includemmap "#include <sys/mman.h>";
PROCEDURE -allocexec(l: SYSTEM.ADDRESS): SYSTEM.ADDRESS
  "(ADDRESS)mmap(0, l, PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)";

BEGIN
  code := allocexec(1);
  SYSTEM.PUT(code, CHR(0C3H)); (* Near return *)
  SYSTEM.PUT(SYSTEM.ADR(run), code);
  run;
END test.
