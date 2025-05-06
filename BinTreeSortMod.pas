UNIT BinTreeSortMod;
INTERFACE
  USES
    StringMod;
  TYPE
    Node = RECORD
             Value: Str;
             Left: ^Node;
             Right: ^Node
           END;
    PNode = ^Node;
  FUNCTION NewNode(Value: Str): PNode;
  PROCEDURE Insert(Value: Str; VAR Root: PNode);
  PROCEDURE InsertIntoStorage(Value: Str);
  PROCEDURE FreeTree(Root: PNode);
  PROCEDURE FreeStorage();
  PROCEDURE PrintTreeWithOccurs(VAR FOut: TEXT; Root: PNode);
  PROCEDURE PrintStorage(VAR FOut: TEXT);
IMPLEMENTATION
  VAR
    Root: PNode;
  FUNCTION NewNode(Value: Str): PNode;
  VAR
    NewN: PNode;
  BEGIN
    New(NewN);
    NewN^.Value := Value;
    NewN^.Left := NIL;
    NewN^.Right := NIL;
    NewNode := NewN
  END;
  PROCEDURE Insert(Value: Str; VAR Root: PNode);
  BEGIN
    IF Root = NIL
    THEN
      Root := NewNode(Value)
    ELSE
      IF Value < Root^.Value
      THEN 
        Insert(Value, Root^.Left)
      ELSE
        IF Root^.Value < Value
        THEN
          Insert(Value, Root^.Right)
        ELSE
          Root^.Value.Occurs := Root^.Value.Occurs + 1
  END;
  PROCEDURE InsertIntoStorage(Value: Str);
  BEGIN
    Insert(Value, Root)
  END;
  PROCEDURE FreeTree(Root: PNode);
  BEGIN
    IF Root <> NIL
    THEN
      BEGIN
        FreeTree(Root^.Left);
        FreeTree(Root^.Right);
        Dispose(Root);
        Root := NIL
      END
  END;
  PROCEDURE FreeStorage();
  BEGIN
    FreeTree(Root)
  END;
  PROCEDURE PrintTreeWithOccurs(VAR FOut: TEXT; Root: PNode);
  BEGIN
    IF Root <> NIL
    THEN
      BEGIN
        PrintTreeWithOccurs(FOut, Root^.Left);
        PrintStringWithOccurs(FOut, Root^.Value);
        PrintTreeWithOccurs(FOut, Root^.Right)
      END
  END;
  PROCEDURE PrintStorage(VAR FOut: TEXT);
  BEGIN
    PrintTreeWithOccurs(FOut, Root)
  END;
BEGIN
  Root := NIL
END.