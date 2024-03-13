USING Simatic.Ax.Process;
USING AxUnit.ResultFunctions;
USING System.Strings;
USING Simatic.Ax.Process;

NAMESPACE AxUnit.Assert
    FUNCTION PUBLIC Equal
        VAR_INPUT
            actual : ProcessState;
            expected: ProcessState;
            {CallerFilePath}
            file : WSTRING[1024];
            {CallerLineNumber}
            line : INT;
        END_VAR

        IF actual = expected THEN
            axunit_Succeed();
        ELSE
            axunit_Fail('ProcessState assertion failed', file, line);
        END_IF;

    END_FUNCTION
END_NAMESPACE