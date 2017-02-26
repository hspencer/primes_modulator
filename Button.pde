
////////////////button/////////////

class Button{

  float xpos;
  float ypos;
  float xdim;
  float ydim;
  boolean over;
  boolean press;
  String label;
  color hover;
  color pressed;

  Button(String txt, float x, float y){
    label = txt;
    xpos = x;
    ypos = y;
    textFont(pixelfont, 8);

    xdim = textWidth(label) + 10;
    ydim = textAscent() + textDescent() + 10;
  }

  void update(){
    if ((mouseX > xpos) && (mouseX < xpos+xdim) && (mouseY > ypos) && (mouseY < ypos+ydim)){
      over = true;  
    }
    else{
      over = false;
    }
  }

  void render(){
    textFont(pixelfont, 8);
    this.update();
    stroke(200);
    fill(255,200);
    if (over) {
      fill(255,0,0,70);
    } 
    if (press){
      drawVicto(xpos+xdim+6, ypos+6);
    }
    strokeWeight(1);
    rect(xpos, ypos, xdim, ydim);
    textAlign(CENTER);
    fill(0);

    text(label, xpos+xdim/2, ypos+14);
    strokeWeight(1);
  }
}

void drawVicto(float xpos, float ypos){
  noFill();
  stroke(255,0,0);
  strokeWeight(1);
  beginShape();
  vertex(xpos, ypos+5);
  vertex(xpos+3, ypos+8);
  vertex(xpos+12, ypos-4);
  endShape();
  stroke(200);
}