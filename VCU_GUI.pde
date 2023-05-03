import java.util.Arrays;
import processing.serial.*;

Sensor apps1 = new Sensor("APPS1");
Sensor apps2 = new Sensor("APPS2");
Sensor brake = new Sensor("BRAKE");

int state = 0x03;

void setup(){
  size(400, 300);
  frameRate(20);
}

void draw(){
  background(0);
  
  apps1.percentage+=2; 
  apps2.percentage++;
  brake.percentage+=3;
  cap_voltage += 5;
  if(apps1.percentage > 100){
    apps1.percentage = 0;
    apps2.percentage = 0;
    brake.percentage = 0;
    cap_voltage = 0;
  }
  
  //myPort =  new Serial(this, Serial.list()[0], 115200);
    
  apps1.draw_sensor(50, 54);
  apps2.draw_sensor(150, 54);
  brake.draw_sensor(250, 54);
  
  print_state(20, 250);
  draw_voltages(350, 40);
}
