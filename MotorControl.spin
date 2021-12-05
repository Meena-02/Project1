{
Name       : Meenatchi Selvaraj
Student ID : 2102767
File       : MotorControl
Brief      : This is an object file that uses 4 functions to control the movement of wheels

             Functions used:
                1.Start(msVal,para)                     6.Reverse
                2.AllMotors(msVal,para)                 7.TurnLeft
                3.Init                                  8.TurnRight
                4.StopCore
                5.Forward

}


CON

        motor1 = 10
        motor2 = 11
        motor3 = 12
        motor4 = 13

        motor1Zero = 1490 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900
        motor2Zero = 1490 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900
        motor3Zero = 1480 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900
        motor4Zero = 1480 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900

VAR
        long Init1[64]
        long cog2ID
        long _Ms_001

OBJ
   motors      : "Servo8Fast_vZ2.spin"

PUB Start(msVal,MotorAdd1, MotorAdd2, MotorAdd3, MotorAdd4)
{
brief:  this function takes in 2 args and passes them to AllMotors function
parameter: msVal := takes in the _Ms_001 value
           para  := number to control wheels in particular direction
}

  _Ms_001 := msVal
  StopCore

  cog2ID := cognew(Set(MotorAdd1, MotorAdd2, MotorAdd3, MotorAdd4),@Init1)
  return

PUB Set(MotorAdd1, MotorAdd2, MotorAdd3, MotorAdd4)
{
brief: this function takes in 2 args and executes the other functions based on what value the user has entered
para:  the number to control the wheels
}

  Motors.Init
  Motors.AddSlowPin(motor1)
  Motors.AddSlowPin(motor2)
  Motors.AddSlowPin(motor3)
  Motors.AddSlowPin(motor4)
  Motors.Start
  Pause(100)

 repeat
    Motors.Set(motor1, (motor1Zero + long[MotorAdd1]))
    Motors.Set(motor2, (motor2Zero + long[MotorAdd2]))
    Motors.Set(motor3, (motor3Zero + long[MotorAdd3]))
    Motors.Set(motor4, (motor4Zero + long[MotorAdd4]))

PUB StopCore   'this function stops the cog from running

  if cog2ID
   cogstop(cog2ID~)

PRI Pause(ms) | t

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return