PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringMod,
  StorageMod;
VAR
  S: Str;
  Amount: INTEGER;
BEGIN
  Amount := 0;
  WHILE NOT EOF
  DO
    BEGIN
      IF ReadString(INPUT, S)
      THEN
        BEGIN
          InsertIntoStorage(S);
          Amount := Amount + 1
        END
    END;
  PrintStorage(OUTPUT);
  WRITELN(OUTPUT, 'Количество слов: ', Amount);
  FreeStorage()
END.
