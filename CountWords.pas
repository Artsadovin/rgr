PROGRAM CountWords(INPUT, OUTPUT);
USES
  StringMod,
  BinTreeSortMod;
VAR
  S1: Str;
  Root: PNode;
BEGIN
  Root := NIL;
  WHILE NOT EOF
  DO
    BEGIN
      IF ReadString(INPUT, S1)
      THEN
        Insert(S1, Root)
    END;
  PrintTreeWithOccurs(OUTPUT, Root);
  FreeTree(Root)
END.