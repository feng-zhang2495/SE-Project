class MagnifyingGlass {
  float glassArea;
  String lensQuality;
  float x, y;
  float focalX,focalY;
  float focalLength;
  float radius; //in m
  float numPhotonsHittingGlass; //per second


  MagnifyingGlass(float r, String l, float focalLength) {
    //focal length is in cm
    
    this.radius = r;
    this.glassArea = PI*pow(this.radius,2);
    this.lensQuality = l;
    this.x = 300;
    this.y = 300;
    this.focalX = this.x;
    this.focalLength = focalLength;
    this.focalY = this.y+8*focalLength;
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
    
    else if(this.lensQuality.equals("Impurities")){
      fill(89, 135, 135);
    }
    
    else if(this.lensQuality.equals("Dirty")){
      fill(105, 68, 66);
    }
  }
  
}
