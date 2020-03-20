class Obstruction
{ 
  // X and Y coordinates
  int obstruction_x, obstruction_y;

  // Constructor of object
  Obstruction()
  {
    // Starting position
    obstruction_x=((int)random(10)* 80) + 160;
    obstruction_y=(int)random(7)* 80;

    // Image
    obstruction = loadImage("bush.png");
  }

  // Obstructions move left to create an illusion of moving Peppa
  void advance()
  {
    if ((frameCount%2) == 0)
    {
      obstruction_x-=1;
    }
    if (obstruction_x<=0) // Restart position when obstruction achieve left side of the screen
    {
      obstruction_x=800; 
      obstruction_y=(int)random(7)* 80;
    }
  }

  // Draw an obstruction
  void drawObstr(int i)
  {
    o[i].advance(); // Calculate new positions
    image (obstruction, obstruction_x, obstruction_y);
  }
}
