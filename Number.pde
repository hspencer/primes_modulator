/////////////////////////////

int currentOver;
boolean overNumber;

////////////number///////////

class Number {

  boolean isPrime, over;
  float xpos, ypos, scrx, scry, diffx, diffy;
  int num;
  color col, textcol;
  

  Number(int n){
    num = n;
    isPrime = false;
    over = false;
  }

  void render(float x, float y, float xdim, float ydim){
    xpos = x;
    ypos = y;

    if(isPrime){
      col = color(240,0,0,200);
      textcol = #FF0000;
    }
    else{
      col = color(0,alfa);
      textcol = #000000;
    }

    fill(col);
    noStroke();

    ellipse(xpos,ypos,xdim,ydim);

    diffx = abs(scrx - mouseX);
    diffy = abs(scry - mouseY);
    if ((diffx <= abs(xdim*0.5)) && (diffy <= abs(ydim*0.5))){
      CURRENT = nf(num+1,0);
      overNumber = true;
      currentOver = num;
    }
  }
}