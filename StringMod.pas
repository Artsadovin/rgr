UNIT StringMod;
INTERFACE
  CONST
    MaxLen = 20;
  TYPE
    Str = RECORD 
            S: ARRAY [0 .. MaxLen] OF CHAR;
            Len: INTEGER;
            Occurs: INTEGER
          END;
  FUNCTION ReadString(VAR FIn: TEXT; VAR Dest: Str): BOOLEAN;
  PROCEDURE PrintStringWithOccurs(VAR FOut: TEXT; VAR Source: Str);
  FUNCTION IsSymbLegal(Ch: CHAR): BOOLEAN;
  PROCEDURE MakeLowerCase(VAR Ch: CHAR);
  OPERATOR < (S1, S2: Str) R: BOOLEAN;
IMPLEMENTATION
  FUNCTION ReadString(VAR FIn: TEXT; VAR Dest: Str): BOOLEAN;
  VAR
    I: INTEGER;
    Ch: CHAR;
  BEGIN
    I := 0;
    Ch := 'a';
    WHILE (IsSymbLegal(Ch)) AND (NOT EOF(FIn)) AND (NOT EOLN(FIn)) AND (I < MaxLen) AND (IsSymbLegal(Ch))
    DO
      BEGIN
        READ(FIn, Ch);
        IF IsSymbLegal(Ch)//Ch <> ' '
        THEN
          BEGIN
            MakeLowerCase(Ch);
            Dest.S[I] := Ch;
            I := I + 1
          END
        ELSE
          Ch := ' '
      END;
    IF EOLN(FIn) 
    THEN
      READLN(FIn);
    Dest.Len := I;
    Dest.Occurs := 1;
    ReadString := I > 0// AND () 
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
  FUNCTION IsSymbLegal(Ch: CHAR): BOOLEAN;
  BEGIN
    IsSymbLegal := ((Ch >= 'A') AND (Ch <= 'Z')) OR ((Ch >= 'a') AND (Ch <= 'z')) OR (Ch = '-') OR ((Ch >= 'А') AND (Ch <= 'Я')) OR ((Ch >= 'а') AND (Ch <= 'я'))
  END;
  PROCEDURE MakeLowerCase(VAR Ch: CHAR);
  BEGIN
    IF (Ch >= 'A') AND (Ch <= 'Z')
    THEN
      Ch := CHR(ORD(Ch) + (ORD('a') - ORD('A')));
    IF (Ch >= 'А') AND (Ch <= 'Я')
    THEN
      //Ch := CHR(ORD(Ch) + (ORD('а') - ORD('А')))
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
END.