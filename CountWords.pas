PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringMod,
  BinTreeSortMod;
VAR
  S: Str;
BEGIN
  WHILE NOT EOF
  DO
    BEGIN
      IF ReadString(INPUT, S)
      THEN
        InsertIntoStorage(S)
    END;
  PrintStorage(OUTPUT);
  FreeStorage()
END.