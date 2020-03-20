class Peppa
{
  // X and Y coordinates
  int peppa_x, peppa_y;
  
  int direction = 0; // direction of Peppa

  // Opportunity to move in 4 directions
  boolean movement1 = true, movement2 = true, movement3 = true, movement4 = true;

  // Constructor of object
  Peppa()
  {
    // Starting position
    peppa_x = 0;
    peppa_y = 245;
  }

  // Draw a character
  void drawPeppa()
  {
    p.advance(o); // Movement

    // Swith images of Peppa in different situations
    if (dance > 0) // Peppa dances
    {
      if (((frameCount/10)%2) == 1)
      {
        peppa = loadImage("peppa_dance1.png");
      } else
      {
        peppa = loadImage("peppa_dance2.png");
      }
      dance--;
    } else if (stucked == true) // Peppa stuck
    {
      peppa = loadImage("peppa_stuck.png");
      stucked = false;
    } else // Default images
    {
      if (direction==0) // Peppa goes right
      {
        if (((frameCount/10)%2) == 1) // Two images switches each 10 frames
        {
          peppa = loadImage("peppa-1.png");
        } else
        {
          peppa = loadImage("peppa-2.png");
        }
      } else // Peppa goes left
      {
        if (((frameCount/10)%2) == 1)  // Two images switches each 10 frames 
        {
          peppa = loadImage("peppa-3.png");
        } else
        {
          peppa = loadImage("peppa-4.png");
        }
      }
    }

    image (peppa, peppa_x, peppa_y);
  }

  // Movement 
  void advance (Obstruction o[])
  {
    // Check if the obstructions are on the Peppa's path
    for (int i=0; i<numOfObstr; i++)
    {
      movement1 = p.collision1 (i, o);
      movement2 = p.collision2 (i, o);
      movement3 = p.collision3 (i, o);
      movement4 = p.collision4 (i, o);
    }

    if (movement1 == false) // If there is an obstruction at right of Peppa
    {
      if (peppa_x <= 0) // If Peppa at the left side of the screen
      {
        stucked = true; // The image of Peppa will be changed
        if ((frameCount%5) == 0)
        {
          // Peppa lose 1 health point each 5 frames
          health--;

          // The special sound if Peppa stuck
          stuck.play();
          stuck.rewind();

          // If Peppa lose all healt points the game stops
          if (health <= 0)
          {
            play = 2;
          }
        }
      } else // If Peppa is not at the left side of the screen, she moves at left
      {
        peppa_x-=1;
      }
    }

    // Control with a keyboard
    if (keyPressed == true)
    {
      if (keyCode == RIGHT)
      {
        direction = 0;
        if (peppa_x < 740 && movement1 == true) // If there are no obstructions at right and Peppa is not at the right side of the screen
        {
          peppa_x+=5; // Peppa moves at right
        } else
        {
          // Special sound if Peppa cannot move
          cantMove.play();
          cantMove.rewind();
        }
      }

      if (keyCode == LEFT)
      {
        direction = 1;
        if (peppa_x > 5 && movement2 == true) // If there are no obstructions at left and Peppa is not at the left side of the screen
        {
          peppa_x-=5; // Peppa moves at left
        } else
        {
          // Special sound if Peppa cannot move
          cantMove.play();
          cantMove.rewind();
        }
      }

      if (keyCode == UP) 
      {
        if (peppa_y > 0 && movement3 == true) // If there are no obstructions above and Peppa is not at the top of the screen
        {
          peppa_y-=5; // Peppa moves up
        } else
        {
          // Special sound if Peppa cannot move
          cantMove.play();
          cantMove.rewind();
        }
      }

      if (keyCode == DOWN) 
      {
        if (peppa_y < 480 && movement4 == true)  // If there are no obstructions below and Peppa is not at the down of the screen
        {
          peppa_y+=5; // Peppa moves down
        } else
        {
          // Special sound if Peppa cannot move
          cantMove.play();
          cantMove.rewind();
        }
      }
    }

    // Restart variables before the next attepmt to move
    movement1 = true;
    movement2 = true;
    movement3 = true;
    movement4 = true;
  }

  // Check if there are obstructions at right of Peppa
  boolean collision1 (int i, Obstruction o[])
  {
    if (peppa_x < o[i].obstruction_x & peppa_x > (o[i].obstruction_x - 70) & peppa_y > (o[i].obstruction_y - 70) & peppa_y < (o[i].obstruction_y + 70))
    {
      movement1 = false;
    }
    return(movement1);
  }

  // Check if there are obstructions at left of Peppa
  boolean collision2 (int i, Obstruction o[])
  {
    if (peppa_x > o[i].obstruction_x & peppa_x < (o[i].obstruction_x + 70)  & peppa_y > (o[i].obstruction_y - 70) & peppa_y < (o[i].obstruction_y + 70))
    {
      movement2 = false;
    }
    return(movement2);
  }

  // Check if there are obstructions above Peppa
  boolean collision3 (int i, Obstruction o[])
  {
    if (peppa_y > o[i].obstruction_y & peppa_y < (o[i].obstruction_y + 70) & peppa_x > (o[i].obstruction_x - 70) & peppa_x < (o[i].obstruction_x + 70))
    {
      movement3 = false;
    }
    return(movement3);
  }

  // Check if there are obstructions below Peppa
  boolean collision4 (int i, Obstruction o[])
  {
    if (peppa_y < o[i].obstruction_y & peppa_y > (o[i].obstruction_y - 70) & peppa_x > (o[i].obstruction_x - 70) & peppa_x < (o[i].obstruction_x + 70))
    {
      movement4 = false;
    }
    return(movement4);
  }
}
