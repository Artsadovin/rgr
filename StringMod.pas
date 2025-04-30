UNIT StringMod;
INTERFACE
  CONST
    MaxLen = 10;
  TYPE
    Str = RECORD 
            S: ARRAY [0 .. MaxLen] OF CHAR;
            Len: INTEGER;
            Occurs: INTEGER
          END;
  PROCEDURE ReadString(VAR FIn: TEXT; VAR Dest: Str);
  PROCEDURE PrintStringWithOccurs(VAR FOut: TEXT; VAR Source: Str);
  OPERATOR < (S1, S2: Str) R: BOOLEAN;
  OPERATOR = (S1, S2: Str) R: BOOLEAN;
IMPLEMENTATION
  PROCEDURE ReadString(VAR FIn: TEXT; VAR Dest: Str);
  VAR
    I: INTEGER;
    Ch: CHAR;
  BEGIN
    I := 0;
    Ch := 'a';
    WHILE (Ch <> ' ') AND (NOT EOF(FIn)) AND (NOT EOLN(FIn)) AND (I < MaxLen)
    DO
      BEGIN
        READ(FIn, Ch);
        IF Ch <> ' '
        THEN
          Dest.S[I] := Ch;
        I := I + 1
      END;
    IF EOLN(FIn) 
    THEN
      READLN(FIn);
    Dest.Len := I;
    Dest.Occurs := 1
  END;
  PROCEDURE PrintStringWithOccurs(VAR FOut: TEXT; VAR Source: Str);
  VAR
    I: INTEGER;
  BEGIN
    I := 0;
    WHILE (I < Source.Len) AND (I < MaxLen)
    DO
      BEGIN
        WRITE(FOut, Source.S[I]);
        I := I + 1
      END;
    WRITELN(FOut, ' ', Source.Occurs)
  END;
  OPERATOR < (S1, S2: Str) R: BOOLEAN;
  VAR
    I, MinLen: INTEGER;
  BEGIN
    MinLen := S1.Len;
    IF S2.Len < MinLen 
    THEN 
      MinLen := S2.Len;
    I := 0;
    WHILE (I < MinLen) AND (S1.S[I] = S2.S[I]) 
    DO
      I := I + 1;
    IF I < MinLen 
    THEN
      R := (S1.S[I] < S2.S[I])
    ELSE
      R := (S1.Len < S2.Len)
  END;
  OPERATOR = (S1, S2: Str) R: BOOLEAN;
  VAR
    I: INTEGER;
  BEGIN
    R := TRUE;
    IF S1.Len <> S2.Len 
    THEN
      R := FALSE
    ELSE
      FOR I := 0 TO S1.Len - 1 
      DO
        IF S1.S[I] <> S2.S[I] 
        THEN
          R := FALSE
  END;
END.