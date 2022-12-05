class Smoke {
  //FIELDS
  float x1,y1,x2,y2,x3,y3;
  float vX,vY;
  color c;
  color[] smokeColours = {color(50),color(100),color(150),color(200)};

  //CONSTRUCTOR
  Smoke(float focalX, float focalY){
    this.x1=focalX;
    this.y1=focalY;
    this.x2 = this.x1+random(-5,5);
    this.y2 = this.y1+random(-5,0);
    this.x3 = this.x1+random(-5,5);
    this.y3 = this.y1+random(-5,5);
    this.vX=random(-1,1);
    this.vY=random(-5,-1);
    this.c = color(100);

  }
  //METHODS
  void drawMe(){
    triangle(x1,y1,x2,y2,x3,y3);
  }

  void updatePos(){
    this.x1 += this.vX;
    this.y1 += this.vY;
    this.x2 += this.vX;
    this.y2 += this.vY;
    this.x3 += this.vX;
    this.y3 += this.vY; 
  }
}