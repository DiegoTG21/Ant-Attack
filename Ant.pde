class Ant
{
          float x, y, speed,dy;
          int lengthResize=60;
          int timer =20;
          boolean eating,dead;
          PImage antPic=loadImage("images/ant.png");
         PImage deadAnt=loadImage("images/deadAnt.png");

         Ant(float x, float y,float speed, boolean eating){
         this.x = x;
         this.y = y;
         this .speed =speed;
         this.eating =eating;
        }
        void render(){
          if (dead==false)
          {
          antPic.resize(lengthResize,30);
          image(antPic,x,y);
          }
          else
          {
           deadAnt.resize(lengthResize,30);
          image(deadAnt,x,y);
          }
        }
        void move(){
          if(eating==false && dead==false)
          {
            float movement=random(-3,3);
            x+=speed;
            y+=movement;
            if(x >900){
             x=0;
             speed=random(1,maxSpeed);//randomize speed after going past the edge
             y=random(0,600);//wrap background
            }
          }
          else if (dead==true)
          {
           
              timer-=1;
              if (timer==0) 
              {
                timer =20;
                dead=false;
                respawn();
              }
          }
        }
        void respawn()
        {
          x=-100;
          speed=random(1,maxSpeed);
          y=random(0,600);
          
        }
        void eatCake(){
          if(reachTarget(target)==true)
            {//stop to eat
             eating=true;
            }
        }
        
         boolean reachTarget(Target other)//collision with the cake
         {
           return (abs(this.x-other.x) < 85  &&  abs(this.y-other.y) < 85);
         }
         boolean eaten(Worm eater)//collision with the cake
         {
           if (dead==false)
           return (abs(this.x-eater.x)+lengthResize/2-eater.diameter< wormSize  &&  abs(this.y-eater.y)-eater.diameter/2 < wormSize);
           //the collision only works when the worm's head is close enough
           //any part  of the ant can collide with any part of the worm
            else
            return false;
         }
         void attackCake()
{
  if(reachTarget(target)==false && dead==false)
   {
      dy =y -target.y;//distance between targets y-axis
      if (abs(dy) > 1)
      {
     y -= (dy * speed)/distance;
      //calculates how much it needs to move down
      arrivedToCake=true;
      }
      if (eaten(worm)==true)
      {//when worm hits ants
       dead=true;
        //the ant appears from the left side of the screen again with a different speed and at a different y position.
        score+=1;
        //score is added
        checkScore();
      }
   }
   else if (reachTarget(target)==true)
   {//if they reach the target
     damageCake(antsDamage);
   }
}       
}
