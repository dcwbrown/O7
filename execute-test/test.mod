MODULE test;

IMPORT Out, SYSTEM;

CONST
  eax = 0;  ebx = 3;  ecx = 1;  edx = 2;
  esi = 6;  edi = 7;  ebp = 5;  esp = 4;

  (* The following instructions act on 32 bits. Clear bit
     zero and they will act on 8 bits. *)
  load  = 8BH;  store = 89H;
  add   = 03H;  or    = 0BH;  adc   = 13H;  sbb   = 1BH;
  and   = 23H;  sub   = 2BH;  xor   = 33H;


VAR
  run:  PROCEDURE;
  fn:   PROCEDURE(i: LONGINT; VAR j: LONGINT): LONGINT;
  code: SYSTEM.ADDRESS;
  pc:   INTEGER;


PROCEDURE -includemmap "#include <sys/mman.h>";
PROCEDURE -allocexec(l: SYSTEM.ADDRESS): SYSTEM.ADDRESS
  "(ADDRESS)mmap(0, l, PROT_EXEC|PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)";

PROCEDURE SimpleTest;
BEGIN
  SYSTEM.PUT(code, CHR(0C3H)); (* Near return *)
  SYSTEM.PUT(SYSTEM.ADR(run), code);
  run
END SimpleTest;

PROCEDURE Put8(b: INTEGER);
BEGIN SYSTEM.PUT(code+pc, CHR(b MOD 256)); INC(pc)
END Put8;

PROCEDURE Put32(i: INTEGER);
BEGIN
  Put8(i); i := i DIV 256;
  Put8(i); i := i DIV 256;
  Put8(i); i := i DIV 256;
  Put8(i)
END Put32;

(* 32 bit memory access: eax, ebc, ecx, edx, esi, edi *)
PROCEDURE Op32(op, dr, sr, off: INTEGER);
(* op:    dr :=  dr op [sr+off] *)
(* load:  dr := [sr+off]        *)
(* store: [sr+off] := dr        *)
VAR regrm: INTEGER; dispcount : INTEGER;
BEGIN
  IF (off < -128) OR (off >= 128) THEN dispcount := 4
  ELSIF (off # 0) OR (sr = ebp)   THEN dispcount := 1
  ELSE dispcount := 0
  END;
  Put8(op);
  CASE dispcount OF 0: regrm := 0 | 1: regrm := 40H ELSE regrm := 80H END;
  INC(regrm, dr*8);
  INC(regrm, sr);
  Put8(regrm); IF sr = esp THEN Put8(24H) END;
  CASE dispcount OF 0: (* no disp *) | 1: Put8(off) ELSE Put32(off) END
END Op32;

(* 16 bit memory access: ax, bx, cx, dx, si, di *)
PROCEDURE Op16(op, dr, sr, off: INTEGER);
BEGIN Put8(66H); Op32(op, dr, sr, off)
END Op16;

(* 8 bit memory access: al, bl, cl, dl. Also ah,bh,ch,dh by specifying esp,ebp,esi,edi. *)
PROCEDURE Op8(op, dr, sr, off: INTEGER);
BEGIN Op32(op-1, dr, sr, off)  (* * bit ops have bottom bit clear. Only works for al, bl, cl, dl. *)
END Op16;



PROCEDURE Push(r: INTEGER); BEGIN Put8(r + 50H) END Push;
PROCEDURE Pop (r: INTEGER); BEGIN Put8(r + 58H) END Pop;

PROCEDURE ofn(i: LONGINT; VAR j: LONGINT): LONGINT;
BEGIN RETURN i+j END ofn;

PROCEDURE CompileTest;
VAR i, j, k: LONGINT;
BEGIN
  pc := 0;
  Op32(load, eax, esp, 4); (* Load first value *)
  Op32(load, ebx, esp, 8); (* Load address of second value *)
  Op32(add,  eax, ebx, 0); (* Add eax,[ebx] *)
  Put8(0C3H);                 (* Ret *)

  SYSTEM.PUT(SYSTEM.ADR(fn), code);
  i := 5; j:= 7;
  k := ofn(i, j);
  k := fn(i, j)
END CompileTest;


BEGIN
  code := allocexec(1024);
  SimpleTest;
  CompileTest;
END test.
