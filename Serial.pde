int ESCAPE_CHAR = 0x05;
int FRAME_START = 0x01;
int FRAME_END = 0x0A;

boolean escaped = false;        //true if last character was escape
int[] buffer = new int[100];  //store incoming bytes
int i = 0; 

void byte_in(int b_in){
  if(b_in < 0 || b_in > 255){
    return;
  }
  int b = b_in;
  
  if(escaped){
    if(b == FRAME_START){           //reset buffer
      i = 0;
    } else if(b == FRAME_END){      //buffer is finished, parse data
      parse_buffer();
    } else if(b == ESCAPE_CHAR){    //byte is escape character
      buffer[i] = b;
      i++;
    }
    escaped = false;
    return;
  }
  
  if(b == ESCAPE_CHAR){    //check for escape
    escaped = true;
  } else {
    buffer[i] = b;
    i++;
  }
}

int expected_len = 12;
    
void parse_buffer(){
  if(i != expected_len){  //check if buffer has correct amout of bytes
    println("YIKES");
    return;
  }
  
  println("Data received!");
    
  int k = 0;
  
  state = buffer[k];
  k++;
  
  apps1.percentage = buffer[k];
  k++;
  
  apps2.percentage = buffer[k];
  k++;
  
  brake.percentage = buffer[k];
  k++;
  
  bms_voltage = (256*buffer[k])+buffer[k+1];
  k+=2;
  
  cap_voltage = (256*buffer[k])+buffer[k+1];
  k+=2;
}

void serialEvent (Serial myPort) {
  int b = myPort.read();
  byte_in(b);
}
