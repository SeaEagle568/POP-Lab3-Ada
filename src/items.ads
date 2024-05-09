package Items is
   type Item is tagged record
      Produced_By : String (1 .. 10);
      Serial_Number : String (1 .. 4);
   end record;

   procedure Initialize_Item (Result_Item : in out Item; Produced_By : String; Serial_Number : Integer);
end Items;
