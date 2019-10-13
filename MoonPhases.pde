// This program shows Moon phases and UFO.

void setup()
{
  size(400, 400);
  stroke(10, 0, 40);
}

void draw()
{
  // Create a sky
  fill(10, 0, 40);
  rect(0, 0, 400, 300); 

  // Create a grass
  fill(0, 20, 0);
  rect(0, 300, 400, 100); 

  // Create the Moon
  fill(200, 200, 0);
  ellipse(200, 150, 150, 150);

  // Create craters on the Moon's surface
  fill(150, 150, 0);
  ellipse(220, 160, 15, 15);
  ellipse(170, 140, 40, 40);
  ellipse(230, 110, 20, 20); 
  ellipse(200, 180, 10, 10);

  // Animation: phases of the Moon
  phases(200);
  phases(500);
  phases(800);
  phases(1100);
  phases(1400);

  // Animation: UFO
  UFO (200, 45, 50);
  UFO (1000, 45, 50);  
  UFO (1050, 55, 60);
}

void phases(int x)
{
  // Draw a moving circle that obscures the invisible part of the Moon
  fill(10, 0, 40);
  ellipse((frameCount-x)*(-1), 150, 150, 150);
}

void UFO(int x, int y, int z)
{
  
  // Draw a moving UFO
  fill(100, 100, 100);
  ellipse((frameCount-x), y, 20, 10);
  fill(0, 60, 00);
  ellipse((frameCount-x), z, 30, 10);
}
