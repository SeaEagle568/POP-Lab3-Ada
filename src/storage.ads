with Items;
with Ada.Containers.Synchronized_Queue_Interfaces;
with Ada.Containers.Unbounded_Synchronized_Queues;
with Semaphores;

package Storage is
   package Item_Queues is new Ada.Containers.Synchronized_Queue_Interfaces
     (Element_Type => Items.Item);
   package Item_Queue is new Ada.Containers.Unbounded_Synchronized_Queues (Queue_Interfaces => Item_Queues);

   type Storage_Type is limited private;
   type Storage_Access is access Storage_Type;

   function Initialize (Capacity : Positive) return Storage_Access;
   procedure Put_Item (Storage : in out Storage_Type; Item : Items.Item);
   procedure Retrieve_Item (Storage : in out Storage_Type; Asker : String);

private
   type Semaphore_Access is access Semaphores.Semaphore;
   type Queue_Access is access Item_Queue.Queue;

   type Storage_Type is record
      Queue : Queue_Access;
      Not_Full : Semaphore_Access;
      Not_Empty : Semaphore_Access;
      Mutex : Semaphore_Access;
   end record;
end Storage;
