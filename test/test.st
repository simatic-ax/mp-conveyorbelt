USING Simatic.Ax.Mp;

NAMESPACE testConveyors

    {TestFixture}
    CLASS testBelt

        VAR PROTECTED
            myBelt : Belt;
        END_VAR

        {Test}
        METHOD PUBLIC test_initBelt
            VAR_TEMP
                beltDataInOut : types.beltData;
            END_VAR

            beltDataInOut.minSpeed := 1000;
            beltDataInOut.maxSpeed := 8000;
            myBelt.setBeltData(beltData := beltDataInOut);

            AxUnit.Assert.Equal(expected := beltDataInOut.minSpeed, actual := myBelt.getBeltData().minSpeed);
            AxUnit.Assert.Equal(expected := beltDataInOut.maxSpeed, actual := myBelt.getBeltData().maxSpeed);
        END_METHOD

        {Test (inSpeed := 5000, outSpeed := 5000)}
        {Test (inSpeed := -100, outSpeed := 0)}
        {Test (inSpeed := 8500, outSpeed := 0)}
        {Test (inSpeed := 3000, outSpeed := 3500)}
        METHOD PUBLIC test_setSpeed
            VAR_INPUT
                inSpeed : INT;
                outSpeed : INT;
            END_VAR
            VAR_TEMP
                result : types.beltData;
            END_VAR

            THIS.test_initBelt();
            myBelt.setSpeedSP(speedSP := inSpeed);
            AxUnit.Assert.Equal(expected := outSpeed, actual := myBelt.getBeltData().speedSP);
        END_METHOD

    END_CLASS
    
END_NAMESPACE
