//this class checks if the meteors touchs the spaceship
class MovingObject
{
   float xPos;     //x position of MovingObject
   float yPos;   //y position of MovingObject
   int w;     //width
   int h;   //height
   boolean collide(MovingObject other)   //collide

   {
      if (this.xPos+w/2>other.xPos && this.xPos+w/2< other.xPos+other.w &&  
          this.yPos+h/2>other.yPos && this.yPos< other.yPos+other.h)
          {
          return true;
      }
      return false;
   }
}
