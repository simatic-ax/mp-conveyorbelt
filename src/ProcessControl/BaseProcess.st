USING Simatic.Ax.Dynamics;

NAMESPACE Simatic.Ax.Process
    CLASS INTERNAL BaseProcess
        VAR PUBLIC
            TimeProvider : IElapsedSecondsProvider;
        END_VAR
        VAR PROTECTED
        END_VAR
    END_CLASS
    
    INTERFACE IProcess
        METHOD GetState : ProcessState
        END_METHOD
    END_INTERFACE
    
    TYPE
        ProcessState : (Fill, Unfill) := Fill;
    END_TYPE
END_NAMESPACE
