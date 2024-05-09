package body Consumer is
   task body Consumer_Task is
   begin
      for I in 1 .. Items_Needed loop
         Storage.Retrieve_Item(This_Storage.all, To_String (Name.all));
      end loop;
   end Consumer_Task;
end Consumer;
