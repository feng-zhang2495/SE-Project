class MagnifyingGlass {
  float glassArea;
  float lensQuality;
  float x, y;
	float radius;


  MagnifyingGlass(float r, float g, String l,float x, float y) {
    this.glassArea = 3.14*pow(this.radius,2);
    this.lensQuality = l;
    this.x = 140;
    this.y = 80;
  }

  void drawMe() {
    lensQuality();
    ellipse(150,300,x,y)；
  }

  void lensQuality(){
    if(this.lensQuality == Clear){
      fill(172, 252, 252);
    }
    else if(this.lensQuality == Transparent){
      fill(220, 247, 247);
    }
    else if(this.lensQuality == impurities){
      fill(89, 135, 135);
    }
    else if(this.lensQuality == Vague){
      fill(89, 127, 143);
    }
    
  }
  
}
