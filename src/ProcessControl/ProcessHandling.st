USING Simatic.Ax.IO.Input;
USING Simatic.Ax.Generators;
USING Simatic.Ax.Controller;

NAMESPACE Simatic.Ax.Process

    CLASS ProcessHandler
        EXTENDS BaseProcess IMPLEMENTS IProcess
        VAR PUBLIC
            setpoint : LREAL;
            machineClock : IBinSignal;
        END_VAR
        VAR PROTECTED
            _MachineClock : PulseGenerator := (PulseTime := T#400ms, PauseTime := T#1200ms);
            _ProcessController : TController;
            _actualValue : LREAL;
            _clock : BOOL;
            _processStarted : BOOL;
            _actualSetpoint : LREAL;
            _state : ProcessState;
        END_VAR
        /// Returns the setpoint for the process
        METHOD PUBLIC GetSetPoint : LREAL
            GetSetPoint := _actualSetpoint;
        END_METHOD
        /// Returns the actual value of the ppocess
        METHOD PUBLIC GetActualValue : LREAL
            GetActualValue := _actualValue;
        END_METHOD

        /// Returns the current state of the process
        METHOD PUBLIC GetState : ProcessState
            GetState := _state;
        END_METHOD

        /// Returns the process clock
        METHOD PUBLIC GetClock : BOOL
            GetClock := _clock;
        END_METHOD
        /// Start the Process
        METHOD PUBLIC Start
            _processStarted := TRUE;
            _actualSetpoint := setpoint;
        END_METHOD
        /// Returns true, when the procsess has been finished.
        /// A started Process is finished, on the next rising 
        /// edge of the machine clock.
        METHOD PUBLIC ProcessFinished : BOOL
            
            IF (machineClock.QRis() AND _processStarted) THEN
                ProcessFinished := TRUE;
                _processStarted := FALSE;
                RETURN;
            END_IF;
            ProcessFinished := FALSE;
        END_METHOD

        METHOD PUBLIC Execute
            // If no external machine clock, use the internal? 
            IF (machineClock = NULL) THEN
                machineClock := _MachineClock;
            END_IF;
            CASE _state OF
                ProcessState#Fill:
                    THIS.Start();
                    IF (THIS.ProcessFinished()) THEN
                        _state := ProcessState#Unfill;
                    END_IF;
                ProcessState#Unfill:
                    _actualSetpoint := 0.0;
                    IF (_MachineClock.QRis()) THEN
                        _state := ProcessState#Fill;
                    END_IF;
            END_CASE;
            _clock := _MachineClock.Q();
            // if the process has finished, 
         
            _MachineClock.Execute();
            _ProcessController(TimeProvider := TimeProvider, setpoint := _actualSetpoint, output => _actualValue);
        END_METHOD
    END_CLASS



END_NAMESPACE

