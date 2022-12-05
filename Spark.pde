class Spark {
  // FIELDS
  float x1,y1,x2,y2,x3,y3,x4,y4;
  float vX,vY;
  color[] sparkColours = {color(255, 182, 41), color(255, 220, 41), color(253, 132, 12)};
  color c;

  // CONSTRUCTOR
  Spark(float focalX, float focalY) {
    //this.position = p;
    //this.velcoity = c;
	this.x1=focalX;
    this.y1=focalY;
    this.x2 = this.x1+random(-5,5);
    this.y2 = this.y1+random(-5,0);
    this.x3 = this.x1+random(-5,5);
    this.y3 = this.y1+random(-5,5);
	this.x4 = this.x1+random(-5,5);
    this.y4 = this.y1+random(-5,0);
    this.vX=random(-1,1);
    this.vY=random(-5,-1);
	this.c = color(255, 182, 41);
  }

  // METHODS

//color[] flameSparkColours = new color[2] //4 shades of orange/yellow

void drawMe(){
  //quad()
  //flames
  //pick a random shade of orange
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

