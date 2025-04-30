PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringMod,
  BinTreeSortMod;
VAR
  S1, S2: Str;
  I: INTEGER;
  Root: PNode;
BEGIN
  Root := NIL;
  FOR I := 1 TO 10
  DO
    BEGIN
      ReadString(INPUT, S1);
      Insert(S1, Root)
    END;
  PrintTreeWithOccurs(OUTPUT, Root);
  FreeTree(Root)
END.