
/////////////////////////// POLYGONAL SPIRAL 

void spiral_0(){

  float n;
  int side = 1;
  int num = 1;

  /////////////////////////////////////////
  rotateX(b);  /// remove por PDF ///
  /////////////////////////////////////////

  for(int i = 0; i < total; i++){
    for(int j = 0; j < a; j++){
      for(int k = 0; k < side; k++){

        Num[num-1].scrx = screenX(k*spacer,0,0);
        Num[num-1].scry = screenY(k*spacer,0,0);

        strokeWeight(sw);
        stroke(0, alfa);

        if (linesBot.press){
          line (k*spacer,0, k*spacer+spacer,0);
        }

        n = primes.getInt(num,1);

        if (n != 0){
          noStroke();
          fill(255,0,0);
          Num[num-1].isPrime = true;
          Num[num-1].render(k*spacer, 0, scl*spacer*0.9, scl*spacer*0.9*aspect);
        }

        if((n == 0) && dotsBot.press){  
          noStroke();
          fill(0, alfa);
          Num[num-1].render(k*spacer, 0, scl*spacer*0.7, scl*spacer*0.7*aspect);
        }        


        num += 1;

        if(k == (side - 1)){
          translate(k*spacer+spacer,0);
        }
      }
      rotate(-(PI/a)*rot);
    }
    side +=1;
  } 
}
/////////////////////////////// ARCHIMEDES SPIRAL

void spiral_1(){
  int num = 1;
  float x1,y1, x2, y2, fraq1, fraq2, r1, r2, t1, t2, n, mod;

  for (int i=1; i <= total; i++) {

    mod = atan2(i,b);

    fraq1 = i/(float)total;
    r1 = spacer*i*mod;
    t1 = rot*fraq1*TWO_PI;

    strokeWeight(sw);
    stroke(0, alfa);

    x1 = r1*sin(t1); // circular identity
    y1 = r1*cos(t1)/a; // circular identity

    fraq2 = (i+1)/(float)total;
    r2 = spacer*(i+1)*mod;
    t2 = rot*fraq2*TWO_PI;

    x2 = r2*sin(t2); // circular identity
    y2 = r2*cos(t2)/a; // circular identity

    if (linesBot.press){
      line(x1,y1, x2,y2);
    }

    Num[num-1].scrx = screenX(x1,y1,0);
    Num[num-1].scry = screenY(x1,y1,0);

    n = primes.getInt(num,1);

    if ((n == 0) && dotsBot.press){
      fill(0, alfa);
      pushMatrix();
      translate(x1,y1);
      rotate(atan2(y1,x1)+HALF_PI);
      Num[num-1].render(0, 0, scl*spacer*0.7, scl*spacer*0.7*aspect);
      popMatrix();
    }

    if (n != 0){
      noStroke();
      fill(255,0,0);
      pushMatrix();
      translate(x1,y1);
      rotate(atan2(y1,x1)+HALF_PI);
      Num[num-1].isPrime = true;
      Num[num-1].render(0, 0, scl*spacer*0.9, scl*spacer*0.9*aspect);
      popMatrix();
    }
    num += 1;

    if (num >= 10000){
      num = 0;
    }
  }
}


/////////////////////////////////// Log SPIRAL 1

void spiral_2(){

  float n, em, coe;
  int num = 1;

  pushMatrix();
  {
    for(int i = 0; i < total; i++){

      n = primes.getInt(num,1);
      coe = (total-i)*b/total;
      em = function_ExponentialEmphasis(coe, b);

        Num[num-1].scrx = screenX(0,0,0);
        Num[num-1].scry = screenY(0,0,0);

      if (linesBot.press){
        strokeWeight(sw);
        stroke(0, alfa);
        line(0,0, spacer,0);
      }

      if (n != 0){
        Num[i].isPrime = true;
        Num[i].render(0, 0, scl*spacer*0.9, scl*spacer*0.9*aspect);
      }
      else{
        Num[i].isPrime = false;
      }

      if((n == 0) && dotsBot.press){  
        Num[i].render(0, 0, scl*spacer*0.7, scl*spacer*0.7*aspect);
      }

      translate(spacer,0);
      rotate(rot*pow(em,a));      

      num += 1;
      ;
    }
  } 
  popMatrix();
}

/////////////////////////////////// RAW SPIRAL 2

void spiral_3(){

  float n, em, coe;
  int num = 1;
  translate(0, -10*a);
  pushMatrix();
  {
    for(int i = 0; i < total; i++){
      n = primes.getInt(num,1);
      strokeWeight(sw);
      stroke(0, alfa);
      coe = 1-((total-i)/total);

      Num[num-1].scrx = screenX(0,0,0);
      Num[num-1].scry = screenY(0,0,0);

      if (linesBot.press){
        line(0,0, spacer,0);
      }

      if (n != 0){
        Num[i].isPrime = true;
        Num[i].render(0, 0, scl*spacer*0.9, scl*spacer*0.9*aspect);
      }
      else{
        Num[i].isPrime = false;
      }

      if((n == 0) && dotsBot.press){  
        Num[i].render(0, 0, scl*spacer*0.7, scl*spacer*0.7*aspect);
      }  

      if(Num[i].over){
        fill(255,0,0);
        text(Num[i].num+1, 0,0);
      }

      num += 1;
      if (num >= 10000){
        num = 0;
      }

      translate(spacer,0);
      rotate(rot+ (i*b/total));    
    } 
  }
  popMatrix();
}

///////////////////////////////// RESET SPIRALS

void resetSpiral(){

  if (spiral == 0){
    total = 24;
    alfa = 100;
    spacer = 20.0;
    rot = 1.0;
    a = 2;
    b = 0;
    aspect = 1.0;
    scl = 0.40;
    sw = 0.5; 
  }

  if (spiral == 1){
    total = 600;
    alfa = 100;
    spacer = 0.559;
    rot = -14.275;
    a = 1;
    b = 1.0;
    aspect = 1.0;
    scl = 10.0;
    sw = 0.5;
  }

  if (spiral == 2){
    total = 800;
    alfa = 150;
    spacer = 10.5;
    rot = 0.244;
    a = 1;
    b = 0.408;
    aspect = 1.0;
    scl = 0.54;
    sw = 0.5;
  }

  if (spiral == 3){
    total = 2000;
    alfa = 100;
    spacer = 29.7;
    rot = 0.093;
    a = 31;
    b = 0.2;
    aspect = 1.0;
    scl = 0.140;
    sw = 0.5;
  }
}