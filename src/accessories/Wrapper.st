NAMESPACE Simatic.Ax.Mp
   /// Controls a feed conveyor with one belt and a transport conveyor with two belts
   /// The feed conveyor starts when "start" is TRUE. Transport conveyor starts after "waitTime" is over.
   /// The feed conveyor stops when "stop" is TRUE. Transport conveyor stops after "waitTime" is over.
   FUNCTION_BLOCK equipmentModule
      VAR_INPUT
         /// Start signal
         start             : BOOL;
         /// Stop signal
         stop              : BOOL;
         /// Wait Time in ms before transport conveyor starts after starting feed conveyor
         waitTime          : LTIME;
         /// Conveyor data for feed
         feedConvData      : Types.convData;
         /// Conveyor data for transport
         transportConvData : Types.convData;
      END_VAR
      VAR_OUTPUT
         /// True if conveyor is running
         feedIsRunning      : BOOL;
         /// True if conveyor is running
         transportIsRunning : BOOL;
         /// Shows how much time is left until second belt starts
         waitTimeLeft       : LTIME;
      END_VAR
      VAR
         /// Feed belt
         belt1: Belt;
         /// Transport belt 1
         belt2 : Belt;
         /// Transport belt 2
         belt3 : Belt;
         /// Feed conveyor
         feed                : OneBeltConveyor;
         /// Transport conveyor
         transport           : TwoBeltConveyor;
         /// Internal storage for waiting time
         {S7.extern=ReadWrite}
         waitTimer           : System.Timer.OnDelay;
         /// Init variable
         init                : BOOL := TRUE;
      END_VAR

      IF init THEN
         feed.belt := REF(belt1);         // Assign belts to conveyors
         transport.belt1 := REF(belt2);
         transport.belt2 := REF(belt3);

         belt1.setBeltData(beltData := feedConvData.beltData);       // Set the belt data internally
         belt2.setBeltData(beltData := transportConvData.beltData);
         belt3.setBeltData(beltData := transportConvData.beltData);
         init := FALSE;
      END_IF;

      IF start AND NOT stop THEN
         // START machine
         feed.Run();
         //waitTimer(signal := TRUE, duration := waitTime);
         IF waitTimer.output THEN
            transport.Run();
         END_IF;
      ELSIF stop THEN            
         // STOP machine
         transport.Stop();
         //waitTimer(signal := TRUE, duration := waitTime);
         IF waitTimer.output THEN
            feed.Stop();
         END_IF;
      ELSIF start AND stop THEN
         // Stop everything - invalid state
         feed.Stop();
         transport.Stop();
         //waitTimer(signal := FALSE); // Reset timer
      ELSE
         // Reset time-counter
         //waitTimer(signal := FALSE)
         ;
      END_IF;

      // Copy values to outputs of blocks
      waitTimeLeft := waitTime - waitTimer.elapsedTime;
      feedIsRunning := feed.isOn;
      transportIsRunning := transport.isOn;
   END_FUNCTION_BLOCK
END_NAMESPACE