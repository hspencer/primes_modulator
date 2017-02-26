
class Controler{
  float xpos;
  float ypos;
  float xdim;
  float ydim;
  boolean over;
  boolean press;
  String label;
  color hover;
  color pressed;
  
  Controler(String txt, float x, float y){
    label = txt;
    xpos = x;
    ypos = y;
    textFont(pixelfont, 8);

    xdim = textWidth(label) + 10;
    ydim = textAscent() + textDescent() + 10;
  }
}