UNIT StorageMod;
         
INTERFACE
  USES
    StringMod;
  PROCEDURE InsertIntoStorage(Value: Str);
  PROCEDURE FreeStorage();
  PROCEDURE PrintStorage(VAR FOut: TEXT);
IMPLEMENTATION
  TYPE
    PNode = ^Node;
    Node = RECORD
             Value: Str;
             Occurs: INTEGER;
             Left: PNode;
             Right: PNode
           END;
           
  VAR
    Root: PNode;
    
  FUNCTION NewNode(Value: Str): PNode;
  VAR
    NewN: PNode;
  BEGIN
    New(NewN);
    NewN^.Value := Value;
    NewN^.Occurs := 1;
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
          Root^.Occurs := Root^.Occurs + 1
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
        PrintStringWithOccurs(FOut, Root^.Value, Root^.Occurs);
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
