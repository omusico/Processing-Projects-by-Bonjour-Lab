import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;
ControlFrame cf;
Module circle;

int sections = 10;
int space = 1;

int circleOne = 10; 
int circleTwo = 10;
int circleThree = 10;

int shapeOne = 3; 
int shapeTwo = 3;
int shapeThree = 3;

int h1,h2,h3;

void setup(){
	size(600, 600);
	background(0);  
	smooth();
	circle = new Module(0,0);
	cp5 = new ControlP5(this);
  	cf = addControlFrame("extra", 200,400);
}

void draw(){
	background(0);
	translate(width/2, height/2);

	circle.setCircles(4,(space*0.1));

	circle.setShapeForCircle(1,shapeOne);
	circle.setSectionsForCircle(1,circleOne);
  circle.setHightligthForCircle(1,h1);

	circle.setShapeForCircle(2,shapeTwo);
	circle.setSectionsForCircle(2,circleTwo);
  circle.setHightligthForCircle(2,h2);

	circle.setShapeForCircle(3,shapeThree);
	circle.setSectionsForCircle(3,circleThree);
  circle.setHightligthForCircle(3,h3);


	circle.render();
	println("circleTwo: "+circleTwo);
}



  // Fenetre de controle ----------------

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;
  	int sectionsCOne, sectionsCTwo,sectionsCThree;
  	int shape1, shape2,shape3;
  	int spaceCp5;
    int hl1, hl2, hl3;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);

    cp5.addSlider("sectionsCOne").setRange(0, 100).setPosition(10,10);
    cp5.addSlider("sectionsCTwo").setRange(0, 100).setPosition(10,30);
    cp5.addSlider("sectionsCThree").setRange(0, 100).setPosition(10,50);


    cp5.addSlider("shape1").setRange(0, 4).setPosition(10,80);
    cp5.addSlider("shape2").setRange(0, 4).setPosition(10,100);
    cp5.addSlider("shape3").setRange(0, 4).setPosition(10,120);

    cp5.addSlider("spaceCp5").setRange(1, 100).setPosition(10,150);

    cp5.addSlider("hl1").setRange(0, 100).setPosition(10,200);
    cp5.addSlider("hl2").setRange(0, 100).setPosition(10,220);
    cp5.addSlider("hl3").setRange(0, 100).setPosition(10,240);
  }

  public void draw() {
    circleOne = sectionsCOne*2;
  	circleTwo = sectionsCTwo*2;
  	circleThree = sectionsCThree*2; 

   shapeOne = shape1; 
	 shapeTwo = shape2;
	 shapeThree =shape3;

   h1 = hl1*2;
   h2 = hl2*2;
   h3 = hl3*2;

	space = spaceCp5;
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

  
}
