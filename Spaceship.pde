//this class is for the spaceship positions,controls
class Spaceship extends MovingObject
{
    PImage SpaceshipImage;    //image for Spaceship
    int lives;    //lives for Spaceship
    int scores;  //scores for Spaceship
    boolean isCollide=false;    //flag for collide Spaceship with meteor
    ArrayList<Bullet> bullets=new ArrayList<Bullet>();    //ArrayList of Bullets
    int flipperTimer=0;    //flipper Timer

    Spaceship(float xPos,float yPos,String imagePath,int w,int h)      //constructor for Spaceship
    {
       this.xPos=xPos;
       this.yPos=yPos;
       this.SpaceshipImage = loadImage(imagePath);
       this.w=w;
       this.h=h;
       this.lives=5;
       this.scores=scores;
       
    }
    //draw Spaceship
    void drawSpaceship()
    {
       if(!isCollide)
       {
         image(SpaceshipImage, this.xPos, this.yPos,w,h);         //draw image of Spaceship
         flipperTimer=0;
       }
       else
       {
          //if Spaceship collides wih meteor flipp and play sound
          if (flipperTimer<105)
          {
             if(flipperTimer%2==0)
             {
                image(SpaceshipImage, this.xPos, this.yPos,w,h);
             }
             flipperTimer++;
        }
        else
        {
          isCollide=false;
          flipperTimer=0;
        }
       }
       //draw all bullets and move
       for(int i=0;i<bullets.size();i++)
       {
            bullets.get(i).drawBullet();
            bullets.get(i).moveUP();
       }
    }
    //check SpaceShip collide  With Meteor
    void collideSpaceShipWithMeteor(ArrayList<Meteor> meteors)
    {
         for(int i=0;i<meteors.size();i++)
         {
             if(meteors.get(i).collide(this))
             {
               if(meteors.get(i).getIsFireMeteor())
               {
                  this.scores++;                      //if SpaceShip collides  With Fire Meteor add score
               }
               else
               {
                  this.lives--;                   // //if SpaceShip collides  With other  Meteor sub lives
                  isCollide=true;
               }
               meteors.remove(i);                 //remove meteor from list

             }
         }
    }
    //collide Bullet With Meteor
    void collideBulletWithMeteor(ArrayList<Meteor> meteors)
    {
         for(int i=0;i<bullets.size();i++)
         {
            for(int j=0;j<meteors.size();j++)
            {
              if(bullets.get(i).collide(meteors.get(j)) && 
                 !meteors.get(j).getIsFireMeteor())
                 {
                 bullets.remove(i);                    //delete buulet from list
                 meteors.remove(j);                   //delete metors form list
                 break;
              }
            }
         }
    }
    //move SpaceShip using mouse
    void mouse_Moved(int mouse_X)
    {
       this.xPos=mouse_X-w/2;
    }
    
        //move SpaceShip using left and right buttons
    void move(int direction)
    {
      //left 
      if(direction==0)
      {
        moveLeft();
      }
      //Right
      if(direction==1)
      {
        moveRight();
      }
    }
    //move let
    void moveLeft()
    {
      if(xPos>=0)
      {
        xPos-=5;
      }
    }
    //move Right
    void moveRight()
    {
      if(xPos+w<=width)
      {
        xPos+=5;
      }
    }
    //shoot method
    void shoot()
    {
      Bullet bullet=new Bullet(this.xPos+w/2,this.yPos,15,20);
      bullets.add(bullet);
    }
    //set Lives
    void setLives(int lives)
    {
      this.lives=lives;
    }
    //set Scores
    void setScores(int scores)
    {
      this.scores=scores;
    }
    //get Lives
    int getLives()
    {
      return this.lives;
    }
    //get Scores
    int getScores()
    {
      return this.scores;
    }
    //get IsCollide
    boolean getIsCollide()
    {
       return isCollide;
    }
}
