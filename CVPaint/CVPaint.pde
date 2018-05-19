import processing.video.*;

ArrayList<Blob> blobs =new ArrayList<Blob>();
ArrayList<ColorRectangle> colorRectangles =new ArrayList<ColorRectangle>();


color [] colarray = { color(255,0,0), color(51,204,51), color(0, 102, 255), 
                        color(255,255,46), color(230, 0, 230), color(0, 0, 0) }; //culorile din UI                        
color trackColor= color(255);
color desiredColor; //culoarea pensulei


float threshold; //cat de apropiat este ca si culoare
float distThreshold=75; //cat de apropiat este ca si distanta pe ecran

boolean selected=false;


Capture video;
ClearRectanle clearRectangle;
Timer timer= new Timer();
 
                        
float distSq(float x1, float y1, float z1, 
             float x2, float y2, float z2)
{
  float d=(x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1);
  return d;
}

float distSq(float x1, float y1, 
             float x2, float y2)
{
  float d=(x2-x1)*(x2-x1)+(y2-y1)*(y2-y1);
  return d;
}


//despre UI
                        
void drawUI()
{
  clearRectangle.show();
  
  for(ColorRectangle rectangle : colorRectangles)
    rectangle.show();
}

void updateUI(float trcx, float trcy)
{
  if(clearRectangle.hoverOver(trcx, trcy))
  { 
    if(!timer.running)
      timer.start();
    if(timer.second()>3)
     {
        timer.stop();
        background(255);
     }
  }
  
  for(ColorRectangle rectangle :colorRectangles)
    if(rectangle.hoverOver(trcx, trcy))
    { 
      desiredColor=rectangle.getColor();
    }
}


//events

void captureEvent(Capture video) {
  video.read();
}

void mousePressed() {
  int loc = mouseX + mouseY*video.width;
  trackColor = video.pixels[loc];
}

void keyPressed()
{
    if(keyCode==83) //s
      selected=false;
    if(keyCode==68) //d
    {
      selected=true; 
      background(240);
    }
}

void setup() 
{
  size(640, 360);
  
  //afiseaza rezolutiile disponibile
  String[] cameras = Capture.list();
  printArray(cameras);
  
  
  //incepe video
  
  video = new Capture(this, cameras[10]);
  video.start(); 
  
  
  //creeaza butonul clear
  
  clearRectangle=new  ClearRectanle(width, height);
  
  
  //creeaza butoanele de selectie a culorii
  
  for(int i=0; i<colarray.length; i++)
  {
    ColorRectangle rectangle = new ColorRectangle(width, height, colarray[i], colarray.length, i);
    colorRectangles.add(rectangle);
  }
  printArray(colorRectangles);
}

void draw()
{ 
  video.loadPixels();
  
  //test pentru selectare a culorii de urmarit
  
  if(selected)
    drawUI();
  else
    image(video, 0, 0);
    
  blobs.clear(); //reimprospatare blobs la fiecare frame
  
  threshold=20; //initializare prag
  
  for(int x=0; x<video.width; x++)
      for(int y=0; y<video.height; y++)
      {
        int loc=x+y*video.width;
        
        color currentColor=video.pixels[loc];
        float r1=red(currentColor);
        float g1=green(currentColor);
        float b1=blue(currentColor);
        
        float r2=red(trackColor);
        float g2=green(trackColor);
        float b2=blue(trackColor);
        
        
        //compara cat de apropiata este culoarea urmarita de culorile celorlalti pixeli
        
        float d=distSq(r1, g1, b1, r2, g2, b2);
        
        
        //daca este sub prag - cat mai apropiata- se ceraza un blob
        
        if(d<threshold*threshold)
        {
          boolean found=false;
          for(Blob b: blobs)
          {
            if(b.isNear(x, y))
            {
              b.add(x, y);
              found=true;
              break;
            }
          }
          if(!found)
          {
            Blob b=new Blob(x, y);
            blobs.add(b);
          }
         
        }
      }
   
      
 //deseneaza blobs potriviti, in culoarea potrivita
 
 for(Blob b :blobs)
   if(b.size()>200)
   { 
     updateUI(width-b.getXCoord(), b.getYCoord());
     drawUI();
     
     fill(desiredColor);
     ellipse(width-b.getXCoord(), b.getYCoord(), 10, 10);
     drawUI();
   }  
  
}
