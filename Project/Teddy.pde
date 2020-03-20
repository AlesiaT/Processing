class Teddy
{ 
  // X and Y coordinates
  int teddy_x, teddy_y;

  // Constructor of object
  Teddy()
  {
    // Starting positions
    teddy_x=((int)random(8)* 80) + 160;
    teddy_y=(int)random(7)* 80;

    // Image
    teddy = loadImage("teddy.png");
  }

  // Restart of position if Peppa take teddy
  void newTeddy(int peppa_x, int peppa_y, Obstruction o[])
  {
    teddy_x=((int)random(9)* 80) + 80;
    teddy_y=(int)random(7)* 80;
    t.checking(peppa_x, peppa_y, o); // Check if position is allowed
  }

  // Check if teddy overlap with something
  void checking(int peppa_x, int peppa_y, Obstruction o[])
  {
    // Overlapping with obstructions
    for (int i=0; i<numOfObstr; i++)
    {
      if (teddy_x > (o[i].obstruction_x - 80) & teddy_x < (o[i].obstruction_x + 80) & teddy_y > (o[i].obstruction_y - 80) & teddy_y < (o[i].obstruction_y + 80))
      {
        t.newTeddy(peppa_x, peppa_y, o); // If position is not free, it restarts
      }
    }

    // Check if teddy is too close to Peppa
    if (teddy_x > (peppa_x - 160) & teddy_x < (peppa_x + 160) & teddy_y > (peppa_y - 160) & teddy_y < (peppa_y + 160))
    {
      t.newTeddy(peppa_x, peppa_y, o); // If position is prohibited, it restarts
    }
  }

  // Teddy moves left to create an illusion of moving Peppa
  void advance(int peppa_x, int peppa_y, Obstruction o[])
  {
    if ((frameCount%2) == 0)
    {
      teddy_x-=1;
    }
    if (teddy_x<=0) // When teddy achieve left side of the screen
    {
      // Counter of lost teddies increases
      lostTeddy++;

      // Special sound for lost teddies
      teddyLost.play();
      teddyLost.rewind();

      // Restart of position
      t.newTeddy(peppa_x, peppa_y, o);
    }
  }

  // Drawing
  void drawTeddy(int peppa_x, int peppa_y, Obstruction o[])
  {
    t.advance(peppa_x, peppa_y, o); // Calculate new position
    t.collect(peppa_x, peppa_y, o); // Check if Peppa take teddy
    image (teddy, teddy_x, teddy_y);
  }

  // Checking if Peppa take teddy
  void collect(int peppa_x, int peppa_y, Obstruction o[])
  {
    // Check if Peppa is close enough
    if (peppa_x < teddy_x && peppa_x > (teddy_x - 40) && peppa_y > (teddy_y - 40) && peppa_y < (teddy_y + 40))
    {
      // Counter of collected teddies increases
      foundTeddy++;

      // Special sound for collected teddies
      teddyFound.play();
      teddyFound.rewind();

      // Restart of position
      t.newTeddy(peppa_x, peppa_y, o);

      // Peppa will dance during 50 frames
      dance = 50;
    } 

    // Other checkings of Peppa's and teddy's positions just for having not too long condition statement.
    // If the conditions are met, the same events occur as described above.
    else if (peppa_x > teddy_x && peppa_x < (teddy_x + 40) && peppa_y > (teddy_y - 40) && peppa_y < (teddy_y + 40))
    {
      foundTeddy++;
      teddyFound.play();
      teddyFound.rewind();
      t.newTeddy(peppa_x, peppa_y, o);
      dance = 50;
    } else if (peppa_y > teddy_y && peppa_y < (teddy_y + 40) && peppa_x > (teddy_x - 40) & peppa_x < (teddy_x + 40))
    {
      foundTeddy++;
      teddyFound.play();
      teddyFound.rewind();
      t.newTeddy(peppa_x, peppa_y, o);
      dance = 50;
    } else if (peppa_y < teddy_y && peppa_y > (teddy_y - 40) && peppa_x > (teddy_x - 40) && peppa_x < (teddy_x + 40))
    {
      foundTeddy++;
      teddyFound.play();
      teddyFound.rewind();
      t.newTeddy(peppa_x, peppa_y, o);
      dance = 50;
    }
  }
}
