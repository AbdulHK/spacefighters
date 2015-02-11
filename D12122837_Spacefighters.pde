//D12122837
//Abdulellah Hakim
// The game task is to catch the firey metors which increases the your score
//the game gets harder when you get more scores as the metors speed will increase
//you will have to avoid the other meteors as they will make you lose life points.
//you can fire bullets at the metors using "s" or clicking the mouse button.
//each time the player start a game a random number generator will
//pick a ship model randomly.there is two diffrent ways to control
//your spaceship. by using your mouse or by pressing LEFT and RIGHT in your keyboard.
import ddf.minim.*;    //import library for sounds
    PImage backGround,startBackGround,endBackGround;      //images for backGround
    
    PFont font;    //fond
    
    Spaceship spaceship; //create Spaceship
    
    int timer=0;   //global timer
    
    int timerForGenerateNewMeteors=0;     //timerFotGenerateNewMeteors
    
    int direction=-1;  //direction left =0 right=1 -1 no moving
    
    int scene=0;  //variable scene for the background and text
    
    ArrayList<Meteor> meteors=new ArrayList<Meteor>();  //array of meteors
    
    String message="";  //variable for message
    
    Minim minim;  //sounds objects
  AudioPlayer player;
  
  Minim minimCrash;
  AudioPlayer playerCrash;

//setup
void setup()
{
  size(900, 657); //same as image size
  
  backGround = loadImage("images//backGround.png");     //load backGround image
  
  startBackGround= loadImage("images//StartBackGround.jpg");    //load   start backGround image
  
  endBackGround= loadImage("images//EndBackGround.jpg");    //load  end backGround image
  
  int randSpaceShip= (int)random(1,7);      //select random spaceship image
  
  spaceship=new Spaceship(300,500,"images//spaceship"+randSpaceShip+".png",150,150);    //create new spaceship
  
  font = loadFont("Garamond-Italic-48.vlw");    //load new font
  
  generateNewMeteors();      //create new Meteor and add to array
  
  minim = new Minim(this);    //load sound for shoot
  player = minim.loadFile("sound//shootsound.mp3");
  minimCrash = new Minim(this);    //load sound to collide spaceship with Meteor
  playerCrash = minimCrash.loadFile("sound//Crash.wav");
  
}
//method to add new Meteors
void generateNewMeteors()
{
    int randImage= (int)random(1,4);      //generate image for meteor

    int randXPos= (int)random(0,7);        //random x position for Meteor

    int randomSize=(int)random(1,3);        //generate random size for meteor

    boolean isFireMeteor=false;        //check if Meteor is fire

    if(randImage==3)
    {
       isFireMeteor=true; //firemeteor true and generete the meteor
    }
    Meteor meteor= new Meteor(randXPos*130+20,0,"images//Meteor"+randImage+".png",
    70*randomSize,70*randomSize,isFireMeteor);      //create new meteor

    meteors.add(meteor);     //add meteor to arraylist

}
void draw() 
{
  if(scene==0)    //if scene=0
  {
    startGameBackGround();
  }
  //if scene==1
  if(scene==1)
  {
    if(spaceship.getLives()>0)      //check if player has lives
    {
      //play
       play();
       if(spaceship.getIsCollide())         //check if spaceship collides withmeteor

       {
         //play sound
          playerCrash.play();
          //load sound again
          playerCrash = minimCrash.loadFile("sound//Crash.wav");
       }
    }
    else
    {
      scene=2;        //if user lost

      message="You lose!";
    }
  }
  if(spaceship.getScores()==20)   //check if user won
  {
      scene=2; 
      message="You WIN!";
  }
  //show lose or win background
  if(scene==2)
  {
     background(endBackGround);
     textFont(font, 80);
     fill(255,255,255);
     text(message,500, 100);
     textFont(font, 50);
     text("Click to Start NEW Game!",60, 600);
     int randSpaceShip= (int)random(1,7);         //generate new spaceship for new game
     spaceship=new Spaceship(300,500,"images//spaceship"+randSpaceShip+".png",150,150);
  }
}
//setup for startGameBackGround
void startGameBackGround()
{
  background(startBackGround);
  textFont(font, 70);
  fill(255,255,255);
  text("Welcome to SpaceFighters Game",60, 300);
  textFont(font, 60);
  text("Click to Start Game!",60, 500);
  
}
//method play
void play()
{
  background(backGround);      //set picture as back ground

  textFont(font, 32);      //set new font

  fill(255,255,255);
  text("Score: "+spaceship.getScores(),20, 25);      //show Score

  text("Lives: "+spaceship.getLives(),750, 25);      //show Lives

  spaceship.drawSpaceship();      //draw spaceship

  spaceship.move(direction);    //move spaceship

  if(timerForGenerateNewMeteors>40)    //after several millseconds generate New Meteor

  {
    generateNewMeteors();      //generateNewMeteors

    timerForGenerateNewMeteors=0;
  }
  if (spaceship.getScores()>5&& timerForGenerateNewMeteors>30) //if conditions to increase the number of meters when the score get higher
  {
    generateNewMeteors();     
    timerForGenerateNewMeteors=0;
  }
  if (spaceship.getScores()>10&& timerForGenerateNewMeteors>20)
  {
    generateNewMeteors();     
    timerForGenerateNewMeteors=0;
  }
  if (spaceship.getScores()>15&& timerForGenerateNewMeteors>10)
  {
    generateNewMeteors();     
    timerForGenerateNewMeteors=0;
  }
  timerForGenerateNewMeteors++;
  for(int i=0;i<meteors.size();i++)    //draw all meteors in arraylist

  {
     
      meteors.get(i).drawMeteor();
      meteors.get(i).fall();        //move meteors

  }
  spaceship.collideBulletWithMeteor(meteors);    //check collide Bullet With Meteor

  spaceship.collideSpaceShipWithMeteor(meteors);    //check collide SpaceShip With Meteor

  timer++;
  if(timer>20)
  {
      direction=-1;
  }
}
//mouse Moved
void mouseMoved()
{
   spaceship.mouse_Moved(mouseX);
}
//mouse Pressed
void mousePressed()
{
   if(scene==0)
   {
     scene=1;
   }
   if(scene==1)
   {
     //if user click shoot
     spaceship.shoot();
     //play sound for shooting
     player.play();
   }
   if(scene==2)
   {
     scene=0;
     //set new score and new lives for new game
     spaceship.setLives(3);
     spaceship.setScores(0);
     //clera all meteors
     meteors.clear();
   }
}
//mouse Released
void mouseReleased()
{
  //since close closes the file, we'll load it again
  player = minim.loadFile("sound//shootsound.mp3");
}
void keyPressed() 
{
    if (key == CODED)
    {
      //check left button click
      if (keyCode == LEFT)
      {
         direction=0;
         timer=0;
      } 
      //check right button click
      if (keyCode == RIGHT) 
      {
          direction=1;
          timer=0;
      }
    }
    //if user press s shoot
    if (key =='s') 
    {
       spaceship.shoot();
        player.play();
   } 
}
 
void keyReleased() 
{
 if (key == CODED)
 {
      //check left button click
      if (keyCode == LEFT)
      {
         timer=0;   
      } 
      //check right button click
      if (keyCode == RIGHT) 
      {
         timer=0;
      }
  }
  //since close closes the file, we'll load it again
 player = minim.loadFile("sound//shootsound.mp3");
}
