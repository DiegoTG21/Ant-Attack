float randomY;//Yvalue for new ants to appear
float dy;
float easing = 0.005;
float distance=650;
int totAnts=25;
int totBossAnts=15;
int numAnts=5;//number of ants appering on the screen
int numBossAnts=0;//number of big ants appering on the screen
int buttonX =400;
int buttonY =400;
int buttonLength=120;
int buttonWidth=50;
int speed, eatingAnts,totalDamage;//speed of ants, number of ants eating
int score=0;
int maxSpeed=5;//Maximun speed for the ants
int wormSize=40;
int newAnt=10;
int antsDamage=1;
int bossAntsDamage=3;
PImage background, startBackground;
PImage [] cakePic =new PImage[4];
int cakeSize=100;
boolean arrivedToCake, overBtn,btnClicked, start=false;

Ant[] ants = new Ant[totAnts];//when an ant is killed 2 more appear
BossAnt[] bossAnts = new BossAnt[totBossAnts];//declares the 2 type of ants
Target target = new Target(800,300,cakeSize);//x,y,diameter
Worm worm = new Worm(900,0,wormSize);
HealthBar healthBar= new HealthBar (850,20);
color antBack = color(0,255,0);
color antFront = color(50,100,0);
color btnColour = color(204, 102, 0);
color clickedColour = color(104, 102, 0);
color currentColour=btnColour;

void setup(){
      size(900,600);
      background = loadImage("images/floor.jpg");
      startBackground = loadImage("images/antAttack.png");
      for (int i = 0; i < 4; i++)
      {
      cakePic[i]=loadImage("images/cake"+i+".png");
      cakePic[i].resize(130,130);
      }//load the stages of the cake into each variable
      background.resize(width,height);
      startBackground.resize(width,height);
      
      for (int i = 0; i < totAnts; i++) 
      {//create 20 random ants
        speed=int(random(1,maxSpeed));
        ants[i] = new Ant(0,random(0,600),speed,false);
      }
       for (int i = 0; i < totBossAnts; i++) 
      {//create all the big ants
        speed=int(random(1,3));
        bossAnts[i] = new BossAnt(0,random(0,600),speed,false);
      }
      worm.load();
}

void draw() 
{

  if(start==true)
  { 
      image(background,0,0);
      if ( healthBar.health>=7500)
      {// depending on the health of the cake the photo will be different. Cake decays.
        image(cakePic[0],750,260);        
      }
      else if ( healthBar.health>=5000 &&  healthBar.health<7500)
      {
        image(cakePic[1],750,260);        
      } 
       else if ( healthBar.health>=2500 &&  healthBar.health<5000)
      {
        image(cakePic[2],750,260); 
      }
       else if ( healthBar.health>0 &&  healthBar.health<2500)
      {
        image(cakePic[3],750,260);
      }
      else
      {        
        image(cakePic[0],750,260);        
      }
      
       drawAnts();
       drawBossAnts();
       worm.render();
       worm.approachDestination();
       healthBar.render();
       textSize(20);
       text("Score: " + score, 700, 20); 
       text("Number of ants: " + (numAnts +numBossAnts), 655, 40); //Shows the total of ants that are attacking the cake
    }
    else
    {//before the game starts
       image(startBackground,0,0);
       fill(255);
       textSize(30);
       text("Press the SPACE to start", 300, 200); 
       updateButton();
       fill(currentColour);
       rect(buttonX,buttonY,buttonLength,buttonWidth);
       fill(255);
       textSize(14);
       text("Protect the cake from the ants! If they reach the target they will slowly eat it :(",150,300);
       text("Hard Option: More and  faster ants at the start. Damage is also increased",150,320);
       textSize(15);
       fill(0);
       text("HARD",buttonX + 35, buttonY + buttonWidth/2); //label inside button
    }
}
void drawAnts()
{
   for (int i=0; i<numAnts;i++)
       {//draw all the ants
          distance= target.x-ants[i].x;
          ants[i].render();
          ants[i].move();
          ants[i].eatCake();
          ants[i].attackCake();//in this method the score is calculated
       }
}
void drawBossAnts()
{
   for (int i=0; i<numBossAnts;i++)
       {//draw all the ants
          distance= target.x-bossAnts[i].x;
          bossAnts[i].render();
          bossAnts[i].move();
           bossAnts[i].eatCake();
          bossAnts[i].attackCake();//in this method the score is calculated
       }
}
void mousePressed()
{
  worm.storeDestination();//update destination
  if (overBtn==true && start==false && btnClicked==false )
  {//if the Hard button is clicked
  numAnts=7;
  maxSpeed=7;
  antsDamage=2;
  bossAntsDamage=5;
  fill(0);
  currentColour=clickedColour;
 
  btnClicked=true;
  }
  else if (overBtn==true && start==false && btnClicked==true)
  {//if the Hard button is clicked angain the settings go back to normal
  numAnts=5;
  maxSpeed=5;
  antsDamage=1;
  bossAntsDamage=3;
  fill(0);
  currentColour=btnColour;
  btnClicked=false;
  }
}

void keyPressed() {
  if(keyCode == ' ')
  {
    if (start==false)
    {
      start=true;
      loop();  // Holding down the mouse activates looping
    }
    else
    {//if the game is paused
    noLoop();
    start=false;
    text("Press the SPACE to resume", 300, 200); 
    
    }
  }
}
void updateButton() 
{
  if (overButton(buttonX,buttonY,buttonLength,buttonWidth)==true)
  {
    fill(clickedColour);
    overBtn=true;
  }
  else
  {
    fill(btnColour);
    overBtn=false;

  }
}
boolean overButton(int x, int y, int width, int height)
{//to know if the mouse is clicking the button
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void damageCake(int damage)
{
  if (healthBar.health>0 && eatingAnts!=numAnts )
     {
      healthBar.whiteTop+=damage;//it reduces the size from top to bottom
     healthBar.health-=damage;//reduce size of health bar
     }
     else
     {//when health=0
       endGame();
     }
}
void endGame()
{
 noLoop();
       image(background,0,0);
       textSize(40);
       fill(0);
       image(background,0,0);
       text("Final score: " + score, 300, 200); 
       text("GAME OVER", 350, 300); 
       start=false;
}
void checkScore()
{
  if(score==newAnt && newAnt%30!=0 && numAnts<=totAnts)
        {//1 more ant and bigger size of the worm when the score reaches a multiple of 10
          numAnts+=1;
          newAnt+=10;
        }
        else if(score%30==0 && numBossAnts<=totBossAnts)
        {//add a boss ant
          numBossAnts+=1;
          newAnt+=10;
        }
        else
        {}
}
