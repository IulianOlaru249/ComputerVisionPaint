class ColorRectangle
{
  int x;
  int y;
  int w;
  int h;
  color coloring;  
  
  ColorRectangle(int windowW, int windowH, int coloring_, int numberOfColors,int spot)
  {
    h=25;
    w=windowW/6;
    
    x=0+(spot*windowW)/numberOfColors;
    y=windowH-h;
    
    coloring=coloring_;
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
  
   
  color getColor()
  {
    return coloring;
  }
  
  
  void show()
  {
    noStroke();
    rectMode(CORNER);
    fill(coloring);
    rect(x, y, w, h, 18, 18, 0, 0);
  }
}
