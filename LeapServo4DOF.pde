/*
arduino_servo
 
 Demonstrates the control of servo motors connected to an Arduino board
 running the StandardFirmata firmware.  Moving the mouse horizontally across
 the sketch changes the angle of servo motors on digital pins 4 and 7.  For
 more information on servo motors, see the reference for the Arduino Servo
 library: http://arduino.cc/en/Reference/Servo
 
 To use:
 * Using the Arduino software, upload the StandardFirmata example (located
 in Examples > Firmata > StandardFirmata) to your Arduino board.
 * Connect Servos to digital pins 4 and 7.  (The servo also needs to be
 connected to power and ground.)
 
 */

import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

// LEAP libraries
import de.voidplus.leapmotion.*;
LeapMotion leap;

int panPin = 4;
int tiltPin = 7;

void setup() {
  size(800, 500, P3D);
  background(255);
  noStroke();
  fill(50);

  // New leap object
  leap = new LeapMotion(this);


  // Prints out the available serial ports.
  println(Arduino.list());

  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[2], 57600);

  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  //arduino = new Arduino(this, "/dev/tty.usbmodem621", 57600);

  // Configure digital pins 4 and 7 to control servo motors.
  arduino.pinMode(4, Arduino.SERVO);
  arduino.pinMode(7, Arduino.SERVO);
}

void draw() {
  background(255);

  // Leap magic
  int fps = leap.getFrameRate();

  // Clean LEAP Hand position
  for (Hand hand : leap.getHands()) {

    hand.draw();
    PVector hand_position = hand.getPosition();

    // Get LEAP values
    int panVal = 0;
    int tiltVal = 0; 

    panVal = (int) map(hand.getPosition().x, 0, 700, 170, 1);
    tiltVal = (int) map(hand.getPosition().y, 0, 500, 1, 170);

    // Write an value to the servos, telling them to go to the corresponding
    // angle (for standard servos) or move at a particular speed (continuous
    // rotation servos).

    arduino.servoWrite(panPin, panVal);
    arduino.servoWrite(tiltPin, tiltVal);
    delay(10);
  }
}

void leapOnInit() {
  // println(“Leap Motion Init”);
}
void leapOnConnect() {
  // println(“Leap Motion Connect”);
}
void leapOnFrame() {
  // println(“Leap Motion Frame”);
}
void leapOnDisconnect() {
  // println(“Leap Motion Disconnect”);
}
void leapOnExit() {
  // println(“Leap Motion Exit”);
}

