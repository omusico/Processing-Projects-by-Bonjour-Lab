import de.voidplus.leapmotion.*;
import org.apache.log4j.PropertyConfigurator;
import toxi.math.conversion.*;
import toxi.geom.*;
import toxi.math.*;
import toxi.geom.mesh2d.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.math.noise.*;
import gml4u.brushes.CurvesDemo;
import gml4u.drawing.GmlBrushManager;
import gml4u.events.GmlEvent;
import gml4u.events.GmlParsingEvent;
import gml4u.model.GmlBrush;
import gml4u.model.GmlConstants;
import gml4u.model.GmlStroke;
import gml4u.model.Gml;
import gml4u.recording.GmlRecorder;
import gml4u.utils.GmlParser;
import gml4u.utils.GmlSaver;
import toxi.geom.Vec3D;
import gml4u.brushes.*;
import gml4u.drawing.*;
import gml4u.utils.*;
import gml4u.utils.Timer;
import gml4u.model.*;
import java.util.*;


int     f_id         ;
PVector f_position   ;
PVector f_stabilized ;
PVector f_velocity   ;
PVector f_direction  ;
float   f_time       ;
Vec3D canvas;
Vec3D v ;
Vec3D oldv ;
LeapMotion leap;
int fingerNumber = 0;
// Declare a GML recorder object

GmlRecorder recorder;
GmlParser parser;
GmlSaver saver;
GmlBrushManager brushManager;
float scale;
int playGrafiti = 0;
Gml gml;
Timer timer = new Timer();
Timer recordTimer = new Timer();

// triggers
boolean isTouching = false; // switch on and off the recorder
boolean isRecording = false;
boolean isDrawing = false;
boolean firstTurnAnimation = true;

void setup() {
  size(800, 500, P3D);
  gmlSetups(); // all the setups required for the gml tools to work
  leap = new LeapMotion(this);//leap motion
  recordTimer.setStep(1);
  loadGml();
}

void draw() {
  background(255);
  int fps = leap.getFrameRate();
  //frameRate(fps);
  frameRate(57); // if no leap motion

  // start hand detection ______
  // HANDS
  for (Hand hand : leap.getHands()) {
    fingerNumber = 0;
    PVector hand_position    = hand.getPosition();
    // FINGERS
    for (Finger finger : hand.getFingers()) {
      if(fingerNumber < 1){
          // Basics
      finger.draw();
      f_id         = finger.getId();
      f_position   = finger.getPosition();
      f_stabilized = finger.getStabilizedPosition();
      f_velocity   = finger.getVelocity();
      f_direction  = finger.getDirection();
      f_time       = finger.getTimeVisible();

      // pushMatrix();
      // translate(hand_position.x, hand_position.y, hand_position.z);
      // float rotation = PVector.angleBetween(hand_position, f_position);
      // println("rotation: "+rotation);
      // line(hand_position.x, hand_position.y, hand_position.z, f_position.x, f_position.y, f_position.z);
      // popMatrix();
      if (f_position.z > 30) {
        if (isTouching ==  false) {
          startRecording();
          isTouching = true;
        }
        recording();
      }
      else if (f_position.z < 30) {
        if (isTouching == true) {
          stopRecording();
          isTouching = false;
        }
      }
      }
    
      fingerNumber++;
    }
  } // stop hand detection ______

  //display grafiti
  if (playGrafiti == 1) {
    displayAnimation();
  } 
  else if (playGrafiti == 0) {
    displayRecorder();
  }

  //display the time
  text("recordTimer"+recordTimer.getTime(), 20, 20);
  text("S : saving the gml", 20, 40);
  text("G : load the gml", 20, 60);
  text("P : Play the animation", 20, 80);
  text("L : Display stroke path", 20, 100);
}

void gmlSetups() {
  PropertyConfigurator.configure(sketchPath+"/log4j.properties");

  canvas = new Vec3D(800, 500, 110); // The recording area
  recorder = new GmlRecorder(canvas, 0.015f, 0.01f);  // Recorder
  brushManager = new GmlBrushManager(this);  // BrushManager: used to draw
  scale = width; // Scale: used to scale back the Gml points to their original size

  parser = new GmlParser(500, "", this); // GmlParser to load a Gml file
  parser.start();

  saver = new GmlSaver(500, "", this);  // GmlSaver to save a Gml
  saver.start();

  timer.start();
}

// Callback method
void gmlEvent(GmlEvent event) {
  // Check if the event was sent by the parser 
  if (event instanceof GmlParsingEvent) {
    // If so, get the Gml
    Gml gml = ((GmlParsingEvent) event).gml;
    recorder.setGml(gml);
  }
}

// recording the stroke -----------
void startRecording() {
  if (isRecording == false) {
    recordTimer.start();
    isRecording = true;
  }
  else {
    recordTimer.pause(!recordTimer.paused());
  }		

  GmlBrush brush = new GmlBrush();
  brush.set(GmlBrush.UNIQUE_STYLE_ID, CurvesDemo.ID);
  recorder.beginStroke(0, 0, brush);
}

void recording() {
  recordTimer.tick();
  int timeR = int(recordTimer.getTime());
  //addPoint(int sessionID, Vec3D v, final float time, final float pressure, final Vec3D rotation, final Vec3D direction);

  recorder.addPoint(0, 
    new Vec3D(f_position.x/canvas.x, f_position.y/canvas.y, f_position.z/canvas.z), 
    float(timeR),
    (f_position.z/117),
    new Vec3D(0,0,0),
    new Vec3D(f_direction.x,f_direction.y,f_direction.z));
}

void stopRecording() {
  recordTimer.pause(!recordTimer.paused());
  recorder.endStroke(0);
}
//----------------------------------

//Choice of the display
void displayRecorder() {
  //reset the animation timer for futur launch
  timer.reset();
  for (GmlStroke stroke : recorder.getStrokes()) { 
    stroke(10, 30);
    fill(0, 30);
    brushManager.draw(stroke, scale);
  }
}

void displayAnimation() {
  if (isDrawing == false) {
    timer.reset();
    isDrawing = true;
  }  
  timer.tick(1);
  animation1();
}

void animation1() {
  
  for (GmlStroke strok : gml.getStrokes()) {
    for (GmlPoint p : strok.getPoints()) {

      if (p.time > timer.getTime()){
        continue;
      }
      
      v = new Vec3D(p);
      v.scaleSelf(width);
      fill(77,12,26);
       //line(oldv.x, oldv.y, oldv.z, v.x, v.y, v.z);
      ellipse(v.x, v.y, 20, 20);
    }
  }
}

void animation2() {
  
  for (GmlStroke strok : gml.getStrokes()) {
    for (GmlPoint p : strok.getPoints()) {

      if (p.time > timer.getTime()) {

        continue;
      }
      v = new Vec3D(p);
      if(firstTurnAnimation == true){
        oldv = new Vec3D(p);
        firstTurnAnimation = false;
      }

      v.scaleSelf(width);
      oldv.scaleSelf(width);
      fill(77,12,26);
  
      line(oldv.x, oldv.y, oldv.z, v.x, v.y, v.z);

      if(firstTurnAnimation == false){
        oldv = new Vec3D(p);
      }
    }
  }
}
//----------------------------------

void loadGml() {
  gml = GmlParsingHelper.getGml(sketchPath+"/gml.xml", false);
}

void keyPressed() {

  if (key == 's' || key == 'S') {
    saver.save(recorder.getGml(), sketchPath+"/gml.xml");
  }
  else if (key == 'l' || key == 'L') {
    parser.parse(sketchPath+"/gml.xml", false);
  }
  else if (key == ' ') {
    recorder.clear();
    recordTimer.reset();
  }
  else if (key == 'p' || key == 'P') {
    if (playGrafiti == 0) {
      playGrafiti = 1;
    }
    else if (playGrafiti == 1) {
      playGrafiti = 0;
    }
  }
  else if (key == 'g') {
    loadGml();
  }
}

