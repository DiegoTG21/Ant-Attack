class Worm
{
  int numParts=20;//cant be bigger than diameter
   float x;
   float [] centreX= new float[numParts];
   float y;
   float [] centreY= new float[numParts];
   float destinationY;
   float destinationX;
   float easing = 0.1;//slow down when closer
   int diameter;
   int []partsDiameter= new int[numParts];


   Worm(float x, float y, int diameter){
     this.x = x;
         this.y = y;
         this .diameter =diameter;
   }
   void load(){
     for (int i=0; i<numParts;i++)
     {
     centreX[i]=x;
     centreY[i]=y;
     }
   }
   void render(){
   fill(0);
    for(int i=numParts-1; i>=0; i--)
    {
     stroke(0); 
     fill(223 ,82, 134);
     partsDiameter[i]=diameter-(diameter/numParts)*i;
     ellipse(centreX[i],centreY[i],partsDiameter[i],partsDiameter[i]);//diameter decreases 10%
    }
    eye (centreX[0]-5,centreY[0]);//left eye
    eye (centreX[0]+5,centreY[0]);//right eye

   } 
   void eye(float x, float y)
   {//draw an eye
     fill(255);
    ellipse(x,y,diameter/4,diameter/2);
    fill(0);
    ellipse(x,y,diameter/8,diameter/4);
   }
   void storeDestination(){

    destinationY=mouseY;
    destinationX=mouseX;
   
  
}
void approachDestination(){
     float dy;
     float dx;
      for(int i=0; i<numParts; i++)
      {
         dy = centreY[i] - destinationY;//distance between targets y-axis
          dx= centreX[i] - destinationX;
          //dy=dy/(i+1);
          //dx=dx/(i+1);
           if (abs(dx) > 1)
           {
            //centreX[i] -= dx *(easing);//product=speed  
           centreX[i] -= dx * (easing-(sqrt(i))*0.012);//increase the last value to increase slow motion
            }
           if (abs(dy) > 1) {
             //centreY[i] -= dy *(easing);
             centreY[i] -= dy * (easing-(sqrt(i))*0.012);
            }
      }
x=centreX[0];
y=centreY[0];
//allows the collision method to work
      
}
}
