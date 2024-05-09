with Items;

package body Producer is
   task body Producer_Task is
      New_Item : Items.Item;
   begin
      for I in 0 .. (Items_Needed-1) loop
         Items.Initialize_Item (New_Item, To_String (Name.all), I);
         Storage.Put_Item (This_Storage.all, New_Item);
      end loop;
   end Producer_Task;
end Producer;
