USING Simatic.Ax.IO.Input;
USING Simatic.Ax.Dynamics;

NAMESPACE Simatic.Ax.Process

    {TestFixture}
    CLASS MyTestFixture 
        VAR PRIVATE
            timeProvider : ConstantTimeProvider := (seconds := 0.02);
            p : ProcessHandler;
            pStateLess : ProcessHandler;
            risingSignalMock : BinSignalRisingEdgeMock;
            fallingSignalMock : BinSignalFallingEdgeMock;
        END_VAR

        {TestSetup}
        METHOD PUBLIC TestSetup
            p := pStateLess;
            p.TimeProvider := timeProvider;
        END_METHOD

        {Test} // This test checks the finished process on rising edge of the next clock signal
        METHOD PUBLIC Process_Finished_OnRisingEdgeOfMachineClock
            p.machineClock := risingSignalMock;
            p.Start();
            AxUnit.Assert.Equal(actual := p.GetState(), expected := ProcessState#Fill);
            p.Execute();
            AxUnit.Assert.Equal(actual := p.GetState(), expected := ProcessState#Unfill);
        END_METHOD
    END_CLASS

    /// Mock the rising edge of the signal
    CLASS BinSignalRisingEdgeMock
        IMPLEMENTS IBinSignal
        VAR
        END_VAR

        METHOD PUBLIC Q : BOOL
            Q := TRUE;
        END_METHOD

        METHOD PUBLIC QRis : BOOL
            QRis := TRUE;
        END_METHOD

        METHOD PUBLIC QFal : BOOL
            QFal := FALSE;
        END_METHOD

        METHOD PUBLIC QBad : BOOL
            QBad := FALSE;
        END_METHOD
    END_CLASS

    /// Mock the falling edge of the signal
    CLASS BinSignalFallingEdgeMock
        IMPLEMENTS IBinSignal
        VAR
        END_VAR

        METHOD PUBLIC Q : BOOL
            Q := FALSE;
        END_METHOD

        METHOD PUBLIC QRis : BOOL
            QRis := FALSE;
        END_METHOD

        METHOD PUBLIC QFal : BOOL
            QFal := TRUE;
        END_METHOD

        METHOD PUBLIC QBad : BOOL
            QBad := FALSE;
        END_METHOD
    END_CLASS

END_NAMESPACE
