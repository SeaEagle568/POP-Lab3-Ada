package body Items is
   procedure Initialize_Item (Result_Item : in out Item; Produced_By : String; Serial_Number : Positive) is
   begin
      Result_Item.Produced_By := Produced_By;
      Result_Item.Serial_Number := Produced_By(Produced_By'First + 9) & "#" & Serial_Number'Img;
   end Initialize_Item;
end Items;
