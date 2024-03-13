USING Siemens.Simatic.S71500.Clocks;

NAMESPACE Simatic.Ax.Process

    CLASS ThroughputCalculation
        VAR PUBLIC
            Process : IProcess;
        END_VAR
        VAR PROTECTED
            _stateOld : ProcessState;
            _state : ProcessState;
            _newProcessRis : BOOL;
            _measurement : RuntimeMeasurement;
            _time : LREAL;
            _lastCalc : LREAL;
        END_VAR
        
        METHOD PUBLIC Calculate : LREAL
            _state := Process.GetState();
            _newProcessRis := _state = ProcessState#Fill AND NOT(_stateOld = ProcessState#Fill);
            _stateOld := _state;
            IF _newProcessRis THEN
                _measurement.Stop();
                _time := _measurement.GetElapsedSeconds();
                _measurement.Start();
                IF (_time > 0.0) THEN
                    _lastCalc := 60.0 / _time;
                END_IF;
            END_IF;
            Calculate := _lastCalc;
        END_METHOD
    END_CLASS
END_NAMESPACE
