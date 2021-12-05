{
Name       : Meenatchi Selvaraj
Student ID : 2102767
File       : CommControl
Brief      : This is an object file which uses 3 functions to read input from the zigbee terminal

             Functions used:
                1.Start(rxAdd)
                2.StopCore
                3.Value(rxAdd)

}


CON
  RxPin         = 18  'DOUT
  TxPin         = 19  'DIN
  CommBaud      = 9600

  CommStart     = $7A
  CommStop      = $AA
  CommForward   = $01
  CommReverse   = $02
  CommLeft      = $03
  CommRight     = $04


VAR
  long  cog3ID, _Ms_001, rxVal
  long cogStack[128]

OBJ
  Comm      : "FullDuplexSerial.spin"
  Term      : "FullDuplexSerial.spin"

PUB Start(msVal,rxAdd)


  _Ms_001 := msVal
  StopCore

  cog3ID := cognew(Value(rxAdd),@cogStack)

  return
PUB StopCore

  if cog3ID
    cogstop(cog3ID)

PUB Value(rxAdd)

  Comm.Start(TxPin,RxPin,0,CommBaud)
  Pause(3000)

  repeat
    rxVal := Comm.RxCheck
    if rxVal == CommStart
     repeat
        rxVal := Comm.RxCheck
        case rxVal
          CommForward:
            long[rxAdd] := 1
          CommReverse:
            long[rxAdd] := 2
          CommLeft:
            long[rxAdd] := 3
          CommRight:
            long[rxAdd] := 4
          CommStop:
            long[rxAdd] := 5

PRI Pause(ms) | t
  t := cnt - 1088
  repeat (ms#>0)
    waitcnt(t+=_MS_001)
return