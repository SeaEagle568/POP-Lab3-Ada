with Storage;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Consumer is
   type Unbounded_String_Access is access Unbounded_String;
   task type Consumer_Task (Items_Needed : Positive; Name : Unbounded_String_Access; This_Storage : access Storage.Storage_Type) is
   end Consumer_Task;
end Consumer;
