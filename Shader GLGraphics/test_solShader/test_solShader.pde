// --------------------------------------------------------
import codeanticode.glgraphics.*;
import processing.opengl.*;
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import javax.media.opengl.*;

GLGraphicsOffScreen offscreenDisp;
PImage textureSol;
GLSLShader solShader;
GLTexture tex;

//camera
float xCam, zCam, yCam;
float angleCam;

//dessins
ArrayList<Pointer> myLight;

//shader
GLSLShader shader;
GLTexture tex2;



void setup()
{
  size(900, 900, GLConstants.GLGRAPHICS);

  //generation de texture
  offscreenDisp = new GLGraphicsOffScreen(this, width, height);
  solShader = new GLSLShader(this, "sol_vert.glsl", "sol_frag.glsl");
  tex = new GLTexture(this, "sol.jpg");
  textureMode(NORMALIZED);

  myLight = new ArrayList<Pointer>();
  myLight.add( new Pointer(random(width), random(height), random(1000)));

  //shader
  shader = new GLSLShader(this, "simple_vert.glsl", "simple_paint4_frag.glsl");
  tex2 = new GLTexture(this, "tex9.png");
  
  
  textureMode(NORMALIZED);
}

void draw()
{
  background(0);
  //lights();
 
  perspective(radians(50), float(width)/float(height), 10, -1000.0); // Field of view(angle de vue), ratio image, near field limit, far field limit
   
   
   //rotation Camera
   xCam = width/2*cos(radians(angleCam));
   zCam = 100*sin(radians(angleCam));
   yCam = height/2*sin(radians(angleCam));
   angleCam += radians(10.0);
   
   //Camera View
   beginCamera(); //
   camera(xCam,yCam,1000, width/2,height/2,0, 0,1,0); //posX, posY, posZ, cibleX, cibleY, cibleZ, OrientationX, OrientationY, OrientationZ
   endCamera();
   

  offscreenDisp.beginDraw();
  solShader.start();
  solShader.setTexUniform("tex", tex);
  solShader.setVecUniform("resolution", (float)width, (float)height);
  offscreenDisp.beginShape(QUADS);
  offscreenDisp.textureMode(NORMALIZED);
  offscreenDisp.texture(tex);
  offscreenDisp.vertex(0, 0, 0, 0, 0);
  offscreenDisp.vertex(width, 0, 0, 1, 0);
  offscreenDisp.vertex(width, height, 0, 1, 1);
  offscreenDisp.vertex(0, height, 0, 0, 1);
  offscreenDisp.endShape();
  solShader.stop();
  offscreenDisp.endDraw();

  pointLight(0, 0, 255, width/2, 0, -150);
  pointLight(255, 0, 0, width/2, height/2, -500);  
  pointLight(0, 255, 160, width/2, height/2, 300); 

  pushMatrix();
  translate(width/2, height/2+400, -300);
  rotateX(radians(90));
  translate(-width/2, -height/2);
  beginShape(QUADS);
  texture(offscreenDisp.getTexture());
  vertex(0, 0, 0, 0, 0);
  vertex(width, 0, 0, 1, 0);
  vertex(width, height, 0, 1, 1);
  vertex(0, height, 0, 0, 1);
  endShape();
  popMatrix();

  pushMatrix();
  translate(0, 0, -1000);
  
   //box(100);
    for (Pointer l : myLight)
  {
    l.motion();
    l.display();
  }

   
   
  popMatrix();


  float s = 0.25;
  image(offscreenDisp.getTexture(), 0, 0, s*width, s*height);
}

