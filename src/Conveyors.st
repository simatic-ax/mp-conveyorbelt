NAMESPACE Simatic.Ax.Mp
   // Conveyors with only one belt
   CLASS OneBeltConveyor IMPLEMENTS IConveyor
      VAR PUBLIC
         belt : REF_TO Belt;
         isOn : BOOL;
      END_VAR

      METHOD PUBLIC Run
         belt^.RunForward();
         isOn := TRUE;
      END_METHOD

      METHOD PUBLIC Stop
         belt^.Stop();
         isOn := FALSE;
      END_METHOD
   END_CLASS

   // Two conveyors - one running forwards, the other one backwards
   CLASS TwoBeltConveyor IMPLEMENTS IConveyor
      VAR PUBLIC
         belt1 : REF_TO Belt;
         belt2 : REF_TO Belt;
         isOn : BOOL;
      END_VAR

      METHOD PUBLIC Run
         belt1^.RunForward();
         belt2^.RunBackward();
         isOn := TRUE;
      END_METHOD

      METHOD PUBLIC Stop
         belt1^.Stop();
         belt2^.Stop();
         isOn := FALSE;
      END_METHOD
   END_CLASS
END_NAMESPACE
