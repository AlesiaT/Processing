import ddf.minim.*; // Minim is licensed under the GNU Lesser General Public License (LGPL), a copy of which is included with the distribution.
Minim minim;

// Create sounds
AudioPlayer sound, teddyFound, teddyLost, cantMove, stuck;

// Create images
PImage peppa, obstruction, back, teddy, arrows, bigTeddy, bigPeppa;

// Create variables
int play = 0; // determine the type of the screen (0 - start screen, 1 - game board, 2 - finish screen)
int numOfObstr = 25; // quantity of obstructions 
int foundTeddy = 0, lostTeddy = 0; // counter of founded and lost teddies
int dance = 0; // used as a switcher for dance animation
int health = 100; // number of health points
int scores = 0; // number of scores
boolean stucked = false; // if Peppa stucked
boolean newGame = true; // helps to restart the game and variables after losing

// Create objects
Peppa p;
Obstruction [] o;
Teddy t;

void setup()
{
  size(800, 560);

  // Background song
  minim = new Minim (this);
  sound = minim.loadFile ("PeppaPig.mp3");
  sound.loop();

  // Music for different situations
  teddyFound = minim.loadFile ("teddyFound.mp3");
  teddyLost = minim.loadFile ("teddyLost.mp3");
  cantMove = minim.loadFile ("obstruction.mp3");
  stuck = minim.loadFile ("health.mp3");

  // Images
  back = loadImage("back.png");
  arrows = loadImage("arrow-keys.png");
  bigTeddy = loadImage("bigteddy.png");

  // Assign parameters of objects
  p = new Peppa();

  o = new Obstruction[numOfObstr]; // As many obstructions as variable "numOfObstr" contains
  for (int i = 0; i < numOfObstr; i++)
  {
    o[i] = new Obstruction();
  }

  t = new Teddy();
  t.checking(p.peppa_x, p.peppa_y, o); // Extra checking to avoid overlap teddy and obstruction at start
}

void draw()
{
  if (play == 1) // Game screen
  {
    if (newGame == true) // Run after finishing and creating a new game
    {
      // Restart variables 
      p.direction = 0;
      foundTeddy = 0;
      lostTeddy = 0;
      health = 100;
      scores = 0;

      // Restart objects
      p = new Peppa();
      o = new Obstruction[numOfObstr]; 
      for (int i=0; i<numOfObstr; i++)
      {
        o[i]=new Obstruction();
      }
      t = new Teddy();
      t.checking(p.peppa_x, p.peppa_y, o);

      // Restart boolean
      newGame = false;
    }

    // Draw background
    background(back);

    // Draw objects
    p.drawPeppa();

    for (int i=0; i<numOfObstr; i++)
    {
      o[i].drawObstr(i);
    }

    t.drawTeddy(p.peppa_x, p.peppa_y, o);

    // Add health points if they are decreased
    health = healthUpdate(health);

    // Print out parameters on the screen
    textSize(18);                  
    fill(255, 0, 0); 
    text("Health: "+ health, 20, 20);  
    text("Collected Teddies: "+ foundTeddy, 600, 20);  
    text("Lost Teddies: "+ lostTeddy, 600, 40);
  } else if (play == 0) // Start screen
  {
    background(back);

    // Rules of game and images
    textSize(50);                  
    fill(255, 0, 0); 
    text("Peppa's Journey", 230, 50);

    textSize(40);
    text("Use arrows to move", 250, 200);
    image (arrows, 20, 120);

    textSize(40);
    text("Collect Teddies", 200, 370);
    image (bigTeddy, 20, 300);

    textSize(40);
    text("Press key S to start", 220, 530);

    // Animated image
    if (((frameCount/10)%2) == 1)
    {

      bigPeppa = loadImage("bigpeppa-3.png");
    } else
    {
      bigPeppa = loadImage("bigpeppa-4.png");
    }
    image (bigPeppa, 600, 250);

    // Check if a key is pressed to start game
    startGame();
  } else // finish screen
  {
    background(back);

    // Calculator of scores
    scores = foundTeddy*100 - lostTeddy*100;
    if (scores < 0) // Scores cannot be negative
    {
      scores = 0;
    }

    // Results
    textSize(50);  
    text("Collected Teddies: "+ foundTeddy, 20, 100);  
    text("Lost Teddies: "+ lostTeddy, 20, 200);
    text("Scores: "+ scores, 20, 300);
    text("To play again press key S", 20, 500);

    // Animated image
    if (((frameCount/10)%2) == 1)
    {

      bigPeppa = loadImage("bigpeppa-3.png");
    } else
    {
      bigPeppa = loadImage("bigpeppa-4.png");
    }
    image (bigPeppa, 500, 250);

    // Restart variables
    newGame = true;

    // Check if a key is pressed
    startGame();
  }
}

// Let to start new game at the beginning of after finish
int startGame ()
{
  if (keyPressed == true)
  {
    if (key == 's' || key == 'S')
    {
      play = 1;
    }
  }
  return (play);
}

// Add 1 health point eact 100 frames
int healthUpdate (int health)
{
  if (health < 100 && (frameCount%100) == 0)
  {
    health++;
  }
  return health;
}
