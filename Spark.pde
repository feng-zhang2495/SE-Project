class Spark {
  // FIELDS
  float x1,y1,x2,y2,x3,y3,x4,y4;
  float vX,vY;
  color[] sparkColours = {color(255, 182, 41), color(255, 220, 41), color(253, 132, 12)};
  color c;
  float initialTime, currentTime, timeAlive;

  // CONSTRUCTOR
  Spark(float focalX, float focalY) {
    //this.position = p;
    //this.velcoity = c;
    this.x1=focalX+random(-30,30);
    this.y1=focalY+random(-30,30);
    this.x2 = this.x1+random(-20,20);
    this.y2 = this.y1+random(-20,20);
    this.x3 = this.x1+random(-20,20);
    this.y3 = this.y1+random(-20,20);
    this.x4 = this.x1+random(-20,20);
    this.y4 = this.y1+random(-20,20);
    
    int colorIndex = int(random(0,sparkColours.length));
    this.c = sparkColours[colorIndex];
  }

  // METHODS
  // Draws a spark using a random shade of red and a randomly generated quadrilateral
  void drawMe(){
    fill(c);
    noStroke();
    quad(x1,y1,x2,y2,x3,y3,x4,y4);
  }
}
