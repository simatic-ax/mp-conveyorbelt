NAMESPACE Simatic.Ax.Mp
    CLASS Belt
        VAR PUBLIC
            isRunning : INT;    // 0: stopped, 1: forward, -1: backwards
            isStopped : BOOL;   // True if belt is stopped
        END_VAR
        VAR PRIVATE
            _beltData : types.beltData;     // Store belt data internally
        END_VAR

        METHOD PUBLIC RunForward      
            isRunning := THIS.getSpeedSP();
            isStopped := FALSE;
        END_METHOD
        METHOD PUBLIC RunBackward
            isRunning := -1 * THIS.getSpeedSP();
            isStopped := FALSE;
        END_METHOD
        METHOD PUBLIC Stop
            isRunning := 0;
            isStopped := TRUE;
        END_METHOD

        /// GET / SET Belt-Data
        METHOD PUBLIC setBeltData
            VAR_INPUT
                beltData : types.beltData;
            END_VAR
            _beltData := beltData;
        END_METHOD

        METHOD PUBLIC getBeltData : types.beltData
            getBeltData := _beltData;
        END_METHOD

        /// GET / SET Speed
        METHOD PRIVATE getSpeedSP : INT
            getSpeedSP := _beltData.speedSP;
        END_METHOD
        METHOD PUBLIC setSpeedSP
            VAR_INPUT
                speedSP : INT;
            END_VAR
        
            IF speedSP >= _beltData.minSpeed AND speedSP <= _beltData.maxSpeed THEN
                _beltData.speedSP := speedSP;
            END_IF;
        END_METHOD
    END_CLASS
END_NAMESPACE