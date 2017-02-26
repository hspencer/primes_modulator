
/**
 * After creating a simple script for generating an endless list of prime numbers,
 * I tried to visualize them in a way that could reveal something interesting.
 *
 * The first thing I tried to do was to put them in a archimedean spiral (r = a + b * t). Then I learned that Stanislaw Ulam, in 1963,
 * came up with a simple yet revealing arrangement for prime numbers (Ulam's rose). He created a gridded square spiral that presented mysterious diagonal patterns 
 * that still remain unexplained.
 *
 * From this starting point, I'm trying to design a tool for discovering the hidden patterns in the prime numbers. 
 * If you play long enough, maybe you can find a hidden pattern that explains the aparent randomness of primes. Good luck!
 * Claim your prize at mathword.com, but remember to take your PDFs as a proof of your discovery.
 *
 * You'll need to run executable version in order to get a PDF.
 * 
 * ~ Originally Dec 2006
 */

Table primes;
Button linesBot, dotsBot, exportPDF;
Number Num[];

PFont pixelfont, georgia, bodoni;
boolean pdf = false;
boolean continous = true;
boolean drawlines = true;
boolean drawdots = false;
int spiral = 0;
String CURRENT = "1";
String currentSpiral;

void setup(){

  primes = new Table("primes.tsv");
  int l = primes.rowCount;
  Num = new Number[l];
  for (int i = 0; i < l; i++){
    Num[i] = new Number(i);
  }

  pixelfont = loadFont("pixel.vlw");
  georgia = createFont("Georgia",16);
  bodoni = loadFont("bodoni.vlw");
  
  fullScreen(); // size(900,700, OPENGL);
  ellipseMode(CENTER);

  resetSpiral();

  exportPDF = new Button("Create PDF", width-120, 75);
  linesBot = new Button("Draw Lines", width-120, 105);
  dotsBot = new Button("Draw Intergers", width-120, 135);  
  linesBot.press = true;
}

///-----------------------

void draw(){
  smooth();
  if (pdf || exportPDF.press) {
    beginRecord(PDF, "PDF/spiral####.pdf");
  }

  background(255);
  stroke(0);
  fill(200,0,0);

  pushMatrix();
  {
    translate(width/2, height/2);

    switch(spiral){
    case 0:
      currentSpiral = "Ulam�s Rose";
      spiral_0();
      break;

    case 1:
      currentSpiral = "Archimedean Spiral";
      spiral_1();
      break;

    case 2:
      currentSpiral = "Logarithmic Spiral 1";
      spiral_2();
      break;

    case 3:
      currentSpiral = "Logarithmic Spiral 2";
      spiral_3();
      break;
    }
  }
  popMatrix();

  if (pdf || exportPDF.press){
    endRecord();
    pdf = false;
    exportPDF.press = false;
  }
  keys();
  controls();
  renderText();
}