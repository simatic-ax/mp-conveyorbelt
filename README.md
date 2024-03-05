# @simatic-ax.mp-conveyorbelt

## Description
A conveyor system is a common piece of mechanical handling equipment that moves materials from one location to another. Conveyors are especially useful in applications involving the transport of heavy or bulky materials. Conveyor systems allow quick and efficient transport for a wide variety of materials, which make them very popular in the material handling and packaging industries. They also have popular consumer applications, as they are often found in supermarkets and airports, constituting the final leg of item/ bag delivery to customers. Many kinds of conveying systems are available and are used according to the various needs of different industries. There are chain conveyors (floor and overhead) as well. Chain conveyors consist of enclosed tracks, I-Beam, towline, power & free, and hand pushed trolleys.

## Install this package

Enter:

```cli
apax add @simatic-ax/mp-conveyorbelt
```

## Namespace

```iec-st
Simatic.Ax.Mp;
```

## Objects

## Example

```cli
USING Siemens.Ax.Io.Input;
USING Simatic.Ax.Mp.Conveyor;

CONFIGURATION PLC_1

    TASK Main(Priority := 1);

    PROGRAM P1 WITH Main : SampleProgram;

    VAR_GLOBAL
        aIn AT %I0.0 : BOOL ;
        bIn AT %I0.0 : BOOL ;
        sigA : BinSignal;
        sigB : BinSignal;
        actPos : DINT;
        enc : EncoderAB := (SignalA := sigA, SignalB := sigB);
    END_VAR
    
END_CONFIGURATION

PROGRAM SampleProgram
    VAR_EXTERNAL
        aIn : BOOL ;
        bIn : BOOL ;
        sigA : BinSignal;
        sigB : BinSignal;
        actPos : DINT;
        enc : EncoderAB;
    END_VAR

    sigA.ReadCyclic(signal := aIn);
    sigB.ReadCyclic(signal := bIn);
    enc.Evaluate();
    actPos := enc.GetValue();
END_PROGRAM
```

## Contribution

Thanks for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section or, even better, is free to propose any changes to this repository using Merge Requests.

## License and Legal information

Please read the [Legal information](LICENSE.md)
