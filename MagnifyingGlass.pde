class MagnifyingGlass {
  float glassArea;
  String lensQuality;
  float x, y;
  float focalX,focalY;
  float radius; //in m
  float numPhotonsHittingGlass; //per second


  MagnifyingGlass(float r, String l,float xVal, float yVal, float focalLength) {
    //focal length is in cm
    
    this.radius = r;
    this.glassArea = PI*pow(this.radius,2);
    this.lensQuality = l;
    this.x = xVal;
    this.y = yVal;
    this.focalX = xVal;
    this.focalY = yVal+8*focalLength;
    this.numPhotonsHittingGlass = this.glassArea*photonsPerMetersSquared;
    //println(width,this.x,this.y);
  }

  void drawMe() {
    
    fill(0);
    noStroke();
    rect(this.x-radius*4000, this.y-5, 100, 10);
    lensQuality();
    ellipse(this.x, this.y,this.radius*4000,30);
    }

  void lensQuality(){
    if(this.lensQuality.equals("Clear")){
      fill(172, 252, 252);
    }
    else if(this.lensQuality.equals("Transparent")){
      fill(220, 247, 247);
    }
    else if(this.lensQuality.equals("Impurities")){
      fill(89, 135, 135);
    }
    else if(this.lensQuality.equals("Vague")){
      fill(89, 127, 143);
    }
  }
  
}
