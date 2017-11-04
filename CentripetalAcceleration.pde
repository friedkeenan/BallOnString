class BallOnString{
  PVector loc,vel;
  float rad,accel;
  BallOnString(float speed,float a,float r){
    loc=new PVector(r,0); //Make location starting from an angle of 0
    vel=new PVector(0,speed); //Make velocity tangent to circle and with magnitude speed
    accel=a;
    rad=r;
  }
  void move(){
    PVector acc=PVector.fromAngle(atan2(loc.y,loc.x)); //Make acc angle the angle from the center to location
    acc.setMag(-vel.magSq()/rad); //Set the magnitude to the magnitude of centripetal acceleration, but negative so it seeks the center
    PVector accTan=PVector.fromAngle(vel.heading()); //Set angle of tangent acceleration to the velocity's angle, theoretially tangent to the circle
    accTan.setMag(accel); //Set the magnitude to what was defined at init
    acc.add(accTan); //Add the two accelerations for a net acceleration
    vel.add(acc); //Add the acceleration to velocity
    loc.add(vel); //Add the velocity to location
  }
  void draw(){
    stroke(128);
    line(0,0,loc.x,loc.y); //Draw string
    stroke(0);
    fill(255);
    ellipse(loc.x,loc.y,30,30); //Draw ball
  }
}
BallOnString ball=new BallOnString(5,.1,100); //Initial speed 5, acceleration .1, radius 100
boolean paused=true;
void keyPressed(){
  if(key==' ') //Spacebar toggles pause
    paused=!paused;
}
void setup(){
  size(300,300);
}
void draw(){
  translate(width/2,height/2);
  background(0);
  if(!paused) //Only move the ball if pause is false
    ball.move();
  ball.draw();
}