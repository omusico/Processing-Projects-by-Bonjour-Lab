// Leap2Gml
// turn your leap motion information into a gml file
// Author : fabien bonnamy

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


PVector f_position   ;
PVector f_direction  ;
Vec3D canvas;
Vec3D v ;
LeapMotion leap;
int fingerNumber = 0;
// Declare a GML recorder object

GmlRecorder recorder;
GmlParser parser;
GmlSaver saver;
GmlBrushManager brushManager;
float scale;
Gml gml;
Timer timer = new Timer();
Timer recordTimer = new Timer();

// triggers
boolean isTouching = false; // switch the recorder on and off 
boolean isRecording = false; 
boolean isDrawing = false;
boolean playGrafiti = false; // switch wetween the record and the verification

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
      f_position   = finger.getPosition();
      f_direction  = finger.getDirection();

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
  if (playGrafiti == true) {
    showGmlVerification();
  } 
  else if (playGrafiti == false) {
    displayRecorder();
  }

  //display the time
  text("recordTimer"+recordTimer.getTime(), 20, 20);
  text("S : saving the gml", 20, 40);
  text("G : load the gml", 20, 60);
  text("P : Check the gml", 20, 80);
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

void showGmlVerification() {
  if (isDrawing == false) {
    timer.reset();
    isDrawing = true;
  }  
  timer.tick(1);
  animation();
}

void animation() {
  
  for (GmlStroke strok : gml.getStrokes()) {
    for (GmlPoint p : strok.getPoints()) {

      if (p.time > timer.getTime()){
        continue;
      }
      v = new Vec3D(p);
      v.scaleSelf(scale);
       stroke(10, 30);
    fill(0, 30);
      ellipse(v.x, v.y, 10, 10);
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
  else if (key == ' ') {
    recorder.clear();
    recordTimer.reset();
    isRecording = false;
  }
  else if (key == 'p' || key == 'P') {
    if (playGrafiti == false) {
      playGrafiti = true;
    }
    else if (playGrafiti == true) {
      playGrafiti = false;
    }
  }
  else if (key == 'g'|| key == 'G') {
    loadGml();
  }
}

