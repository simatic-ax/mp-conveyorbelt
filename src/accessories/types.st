NAMESPACE Simatic.Ax.Mp.Types

        /// Basic belt data
        TYPE
            beltData : STRUCT
                speedSP : INT;
                maxSpeed : INT;
                minSpeed : INT;
                length : REAL;
            END_STRUCT;
        END_TYPE
    
        /// Basic conveyor data
        TYPE
            convData : STRUCT
                beltData : beltData;
                name: STRING;
            END_STRUCT;
        END_TYPE

END_NAMESPACE