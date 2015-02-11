// this class for drawing the meteors,moving them down
class Meteor extends MovingObject
{
    PImage MeteorImage;  //image for Meteor
    boolean isFireMeteor;  //check type of meteor
    Meteor(float xPos,float yPos,String imagePath,int w,int h,boolean isFireMeteor)    //constructor for Meteor
    {
       this.xPos=xPos;
       this.yPos=yPos;
       this.MeteorImage = loadImage(imagePath);
       this.w=w;
       this.h=h;
       this.isFireMeteor=isFireMeteor;
    }
    //draw Meteor
    void drawMeteor()
    {
       image(MeteorImage, this.xPos, this.yPos,w,h);
    }
    void fall()    //move Meteor down
   {
      this.yPos+=2;
      // if statments to increase speed
            if (spaceship.getScores()>5)
            {
              this.yPos++;
            }
            if (spaceship.getScores()>11)
            {
              this.yPos++;
            }
            if (spaceship.getScores()>16)
            {
              this.yPos++;
            }
    }
    boolean getIsFireMeteor()    //get Fire Meteor
    {
      return isFireMeteor;
    }
}
