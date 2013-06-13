

void keyPressed() {
  if (key == 'r') {
    record = true;
  }
}

void radio(int theID) {
  for (int i=0; i<listeParticules.size(); i++)
  {
    Particule pi = listeParticules.get(i);
    switch(theID) {
      case(0):
      pi.arrivee= !pi.arrivee;
      pi.vol= false;
      pi.depart= false;   
      break;  
      case(1):
      pi.arrivee= false; 
      pi.vol= !pi.vol;  
      pi.depart= false;  
      break;  
      case(2):
      pi.arrivee= false; 
      pi.vol= false;  
      pi.depart= !pi.depart;
      break;
    }
  }
}

void display3Dworld()
{
  //Grid
  if (Grille==true) 
  {
    //grid
    stroke(200, 100, 100, 20);
    for (int i=0; i<height; i+=40)
    {
      line(0, height, i*-1, width, height, i*-1);
      line(0, 0, i*-1, 0, height, i*-1);
    }

    for (int i=0; i<width; i+=40)
    {

      line(i, height, 0, i, height, -height);
      line(0, i, 0, 0, i, -height);
    }


    //world
    pushMatrix();
    noFill();
    stroke(200, 100, 100, 100);
    rectMode(CORNER);
    //fond
    rect(0, 0, width, height);
    translate(0, 0, -height);
    rotate(radians(90), 1, 0, 0);  
    rect(0, 0, width, height);
    rotate(radians(-90), 1, 0, 0);
    rect(0, 0, width, height);
    translate(0, height, 0);
    rotate(radians(90), 1, 0, 0);
    rect(0, 0, width, height);
    popMatrix();
  } 
  else {
  }

  //Light
  if (Lumieres==true) 
  {
    //light
    strokeWeight(10);
    stroke(0, 0, 100);
    //topRight
    pointLight(0, 0, 75, 0, 0, -height/2);  
    point(0, 0, -height/2);
    //topLeft
    pointLight(0, 0, 100, width, 0, -height/2);  
    point(width, 0, -height/2);
    //bottomRight
    pointLight(0, 0, 25, 0, height, -height/2);  
    point(0, height, -height/2);
    //bottomLeft
    pointLight(0, 0, 50, width, height, -height/2);  
    point(width, height, -height/2);
    strokeWeight(1);
  }
  else
  {
  }

  //Repere
  if (Repere==true) 
  {
    //Axes
    strokeWeight(3);
    stroke(250, 100, 100);
    line(-100, 0, 0, 100, 0, 0);
    stroke(100, 100, 100);
    line(0, -100, 0, 0, 100, 0);
    stroke(0, 100, 100);
    line(0, 0, -100, 0, 0, 100);
    strokeWeight(1);
  }
  else
  {
  }
}

void displayCamera()
{
  //camera de poursuite
  float cameraY = height/2.0;
  float fov = 500/float(width) * PI/2;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);
  //camera1
  camera(cameraRX.value(), cameraRY.value(), cameraRZ.value(), // eyeX, eyeY, eyeZ
  width/2, height/2, -height/2, // centerX, centerY, centerZ
  0.0, 1.0, 0.0); // upX, upY, upZ
}

void controlBirds()
{
  //activeControl = !activeControl;
  if (controlOiseau==true)
  {

    for (int i=0; i<listeParticules.size(); i++)
    {
      Particule pi = listeParticules.get(i);
      pi.taille = tailleBirds.value();
      pi.rapportTailleHauteur = poidBirds.value();
      pi.rapportTailleEnvergure = envergureBirds.value();
      pi.frequency = vitesseBirds.value();
      pi.rx = dirX.value();
      pi.ry = dirY.value();
      pi.rz = dirZ.value();
    }
  }
  else
  {
    //activeControl = !activeControl;
  }
}

void pointBirds()
{
  if (pointerOiseau==true)
  {
    for (int i=0; i<listeParticules.size(); i++)
    {
      Particule pi = listeParticules.get(i);
      //pointeur position particule
      strokeWeight(10);
      stroke(170, 100, 100);
      point(pi.newX, pi.newY, 0);
      strokeWeight(1);
      line(pi.newX, pi.newY, 0, pi.newX, pi.newY, pi.newZ);
    }
  }
  else
  {
  }
}

void seeAttractor()
{
  if (voirAttracteur == true)
  {
    noFill();
    stroke(170, 100, 100);
    strokeWeight(1);
    ellipse(mouseX, mouseY, 200, 200);
  }
  else
  {
  }
}

