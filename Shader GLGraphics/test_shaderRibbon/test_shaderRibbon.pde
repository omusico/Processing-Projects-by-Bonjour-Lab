// --------------------------------------------------------
/*
RIBBON RACE V.1.0 - Based on an painting application using Kinect.
 Using Shader on Ribbon and ground + Light.
 
 Note : 
 • creer un GL Model du tracé
 • Retravailler le shader du tracé
 • Rajouter une trainée au tracé
 • Rajouter une ombre au sol
 • Rajouter CP5 de camera
 • Controles:
 • 'C' = changement de camera
 • 'L' = show Light
 • ' ' = save image
 
 -- Design&Code : Alexandre Rivaux at processing paris Workshop  -- www.bonjour-lab.com -- twitter : alexr4
 -- PPARIS : Processing Workshop by Free Art Bureau - Master Class : Julien 'V3ga'
 */
// --------------------------------------------------------
import codeanticode.glgraphics.*;
import processing.opengl.*;
import javax.media.opengl.*;

//sol
GLGraphicsOffScreen offscreenDisp;
GLSLShader solShader;
GLTexture tex;

Ground[] myGround;
int nbGround;
float y;

//camera
float xCam, zCam, yCam;
float angleCam;
int choiceCam;
Timer camTime;
int tempsCam = 5000;

//dessins
ArrayList<Pointer> myLight;
int nbRibbon;

//shader
boolean shaderActive;
textureRibbon myTexRibbon;
GLGraphicsOffScreen offscreenRibbon;
GLSLShader shader;
GLTexture tex2;


//windowscontrol
PFrame f;
secondApplet s;

boolean showLight;

void setup()
{
  size(900, 900, GLConstants.GLGRAPHICS);

  //generation de texture sol
  offscreenDisp = new GLGraphicsOffScreen(this, width, height);
  solShader = new GLSLShader(this, "sol_vert.glsl", "sol_frag.glsl");
  tex = new GLTexture(this, "sol.jpg");
  textureMode(NORMALIZED);

  nbGround = 2;
  myGround = new Ground[nbGround];
  for (int i=0; i<nbGround; i++)
  {
    myGround[i] = new Ground(i*height, i, 30);
  }

  nbRibbon = 10;
  myLight = new ArrayList<Pointer>();
  for (int i=0; i<nbRibbon; i++)
  {
    myLight.add( new Pointer(random(width), random(100, height/2+100), random(1000), 10, random(10, 60)));
  }

  //shader
  shaderActive = false;
  myTexRibbon = new textureRibbon();
  offscreenRibbon = new GLGraphicsOffScreen(this, width, height);
  shader = new GLSLShader(this, "simple_vert.glsl", "simple_paint3_frag.glsl");
  tex2 = new GLTexture(this, "tex9.png");
  textureMode(NORMALIZED);

  //controlWindow
  //PFrame f = new PFrame();
  choiceCam = (int)random(8);
  camTime = new Timer(tempsCam);
  camTime.start();
}

void draw()
{
  background(0);


  //offScreenDips Sol
  offscreenDisp.beginDraw();
  solShader.start();
  solShader.setTexUniform("tex", tex);
  solShader.setVecUniform("resolution", (float)width, (float)height);
  for (Ground g : myGround)
  {
    g.offScrennSolMove(offscreenDisp);
  }
  solShader.stop();
  offscreenDisp.endDraw();

  offscreenRibbon.beginDraw();
  offscreenRibbon.background(0);
  if (shaderActive == true)
  {
    shader.start();// debut du shader
    shader.setTexUniform("texture", tex2);
    shader.setVecUniform("deplacement", (float)mouseX, height-(float)mouseY); //envoi les coordonnées de la souris
    shader.setVecUniform("resolution", (float)width, (float)height);
    shader.setFloatUniform("time", millis()/2000.0);

    myTexRibbon.offScrennSolMove(offscreenDisp);
    shader.stop();
  }
  else
  {
    myTexRibbon.offScrennSolMove(offscreenDisp);
  }
  offscreenRibbon.endDraw();


  //perspective
  perspective(radians(50), float(width)/float(height), 10, -1000.0); // Field of view(angle de vue), ratio image, near field limit, far field limit

  //rotation Camera
  xCam = width/2*cos(radians(angleCam));
  zCam = 100*sin(radians(angleCam));
  yCam = height/2*sin(radians(angleCam));
  angleCam += radians(20);

  //Camera View
  beginCamera();
  if (choiceCam == 0)
  {
    camera(width/2, height/2, 1000, width/2, height/2, 0, 0, 1, 0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }
  if (choiceCam == 1)
  {
    camera(width/2, height-100, 500, width/2, height/2, 0, 0, 1, 0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }
  if (choiceCam == 2)
  {
    camera(width/2, -100, -width/2, width/2, height/2, -width/2, 1, 1, 1); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }
  if (choiceCam == 3)
  {
    camera(width/2, -100, -width/2, width/2, height/2, -width/2, 0, 1, 1); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }
  if (choiceCam == 4)
  {
    camera(xCam, yCam, 500, width/2, height/2, -width/2, 1, 1, 0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }
  if (choiceCam == 5)
  {
    camera(0, yCam, zCam, width/2, height/2, -width/2, 0, 1, 0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }  
  if (choiceCam == 6)
  {   
    camera(0, yCam, zCam, myLight.get(0).location.x, height/2, -width/2, 0, 1, 0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }  
  if (choiceCam == 7)
  {   
    camera(myLight.get(0).location.x, (height-myLight.get(0).location.z)-50, 0, myLight.get(0).location.x, height-myLight.get(0).location.z, -myLight.get(0).location.y, 0, 1, 0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }
  if (choiceCam == 8)
  {   
    camera(width/2, height/2-yCam, -width-800, width/2, height/2+100, -width/2, 0, 1, 0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
  }


  endCamera();

  //lumiere
  pointLight(0, 255, 160, width/2, 0, -width);
  pointLight(255, 255, 255, width/2, height-100, -500);  
  pointLight(105, 0, 255, width/2, 0, 0); 

  if (showLight == true)
  {
    pushStyle();
    strokeWeight(10);
    stroke(0, 255, 160);
    point(width/2, 0, -width);

    stroke(255, 255, 255);
    point(width/2, height-100, -500);

    stroke(105, 0, 255);
    point(width/2, 0, 0);
    popStyle();
  }
  //display
  pushMatrix();
  translate(0, height, -width);
  rotateX(radians(90));
  //translate(-width/2, -height/2);
  translate(0, 0, -100);

  beginShape(QUADS);
  texture(offscreenDisp.getTexture());
  vertex(0, 0, 0, 0, 0);
  vertex(width, 0, 0, 1, 0);
  vertex(width, height, 0, 1, 1);
  vertex(0, height, 0, 0, 1);
  endShape();


  for (Pointer l : myLight)
  {
    l.motion();
    l.display();
  }

  world();

  popMatrix();
  //camTime.stop();

  if (camTime.isFinished()) {
    //println("changement de cam");
    choiceCam = (int)random(8);
    camTime.start();
  }

  /*float s = 0.25;
   image(offscreenDisp.getTexture(), 0, 0, s*width, s*height);
   image(offscreenRibbon.getTexture(), 0, 250, s*width, s*height);*/
}

void keyReleased()
{

  if (key == ' ')
  {
    saveFrame("export_####.png");
  }
  if (key == 'c')
  {
    choiceCam += 1;
    if (choiceCam >8)
    {
      choiceCam =0;
    }
  }
  if (key == 'x')
  {
    shaderActive = !shaderActive;
  }
  if (key =='l')
  {
    showLight = !showLight;
  }
}

void world()
{
  pushStyle();
  pushMatrix();
  noFill();
  stroke(255, 20);

  rotateX(radians(90));
  rect(0, 0, width, height);

  translate(0, 0, -width);
  rect(0, 0, width, height);

  translate(0, 0, width);
  rotateY(radians(90));
  rect(0, 0, width, height);

  translate(0, 0, width);
  rect(0, 0, width, height);

  popMatrix();
  popStyle();
}

