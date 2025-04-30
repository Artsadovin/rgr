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
  PROCEDURE FreeTree(Root: PNode);
  PROCEDURE PrintTreeWithOccurs(VAR FOut: TEXT; Root: PNode);
IMPLEMENTATION
  FUNCTION NewNode(Value: Str): PNode;
  BEGIN
    New(NewNode);
    NewNode^.Value := Value;
    NewNode^.Left := NIL;
    NewNode^.Right := NIL
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
END.