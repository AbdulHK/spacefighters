//This class for drawing the bullets, moving and moving them.
class Bullet extends MovingObject
{
    //Bullet constructor
    Bullet(float xPos,float yPos,int w,int h)
    {
       this.xPos=xPos;
       this.yPos=yPos;
       this.w=w;
       this.h=h;
    }
    //draw Bullet as yellow ellipse
    void drawBullet()
    {
      fill(255, 255, 50);
      ellipse(this.xPos, this.yPos,w,h);
    }
    //move Bullet UP
    void moveUP()
    {
      this.yPos-=2;
    }
}
