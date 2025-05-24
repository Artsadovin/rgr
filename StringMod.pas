UNIT StringMod;

INTERFACE
  CONST
    MaxLen = 20;
  
  TYPE
    Str = RECORD 
            S: ARRAY [0 .. MaxLen] OF CHAR;
            Len: INTEGER;
          END;
          
  FUNCTION ReadString(VAR FIn: TEXT; VAR Dest: Str): BOOLEAN;
  PROCEDURE PrintStringWithOccurs(VAR FOut: TEXT; VAR Source: Str; Occurs: INTEGER);
  OPERATOR < (S1, S2: Str) R: BOOLEAN;
IMPLEMENTATION  
  CONST
    Alphabet = 'ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäå¸æçèéêëìíîïðñòóôõö÷øùúûüýþÿABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
              
  FUNCTION IsSymbLetter(Ch: CHAR): BOOLEAN;
  BEGIN
    IsSymbLetter := (Ch IN ['A' .. 'Z']) OR (Ch IN ['À' .. 'ß']) OR (Ch IN ['a' .. 'z']) OR (Ch IN ['à' .. 'ÿ']) OR (Ch = '¸') OR (Ch = '¨')
  END;
  
  FUNCTION IsSymbLegal(Ch: CHAR): BOOLEAN;
  BEGIN
    IsSymbLegal := IsSymbLetter(Ch) OR (Ch = '-')
  END;
  
  PROCEDURE MakeLowerCase(VAR Ch: CHAR);
  BEGIN
    IF (Ch >= 'A') AND (Ch <= 'Z')
    THEN
      Ch := CHR(ORD(Ch) + (ORD('a') - ORD('A')));
    IF (Ch >= 'À') AND (Ch <= 'ß')
    THEN
      Ch := CHR(ORD(Ch) + (ORD('à') - ORD('À')));
    IF Ch = '¨'
    THEN
      Ch := '¸'
  END;
  
  PROCEDURE AddSymb(Ch: CHAR; VAR Dest: Str; VAR I: INTEGER);
  BEGIN
    MakeLowerCase(Ch);
    Dest.S[I] := Ch;
    I := I + 1
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
    WHILE (I < MinLen) AND (Index(Alphabet, S1.S[I]) = Index(Alphabet, S2.S[I])) 
    DO
      I := I + 1;
    IF I < MinLen 
    THEN
      R := (Index(Alphabet, S1.S[I]) < Index(Alphabet, S2.S[I]))
    ELSE
      R := (S1.Len < S2.Len)
  END;
  
  PROCEDURE HandleSymb(VAR Ch: CHAR; VAR Dest: Str; VAR I: INTEGER; VAR State: CHAR);
  BEGIN
    IF State = 'A'
    THEN
      IF IsSymbLetter(Ch)
      THEN
        BEGIN
          AddSymb(Ch, Dest, I);
          State := 'I';
          EXIT
        END
      ELSE 
        Ch := ' ';
      IF State = 'I'
      THEN
        BEGIN
          AddSymb(Ch, Dest, I);
          IF Ch = '-'
          THEN
            State := 'A'
        END;
      IF State = 'S'
      THEN
        IF IsSymbLetter(Ch)
        THEN
          BEGIN
            AddSymb(Ch, Dest, I);
            State := 'I'
          END 
  END;
  
  FUNCTION ReadString(VAR FIn: TEXT; VAR Dest: Str): BOOLEAN;
  VAR
    I: INTEGER;
    Ch, State: CHAR;
  BEGIN
    I := 0;
    Ch := 'a';
    State := 'S';
    WHILE (IsSymbLegal(Ch)) AND (NOT EOF(FIn)) AND (NOT EOLN(FIn)) AND (I < MaxLen)
    DO
      BEGIN
        READ(FIn, Ch);
        IF IsSymbLegal(Ch)
        THEN
          HandleSymb(Ch, Dest, I, State)
        ELSE
          Ch := ' '
      END;
    IF EOLN(FIn) 
    THEN
      READLN(FIn);
    IF State = 'A'
    THEN
      I := I - 1;
    Dest.Len := I;
    ReadString := I > 0
  END;
  PROCEDURE PrintStringWithOccurs(VAR FOut: TEXT; VAR Source: Str; Occurs: INTEGER);
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
    WRITELN(FOut, ' ', Occurs)
  END;
END.
