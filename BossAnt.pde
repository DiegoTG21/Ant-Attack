class BossAnt extends Ant
{//inheritance
    PImage bossAntPic=loadImage("images/bossAnt.png");
    int lengthResize=100;
    BossAnt(float x, float y,float speed, boolean eating){
    super(x, y, speed,eating);
         
    }
      @Override void render()
      {//changes the size and look of the ant
        if (dead==false)
          {
        bossAntPic.resize(lengthResize,55);
          image(bossAntPic,x,y);
           }
          else
          {
           deadAnt.resize(lengthResize,55);
          image(deadAnt,x,y);
          }
        }
}
