{
Name       : Meenatchi Selvaraj
Student ID : 2102767
File       : SensorControl
Brief      : This is an object file that uses 7 functions read values from sensors and stores them

             Functions used:
                1.Start(mainMSVal,mainToF1Add, mainToF2Add, mainUltra1Add, mainultra2Add)
                2.Sensors(mainToF1Add, mainToF2Add, mainUltra1Add, mainultra2Add)
                3.StopCore
                4.Init_ToF
                5.Init_Ultra
                6.ReadUltraSonic(mainUltra1Add, mainultra2Add)
                7.ReadToF(mainToF1Add, mainToF2Add)

}


CON

        ultrascl1 = 6
        ultrascl2 = 8

        ultrasda1 = 7
        ultrasda2 = 9

        tofscl1 = 0
        tofscl2 = 2

        tofsda1 = 1
        tofsda2 = 3

        tofgp1  = 14
        tofgp2  = 15

        tofadd  = $29

VAR
  long  cogStack[256]
  long  cog1ID
  long _Ms_001

OBJ
  ultra         : "EE-7_Ultra_v2.spin"
  ToF[2]        : "EE-7_ToF.spin"

PUB Start(mainMSVal,mainToF1Add, mainToF2Add, mainUltra1Add, mainultra2Add)

  _Ms_001 := mainMSVal
  StopCore

  cog1ID := cognew(Sensors(mainToF1Add, mainToF2Add, mainUltra1Add, mainultra2Add),@cogStack)

  return

PUB Sensors(mainToF1Add, mainToF2Add, mainUltra1Add, mainultra2Add)

  Init_Ultra
  Init_ToF

  repeat
    ReadUltraSonic(mainUltra1Add, mainultra2Add)
    ReadToF(mainToF1Add, mainToF2Add)
    Pause(50)

PUB StopCore

  if cog1ID
    cogstop(cog1ID~)

PUB Init_ToF

  ToF[0].Init(tofscl1, tofsda1, tofgp1)
  ToF[0].ChipReset(1)
  Pause(1000)
  ToF[0].FreshReset(tofadd)
  ToF[0].MandatoryLoad(tofadd)
  ToF[0].RecommendedLoad(tofadd)
  ToF[0].FreshReset(tofadd)

  ToF[1].Init(tofscl2, tofsda2, tofgp2)
  ToF[1].ChipReset(1)
  Pause(1000)
  ToF[1].FreshReset(tofadd)
  ToF[1].MandatoryLoad(tofadd)
  ToF[1].RecommendedLoad(tofadd)
  ToF[1].FreshReset(tofadd)

PUB Init_Ultra

  Ultra.Init(ultrascl1,ultrasda1,0)
  Pause(50)
  Ultra.Init(ultrascl2,ultrasda2,1)

PUB ReadUltraSonic(mainUltra1Add, mainultra2Add)

  long[mainUltra1Add] := Ultra.readSensor(0)
  long[mainultra2Add] := Ultra.readSensor(1)

PUB ReadToF(mainToF1Add, mainToF2Add)

  long[mainToF1Add] := ToF[0].GetSingleRange(tofadd)
  long[mainToF2Add] := ToF[1].GetSingleRange(tofadd)

PRI Pause(ms) | t

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return

DAT

  {
  Ultra.Init(ultrascl1,ultrasda1,0)
  Ultra.Init(ultrascl2,ultrasda2,1)

  ToF[0].Init(tofscl1, tofsda1, tofgp1)
  ToF[0].ChipReset(1)
  Pause(1000)
  ToF[0].FreshReset(tofadd)
  ToF[0].MandatoryLoad(tofadd)
  ToF[0].RecommendedLoad(tofadd)
  ToF[0].FreshReset(tofadd)


  ToF[1].Init(tofscl2, tofsda2, tofgp2)
  ToF[1].ChipReset(1)
  Pause(1000)
  ToF[1].FreshReset(tofadd)
  ToF[1].MandatoryLoad(tofadd)
  ToF[1].RecommendedLoad(tofadd)
  ToF[1].FreshReset(tofadd)

  repeat
    long[mainUltra1Add] := Ultra.readSensor(0)
    long[mainultra2Add] := Ultra.readSensor(1)
    long[mainToF1Add] := ToF[0].GetSingleRange(tofadd)
    long[mainToF2Add] := ToF[1].GetSingleRange(tofadd)
    Pause(50)

  'return   }