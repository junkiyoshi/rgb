import java.util.*;

ArrayList<Mover> movers;
PVector preMousePosition;

float xnoise;
float ynoise;


void setup()
{
  fullScreen();
  frameRate(30);
  blendMode(ADD);
  movers = new ArrayList<Mover>();
  preMousePosition = new PVector(mouseX, mouseY);
  
  xnoise = random(10);
  ynoise = random(10);
}

void draw()
{
  background(0);  
  
  movers.add(new Mover(new PVector(width / 2 + 50 * cos(radians(frameCount + 120)), height / 2 + 50 * sin(radians(frameCount + 120))), color(24,0,0)));
  movers.add(new Mover(new PVector(width / 2 + 50 * cos(radians(frameCount)), height / 2 + 50 * sin(radians(frameCount))), color(0,24,0)));
  movers.add(new Mover(new PVector(width / 2 + 50 * cos(radians(frameCount - 120)), height / 2 + 50 * sin(radians(frameCount - 120))), color(0,0,24)));
  
  PVector NoiseForce = new PVector(map(noise(xnoise), 0, 1, -5, 5), map(noise(ynoise), 0, 1, -5, 5));
  for(Mover m : movers)
  {
    m.appyForce(NoiseForce);
  }
  
  xnoise += 0.05;
  ynoise += 0.05;
  
  Iterator<Mover> it = movers.iterator();
  while(it.hasNext())
  {
    Mover m = it.next();
    m.run();
    
    if(m.isDead())
    {
      it.remove();
    }
  }
  
  /*
  stroke(255);
  fill(0);
  rect(width / 2, height / 2, 100, 100);
  */
}

void mouseMoved()
{
  PVector MousePosition = new PVector(mouseX, mouseY);
  PVector MouseForce = PVector.sub(MousePosition, preMousePosition);
  MouseForce.normalize();
  
  pushMatrix();
  translate(width / 2, height / 2);
  popMatrix();
  
  for(Mover m : movers)
  {
    m.appyForce(MouseForce);
  }
  
  preMousePosition = MousePosition;
}