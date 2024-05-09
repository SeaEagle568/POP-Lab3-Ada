with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Storage;
with Consumer;
with Producer;

function Main return Integer is
   Capacity : Positive;
   Total_Items : Positive;
   Consumers : Positive;
   Producers : Positive;
   
   Storage_Instance : access Storage.Storage_Type;
   
   type Consumer_Access is access Consumer.Consumer_Task;
   type Producer_Access is access Producer.Producer_Task;

   procedure Extract_From_Stdin (Ask : String; Min_Value : Positive; Max_Value : Positive; Result : out Integer) is
   begin
      loop
         Put (Ask);
         begin
            Get (Result);
            exit when Result in Min_Value .. Max_Value;
            Put_Line ("Invalid value. Please try again.");
         exception
            when Data_Error =>
               Put_Line ("Not a number. Please try again.");
               Skip_Line;
         end;
      end loop;
   end Extract_From_Stdin;

   function Get_Producer_Name (Index : Positive) return String is
      Character_Offset : constant Character := Character'Val (Character'Pos ('A') + Index - 1);
   begin
      return "Producer " & Character_Offset;
   end Get_Producer_Name;
   
   procedure Generate_Producers_And_Consumers (Consumers : Positive; Producers : Positive; Total_Items : Positive) is
   begin
      for I in 1 .. Consumers loop
         declare
            Items_Needed : constant Positive := Total_Items / Consumers;
            Consumer_Name : constant Consumer.Unbounded_String_Access := new Unbounded_String'(To_Unbounded_String ("Consumer" & Positive'Image (I)));
            Consumer_Task : Consumer_Access := new Consumer.Consumer_Task(Items_Needed, Consumer_Name, Storage_Instance);
         begin
			null;
         end;
      end loop;

      for I in 1 .. Producers loop
         declare
            Items_Needed : constant Positive := Total_Items / Producers;
            Producer_Name : constant Producer.Unbounded_String_Access := new Unbounded_String'(To_Unbounded_String (Get_Producer_Name(i)));
			Producer_Task : Producer_Access := new Producer.Producer_Task(Items_Needed, Producer_Name, Storage_Instance);
         begin
			null;
         end;
      end loop;
   end Generate_Producers_And_Consumers;
  
begin
   Extract_From_Stdin ("Enter the storage capacity (1 to 1000): ", 1, 1000, Capacity);
   Extract_From_Stdin ("Enter the total number of items (1 to 1000): ", 1, 1000, Total_Items);
   Extract_From_Stdin ("Enter the number of consumers (1 to 10): ", 1, 10, Consumers);
   if Total_Items mod Consumers /= 0 then 
      Put_Line("Error! Total item is not divisible by consumers quantity! Please try again with correct values");
	  return 1;
   end if;
   Extract_From_Stdin ("Enter the number of producers (1 to 10): ", 1, 10, Producers);
  if Total_Items mod Producers /= 0 then 
      Put_Line("Error! Total item is not divisible by producers quantity! Please try again with correct values");
	  return 1;
   end if;
   Storage_Instance := Storage.Initialize (Capacity);
   Put_Line("Storage initialized");
   Generate_Producers_And_Consumers (Consumers, Producers, Total_Items);
   return 0;
end Main;
