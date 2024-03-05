NAMESPACE Simatic.Ax.Library.Mp
    
    {axcode:docs-v0:@simatic-ax/mp-conveyorbelt:conveyorbelt-class.md}
    /// This class is for demonstration purpose only
    CLASS ConveyorBelt
        
        VAR PUBLIC
        END_VAR

        VAR
        END_VAR

        /// Call this in order to :
        /// initialize the beltconveyor
        METHOD PUBLIC Init
            ;
        END_METHOD
        
        /// Call this in order to :
        /// move the conveyorbelt forward (1) with a static velocity
        METHOD PUBLIC MoveForward
            ;
        END_METHOD

        /// Call this in order to :
        /// move the conveyorbelt backward (0) with a static velocity
        METHOD PUBLIC MoveBackward
            ;
        END_METHOD

        // Call this in order to :
        /// move the conveyorbelt backward (0) with a static velocity
        METHOD PUBLIC MoveToSensor
            ;
        END_METHOD

    END_CLASS

END_NAMESPACE