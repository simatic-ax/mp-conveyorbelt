NAMESPACE Simatic.Ax.xxx
    USING AxUnit.Assert;
    
    NAMESPACE Simatic.Ax.Test
    
        {TestFixture}
        CLASS test22
    
            {Test}
            METHOD PUBLIC MyMethod
                 // write your test code here
                 Equal(expected := TRUE, actual := TRUE);
                ;
            END_METHOD
        END_CLASS
    END_NAMESPACE
END_NAMESPACE