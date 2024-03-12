USING Simatic.Ax.Dynamics;

NAMESPACE Simatic.Ax.Controller

    FUNCTION_BLOCK TController
        VAR_INPUT
            TimeProvider : IElapsedSecondsProvider;
            setpoint : LREAL;
        END_VAR
        VAR_OUTPUT
            output : LREAL;
        END_VAR
        VAR
            actualValue : LREAL;
            calculated : LREAL;
        END_VAR
        VAR_TEMP
            delta : LREAL;
            dt : LREAL;
        END_VAR
        dt := TimeProvider.GetElapsedSeconds();
        dt := 0.02;
        delta := setpoint - actualValue;
        actualValue := actualValue + delta * dt;
        output := actualValue;
        ;
    END_FUNCTION_BLOCK

END_NAMESPACE
