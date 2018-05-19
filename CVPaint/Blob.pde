class Blob {
  float minx; 
  float miny; 
  float maxx; 
  float maxy; 
  float cx; 
  float cy;
  
  
  Blob(float x, float y)
  {
    minx=x;
    miny=y;
    maxx=x;
    maxy=y;
  }
  
  
  float getXCoord()
  {
    return cx;
  }
  
  
  float getYCoord()
  {
    return cy;
  }
  
  
  void add(float x, float y)
  {
     minx=min(minx, x);
     miny=min(miny, y);
     maxx=max(maxx, x);
     maxy=max(maxy, y);
    
     cx=(minx+maxx)/2;
     cy=(miny+maxy)/2;
  }
  
  
  float size()
  {
    return (maxx-minx)*(maxy-miny);
  }
  
  boolean isNear(float x, float y)
  {
    float cx=(minx+maxx)/2;
    float cy=(miny+maxy)/2;
    
    float d=distSq(cx, cy, x, y);
    if(d<distThreshold*distThreshold)
      return true;
    else
      return false;
  }
}
