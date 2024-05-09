with Ada.Text_IO; use Ada.Text_IO;
with System;

package body Storage is
   function Initialize (Capacity : Positive) return Storage_Access is
   begin
      return new Storage_Type'(
         Queue     => new Item_Queue.Queue (Ceiling => System.Priority'Last),
         Not_Full  => new Semaphores.Semaphore (Capacity),
         Not_Empty => new Semaphores.Semaphore (0),
         Mutex     => new Semaphores.Semaphore (1)
      );
   end Initialize;

   procedure Put_Item (Storage : in out Storage_Type; Item : Items.Item) is
   begin
      Storage.Not_Full.Wait;
      Storage.Mutex.Wait;
      Storage.Queue.Enqueue (Item);
      Put_Line ("Producer " & Item.Produced_By & " has provided an item " & Item.Serial_Number);
      Storage.Mutex.Signal;
      Storage.Not_Empty.Signal;
   end Put_Item;

   procedure Retrieve_Item (Storage : in out Storage_Type; Asker : String) is
      Item_Inst : Items.Item;
   begin
      Storage.Not_Empty.Wait;
      Storage.Mutex.Wait;
      Storage.Queue.Dequeue(Item_Inst);
      Put_Line ("Consumer " & Asker & " has received an item " & Item_Inst.Serial_Number);
      Storage.Mutex.Signal;
      Storage.Not_Full.Signal;
   end Retrieve_Item;
end Storage;
