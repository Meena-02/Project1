{
Name       : Meenatchi Selvaraj
Student ID : 2102767
File       : MyLiteKit
Brief      : This is uses 5 functions to control and move the litekit

             Functions used:
                1.Main
                2.ForwardAndCheck
                3.ReverseAndCheck
                4.LeftAndCheck
                5.RightAndCheck

}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _Ms_001 = _ConClkFreq / 1_000

        ultrasafe = 500
        tofsafe   = 200

VAR
  long  mainToFVal1, mainToFVal2, mainUltraVal1, mainUltraVal2
  long mot1, mot2, mot3, mot4
  long rxAdd

OBJ
  Sensor         : "SensorControl.spin"
  MotorCtrl      : "MotorControl.spin"
  Comm           : "CommControl.spin"

PUB Main

  Comm.Start(_Ms_001, @rxAdd)
  Sensor.Start(_Ms_001, @mainToFVal1, @mainToFVal2, @mainUltraVal1, @mainUltraVal2)
  MotorCtrl.Start(_Ms_001,@mot1, @mot2, @mot3, @mot4)

  repeat
    case rxAdd
      1:
        if((mainUltraVal1 > ultrasafe) and mainToFVal1 < 250)
          Forward
        elseif((mainUltraVal1 < ultrasafe) or  mainToFVal1 > 250)
          StopAllMotors

      2:
        if((mainUltraVal2 > ultrasafe) and mainToFVal2 < 250)
          Reverse
        elseif((mainUltraVal2 < ultrasafe) or  mainToFVal2 > 250)
          StopAllMotors

      3:
        TurnLeft

      4:
        TurnRight

      5:
        StopAllMotors

PUB Forward

  mot1 := 150
  mot2 := 150
  mot3 := -150
  mot4 := -150


PUB Reverse

  mot1 := -150
  mot2 := -150
  mot3 := 150
  mot4 := 150

PUB TurnLeft

  mot1 := -150
  mot2 := 150
  mot3 := 150
  mot4 := -150

PUB TurnRight

  mot1 := 150
  mot2 := -150
  mot3 := -150
  mot4 := 150

PUB StopAllMotors

  mot1 := 0
  mot2 := 0
  mot3 := 0
  mot4 := 0
PRI Pause(ms) | t

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return