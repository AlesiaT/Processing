// This modification of arcanoid is a game with three balls and paddle.
// The characteristics of balls are different.
// The scores and remaining lives will be counted.
// 10 scores turns into 1 extra live.

// First ball
int x = 250; // Horizontal position of ball
int direction_x = 2; // Change in horizontal position each time draw() executed
int y = 150; // Vertical position of ball
int direction_y = 2; // Change in horizontal position each time draw() executed

// Second ball
int a = 150; // Horizontal position of ball
int direction_a = 3; // Change in horizontal position each time draw() executed
int b = 100; // Vertical position of ball
int direction_b = 4; // Change in horizontal position each time draw() executed

// Third ball
int c = 350; // Horizontal position of ball
int direction_c = 4; // Change in horizontal position each time draw() executed
int d = 200; // Vertical position of ball
int direction_d = 2; // Change in horizontal position each time draw() executed

int lives = 3;
int score = 0;

void setup()
{
  size (400,400); // Create a window 400*400 pixels
}

void draw()
{
  background(255,255,255); // Clear screen to white
  fill(0,255,0); // Set fill colour to red
  rect(0,mouseY-60,20,120); // Position rectangle using mouse
  
  // Create balls
  fill(255,0,0);
  ellipse(x,y,20,20); // Draw red disk centred on x,y with diameter 20
  
  fill(0,0,255);
  ellipse(a,b,20,20); // Draw blue disk centred on a,b with diameter 20
  
  fill(255,255,0);
  ellipse(c,d,20,20); // Draw yellow disk centred on a,b with diameter 20
  
  // Physics of the first ball
  x = x + direction_x;
  if (x > (width - 10)) direction_x = -direction_x;
  
  if (x < 10) // If ball bits left side of screen then miss..
  {
    direction_x = -direction_x; // Bounce
    x = 30; // Force x to beyond the paddle on a restart
    lives--; // Reduce lives by one
    if (lives == 0) exit(); // If lives is zero then quit
  }
  
  if ((x < 30)&&(abs(mouseY - y) < 60)) // If ball has bit paddle then..
  {
    direction_x = -direction_x; // Bounce
    x = 30; // Force x to beyond the paddle on a restart
    score++; // Increase score by one
  }
  
  y = y + direction_y; // New position equals old position plus change in direction
  if (y < 10) direction_y = -direction_y; // Reverse direction if hit boundary
  if (y > (height - 10)) direction_y = -direction_y;
  
  // Physics of the second ball
  a = a + direction_a;
  if (a > (width - 10)) direction_a = -direction_a;
  
  if (a < 10) // If ball bits left side of screen then miss..
  {
    direction_a = -direction_a; // Bounce
    a = 30; // Force x to beyond the paddle on a restart
    lives--; // Reduce lives by one
    if (lives == 0) exit(); // If lives is zero then quit
  }
  
  if ((a < 30)&&(abs(mouseY - b) < 60)) // If ball has bit paddle then..
  {
    direction_a = -direction_a; // Bounce
    a = 30; // Force a to beyond the paddle on a restart
    score++; // Increase score by one
  }
  
  b = b + direction_b; // New position equals old position plus change in direction
  if (b < 10) direction_b = -direction_b; // Reverse direction if hit boundary
  if (b > (height - 10)) direction_b = -direction_b;
  
  // Physics of the third ball 
  c = c + direction_c;
  if (c > (width - 10)) direction_c = -direction_c;
  
  if (c < 10) // If ball bits left side of screen then miss..
  {
    direction_c = -direction_c; // Bounce
    c = 30; // Force x to beyond the paddle on a restart
    lives--; // Reduce lives by one
    if (lives == 0) exit(); // If lives is zero then quit
  }
  
  if ((c < 30)&&(abs(mouseY - d) < 60)) // If ball has bit paddle then..
  {
    direction_c = -direction_c; // Bounce
    c = 30; // Force c to beyond the paddle on a restart
    score++; // Increase score by one
  }
  
  d = d + direction_d; // New position equals old position plus change in direction
  if (d < 10) direction_d = -direction_d; // Reverse direction if hit boundary
  if (d > (height - 10)) direction_d = -direction_d;
  
  // Adding extra lives
  if (score >= 10)
  {
    lives++;
    score -= 10;
  }
    
  textSize(32);
  fill(0,0,255);
  text(score,10,30); // Display score
  text(lives, width - 30,30); // Display lives    
}