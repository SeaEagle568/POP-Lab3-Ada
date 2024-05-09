with Storage;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Producer is
   type Unbounded_String_Access is access Unbounded_String;
   task type Producer_Task (Items_Needed : Positive; Name : Unbounded_String_Access; This_Storage : access Storage.Storage_Type) is
   end Producer_Task;
end Producer;
