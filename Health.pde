class HealthBar
{
   int x;
   int y;
   float damageTaken;
   HealthBar(int x, int y){
     this.x = x;    
     this.y = y;
   }
  int sizeX=10;
  int sizeY=100;
  int health=10000; 
  int whiteTop=200;
//using multiples of 100 so i can reduce the health when eaten slightly
   void render(){
     fill(255);
     rect(x,y,sizeX+4,sizeY+4);//border
     fill(0);
     rect(x+2,y+(whiteTop/100),sizeX,health/100);/// health of cacke
   } 
}
