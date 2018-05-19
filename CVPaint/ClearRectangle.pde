class ClearRectanle
{
  int x;
  int y;
  int w;
  int h;
  int cx;
  int cy;
   
  ClearRectanle(int windowW, int windowH)
  {
    h=25;
    w=windowW/10;
    
    x=0+3;
    y=0;
    
    cx=x+w/2;
    cy=y+h/2;
  }
  
  boolean hoverOver(float tx, float ty)
  {
    rectMode(CORNER);
    if(tx>x && tx<x+w &&
       ty<y+h && ty>y)
      return true;
    else
      return false;
  }
  
  void show()
  {    
    noStroke();
    rectMode(CORNER);
    fill(140);
    rect(x, y, w, h, 0, 0, 18, 18);
    
    strokeWeight(3);
    fill(255);
    textAlign(CENTER);
    text("Clear",cx, h-5);
  }
}
