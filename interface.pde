
/* /////////////////////////////////////////////////////////////////////////////
 
 Structure knobs:
 
 + rot: rotation of the segments
 + a: the poligonal coeficient that determines the form of the spiral
 + b: alternative shaper knob
 + total: determines the lenght (int ints) of the longest side of the spiral
 
 Visual knobs:
 
 + spacing: the lenght of the sitcks, equivalent to scaling
 + scl: the scale of the dot
 + b: the aspect ratio of the dot
 + alfa: the opacity of the spiral
 
 /////////////////////////////////////////////////////////////////////////////// */

float spacer, rot, aspect, scl, sw, b;
int total, alfa, a;
int toggle = 1;

////////CONTROLS////////

float minX = 20.0;
float maxX = 90.0;
float minY = minX;
float maxY = height - minY;  //doesn't work with 'height' scoping problem? bug?
float widthX = maxX - minX;
float heightY = maxY - minY;
float gap = 9.0;
float mod = (heightY - 2*gap)/21;
float val = 0;
float ex = 0.9;
float mapper;
String command;
String value;

/////////////////////////
void controls(){

  exportPDF.render();
  linesBot.render();
  dotsBot.render();

  strokeWeight(1);
  stroke(200);
  noFill();

  if ( (toggle == 2) || (toggle == 4) || (toggle == 10)){
    continous = false;
  }
  else{
    continous = true;
  }

  switch(toggle){
  case 1:
    rot += val;
    command = "rotation";
    value = nfc(rot,15);
    break;
  case 2:
    a += (int)val;
    command = "a (int)";
    value = nfc(a,0);
    break;
  case 3:
    b += val;
    command = "b (float)";
    value = nfc(b,0);
    break;
  case 4:
    total += (int)(val*5);
    command = "total";
    value = nfc(total,0);
    break;
  case 5:
    spacer += val;
    command = "scale";
    value = nfc(spacer,3);
    break;
  case 6:
    scl += val;
    command = "ball scale";
    value = nfc(scl,3);
    break;
  case 7:
    sw += val;
    command = "line";
    value = nfc(sw,3);
    break;
  case 8:
    alfa += int(val*4);
    command = "alpha";
    value = nfc(alfa,0);
    break;
  case 9:
    command = "aspect";
    aspect += val;
    value = nfc(aspect,3);
    break;
  case 10:
    command = "spiral";
    spiral += (int)(val*5);
    if (spiral > 3){
      spiral = 0;
    }
    if (spiral < 0){
      spiral = 3;
    }
    value = nfc(spiral,0);
    break;
  }

  fill(255,190);
  rect(minX, minY, widthX, 10*mod);
  rect(minX, minY + 10*mod + gap, widthX, mod);
  rect(minX, minY + 11*mod + 2*gap, widthX, 10*mod);

  stroke(0);
  strokeWeight(0.5);
  triangle(gap/2, height/2, minX - gap, height/2 - gap/2, minX - gap, height/2 + gap/2);
  triangle(maxX+gap, height/2 - gap/2, maxX + minX - gap/2, height/2, maxX+gap, height/2 + gap/2);

  if (continous){

    if (mousePressed){
      if ((mouseX > minX) && (mouseX < maxX) && (mouseY > minY) && (mouseY < (minY+10*mod))){
        fill(255,0,0,val*200);
        rect(minX, minY, widthX, 10*mod);
        mapper = map(mouseY, minY, (minY+10*mod), 1, 0);
        val = function_ExponentialEmphasis(mapper, ex);
        drawIndicators();
      }

      if ((mouseX > minX) && (mouseX < maxX) && (mouseY > (minY+(10*mod)+gap)) && (mouseY < (minY+gap+(11*mod)))){
        fill(255,0,0,100);
        rect(minX, minY + 10*mod + gap, widthX, mod);
      }

      if ((mouseX > minX) && (mouseX < maxX) && (mouseY > (minY+(11*mod)+(2*gap))) && (mouseY < maxY)){
        fill(255,0,0,-val*200);
        rect(minX, minY + 11*mod + 2*gap, widthX, 10*mod);
        mapper = map(mouseY, (minY+(11*mod)+(2*gap)), maxY, 0, 1);
        val = -function_ExponentialEmphasis(mapper, ex);
        drawIndicators();
      }

      if(sw < 0.01){
        sw = 0.1;
      }
    }
  }

  drawplus(minX+widthX/2, minY+widthX/2);
  drawminus(minX+widthX/2, maxY-widthX/2);

}

/////////////////////////
void mousePressed(){

  if (dotsBot.over){
    dotsBot.press = !dotsBot.press;
  }

  if(linesBot.over){
    linesBot.press = !linesBot.press;
  }

  if(exportPDF.over){
    exportPDF.press = !exportPDF.press;
  }

  if ((mouseX < minX) && (mouseY > minY + 10*mod + gap) && (mouseY < minY + 11*mod + gap)){
    fill(255,0,0);
    triangle(gap/2, height/2, minX - gap, height/2 - gap/2, minX - gap, height/2 + gap/2);
    if (toggle == 1) {
      toggle = 10;
    }
    else{
      toggle -= 1;
    }
  }
  if ((mouseX > maxX) && (mouseX < maxX + mod) && (mouseY > minY + 10*mod + gap) && (mouseY < minY + 11*mod + gap)){
    fill(255,0,0);
    triangle(maxX+gap, height/2 - gap/2, maxX + minX - gap/2, height/2, maxX+gap, height/2 + gap/2);
    if (toggle == 10) {
      toggle = 1;
    }
    else{
      toggle += 1;
    }
  }

  if(!continous){
    if ((mouseX > minX) && (mouseX < maxX) && (mouseY > minY) && (mouseY < (minY+10*mod))){
      switch(toggle){
      case 2:
        a += 1;
        break;
      case 4:
        total += 1;
        break;
      case 10:
        spiral += 1;
        if (spiral > 3){
          spiral = 0;
        }
        resetSpiral();
      }
    }
    if ((mouseX > minX) && (mouseX < maxX) && (mouseY > (minY+(11*mod)+(2*gap))) && (mouseY < maxY)){
      switch(toggle){
      case 2:
        a -= 1;
        break;
      case 4:
        total -= 1;
        break;
      case 10:
        spiral -= 1;
        if (spiral < 0){
          spiral = 3;
        }
        resetSpiral();
      }
    }
  }
}

/////////////////////////
void mouseReleased(){
  val = 0;
}

/////////////////////////
void renderText(){
  textFont(pixelfont, 8);
  float rotat = -(PI/a)*rot;
  String ra = nfc(rot, 3);
  String rb = nfc(rotat, 3);
  String sp = nfc(spacer, 3);

  textFont(pixelfont, 8);
  fill(0);
  textAlign(LEFT);
  text("a = "+a+"    b = "+b+"    total = "+total+"    rot = "+rot+"    scale = "+spacer+"    ball scale = "+scl, minX+widthX+10, height-20);

  fill(0);
  textAlign(CENTER);
  textFont(georgia,16);
  text(command, minX+widthX/2, int(height/2 + 5));

  /*
  if(!continous){
   fill(255,0,0);
   text("discreet mode", width-100, height-20);
   }
   */
  if(overNumber){
    drawballoon();
  }

  textFont(bodoni,42);
  fill(0,50);
  textAlign(RIGHT);
  text(currentSpiral, width-20, 45);
}
/////////////////////////
void drawIndicators(){
  textFont(pixelfont, 8);
  textAlign(LEFT);
  String a = nfc(val,7);
  fill(255,0,0);
  text(value, minX+widthX+10, mouseY);
  fill(0);
  text(a, minX+10, mouseY);
}
/////////////////////////
void keyPressed(){

  if (key == 'd'){
    a += 1;
  }
  if (key == 'c'){
    a -= 1;
  }
  if (key == 'r'){
    aspect = 1;
  }
  if (key == 'g'){
    total += 1;
  }
  if (key == 'b'){
    total -= 1;
  }
  if (key == 'p'){
    pdf = true;
  }
  if (key == ' '){
    resetSpiral();
  }
}

/////////////////////////
void keys(){
  if (keyPressed){
    if (key == 'q'){
      rot += 0.1;
    }

    if (key == 'Q'){
      rot -= 0.1;
    }

    if (key == 'a'){
      rot += 0.001;
    }

    if (key == 'z'){
      rot -= 0.001;
    }

    if (key == 's'){
      spacer += 0.2;
    }

    if (key == 'x'){
      spacer -= 0.2;
    }

    if (key == 'f'){
      aspect += 0.2;
    }

    if (key == 'v'){
      aspect -= 0.2;
    }

    if (key == 'h'){
      alfa += 5;
    }

    if (key == 'n'){
      alfa -= 5;
    }

    if (key == 'j'){
      scl += 0.05;
    }

    if (key == 'm'){
      scl -= 0.05;
    }
  }
}
void mouseMoved(){
  overNumber = false;
}

void drawballoon(){
  float x,y,w;
  x = mouseX;
  y = mouseY;
  textFont(georgia, 16);
  w = textWidth(CURRENT)+6;
  fill(255,200);
  stroke(150);
  strokeWeight(1);
  beginShape();
  vertex(x,y);
  vertex(x,y-10);
  vertex(x-5,y-10);
  vertex(x-5, y-35);
  vertex(x+w, y-35);
  vertex(x+w, y-10);
  vertex(x+10, y -10);
  endShape(CLOSE);

  fill(Num[currentOver].textcol);
  textAlign(LEFT);
  text(CURRENT, x, y-19, 0.1);
}

void drawplus(float x, float y){
  fill(255);
  stroke(100);
  beginShape();
  vertex(x-5, y-5);
  vertex(x-5, y-20);
  vertex(x+5, y-20);
  vertex(x+5, y-5);
  vertex(x+20, y-5);
  vertex(x+20, y+5);
  vertex(x+5, y+5);
  vertex(x+5, y+20);
  vertex(x-5, y+20);
  vertex(x-5, y+5);
  vertex(x-20, y+5);
  vertex(x-20, y-5);
  endShape(CLOSE);
}

void drawminus(float x, float y){
  fill(255);
  stroke(100);
  beginShape();
  vertex(x+20, y-5);
  vertex(x+20, y+5);
  vertex(x-20, y+5);
  vertex(x-20, y-5);
  endShape(CLOSE);
}