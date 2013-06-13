import processing.opengl.*;
// Importation de la librairie
import controlP5.*;


//Decalration d'un tableau dynamique
ArrayList<Particule> listeParticules;


// Instance de la classe ControlP5
ControlP5 controlP5;
ControlWindow controlWindow;
boolean controlP5Window = true;
Toggle voirGrid;
Toggle voirRepere;
Toggle voirLight;
Toggle controlBirds;
Toggle pointerBirds;
Toggle seeAttractor;
Slider cameraRX;
Slider cameraRY;
Slider cameraRZ;
Slider tailleBirds;
Slider poidBirds;
Slider envergureBirds;
Slider vitesseBirds;
Slider dirX;
Slider dirY;
Slider dirZ;

boolean Grille=false;
boolean Repere=false;
boolean Lumieres=false;
boolean controlOiseau=false;
boolean pointerOiseau=false;
boolean voirAttracteur=false;

int myColorBackground = color(0, 0, 0);

//enregistrement en PDF
import processing.pdf.*;
boolean record;

//variables décors
//Variable i pour la boucle for
int i;
//largeur du sketch
int w=900;
//hauteur du sketch
int h=900;
//position des mesh
int x;
int y;
//divsion - resolution
int s=10;

float k;
float m;
float r;
float j=.01;

int positionXDecors;

void setup()
{
  size(900, 900, OPENGL);
  //format de projection : 960*912(homotetie)
  smooth();
  frameRate(25);
  //hint(ENABLE_OPENGL_4X_SMOOTH);

  colorMode(HSB, 360, 100, 100, 100);

  // Objet qui va gérer les controles
  controlP5 = new ControlP5(this);

  // Création des controles
  //toggle grid, repere, light
  voirGrid = controlP5.addToggle("Grille", false, 10, 10, 80, 20);
  voirRepere = controlP5.addToggle("Repere", false, 100, 10, 80, 20);
  voirLight = controlP5.addToggle("Lumieres", false, 190, 10, 80, 20);
  //camera
  cameraRX = controlP5.addSlider("Rotation camera X", -width*2, width*2, width/2, 10, 60, 150, 10);
  cameraRY = controlP5.addSlider("Rotation camera Y", -height*2, height*2, height/2, 10, 80, 150, 10);
  cameraRZ = controlP5.addSlider("Rotation camera Z", -1500, 1500, 1000, 10, 100, 150, 10);
  //toogle controle Oiseau
  controlBirds = controlP5.addToggle("controlOiseau", false, 10, 200, 80, 20);  
  pointerBirds = controlP5.addToggle("pointerOiseau", false, 100, 200, 80, 20);
  seeAttractor = controlP5.addToggle("voirAttracteur", false, 190, 200, 80, 20);
  //controler le dessin des particules
  tailleBirds = controlP5.addSlider("taille de l'oiseau", 0, 300, 60, 10, 260, 150, 10);
  poidBirds = controlP5.addSlider("Poid", 0, 2, 0.2, 10, 280, 150, 10);
  envergureBirds = controlP5.addSlider("Envergure", 0, 10, 0.6, 10, 300, 150, 10);
  vitesseBirds = controlP5.addSlider("Vitesse", 0, 50, 20, 10, 320, 150, 10);

  //sens de oiseaux
  dirX = controlP5.addSlider("Direction X", 0, TWO_PI, PI, 10, 340, 150, 10);
  dirY = controlP5.addSlider("Direction Y", 0, TWO_PI, PI, 10, 360, 150, 10);
  dirZ = controlP5.addSlider("Direction Z", 0, TWO_PI, PI, 10, 380, 150, 10);

  //RadioButton
  RadioButton r = controlP5.addRadioButton("radio", 10, 140);
  /*r.deactivateAll(); // use deactiveAll to not make the first radio button active.
  r.add("arrivee", 0);
  r.add("vol", 1);
  r.add("depart", 2);*/

  // Fenêtre externe ? 
  if (controlP5Window)
  {
    controlP5.setAutoDraw(false);
    controlWindow = controlP5.addControlWindow("Interface", 100, 50, 300, 430);
    controlWindow.setBackground( color(0) );

    //controle Camera
    voirGrid.setWindow(controlWindow);
    voirRepere.setWindow(controlWindow);
    voirLight.setWindow(controlWindow);
    cameraRX.setWindow(controlWindow);
    cameraRY.setWindow(controlWindow);
    cameraRZ.setWindow(controlWindow);
    //controle oiseau
    controlBirds.setWindow(controlWindow);
    pointerBirds.setWindow(controlWindow);
    seeAttractor.setWindow(controlWindow);
    tailleBirds.setWindow(controlWindow);
    poidBirds.setWindow(controlWindow);
    envergureBirds.setWindow(controlWindow);
    vitesseBirds.setWindow(controlWindow);
    dirX.setWindow(controlWindow);
    dirY.setWindow(controlWindow);
    dirZ.setWindow(controlWindow);
    //r.setWindow(controlWindow);
  }

  //Creation des particules dynmaique
  listeParticules = new ArrayList<Particule>();
  listeParticules.add(new Particule(random(0, width), random(0, height/2), random(0, -height+(height/4))));
}

void draw()
{
  // Debut enregistrement PDF
  if (record) {
    beginRaw(PDF, "output-####.pdf");
  }
  
  //Scene
  background(0, 0, 0);
  displayCamera();
  display3Dworld();
  controlBirds();
  pointBirds();
  seeAttractor();

  //Ajout de particules
  if (mousePressed==true)
  {
    listeParticules.add(new Particule(random(0, width), random(0, height/2), random(500, 800)));
    //println(listeParticules.size());
  }
  for (Particule p : listeParticules)
  {
    p.display();
  }
  
  //nommage particule et gestion dynamique
  for (int i=0; i<listeParticules.size(); i++)
  {
    Particule pi = listeParticules.get(i);
    //attracteur
    float distance = dist(pi.x, pi.y, mouseX, mouseY);
    float attracteur = map(distance, 0, 500, 0, 10);
    float xAttractor = map(mouseX-pi.x, -250, 250, -attracteur, attracteur);
    float yAttractor = map(mouseY-pi.y, -250, 250, -attracteur, attracteur);
    if (distance>100)
    {
      pi.x=pi.x+xAttractor;
      pi.y=pi.y+yAttractor;
    }
    //println("attracteur = "+attracteur+"   distance = "+distance+"   xAttractor = "+xAttractor+"   yAttractor = "+yAttractor);
    if (pi.z<=-height) {
      listeParticules.remove(pi);
    }
  }  

  // Fin enregistrement PDF
  if (record) {
    endRaw();
    record = false;
  }
}

