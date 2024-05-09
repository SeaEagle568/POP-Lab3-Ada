package Semaphores is
   protected type Semaphore (Initial_Count : Integer) is
      entry Wait;
      procedure Signal;
   private
      Count : Integer := Initial_Count;
   end Semaphore;
end Semaphores;
