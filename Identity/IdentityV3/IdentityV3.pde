Module circle;

int space = 11;
int module ; 
int shape ; 
int[] numbers = new int[20];
int[] modules = new int[20];
int lol = 0;
int position = 370;
String sujet = "Mike";

ArrayList<Module> moduleFarm = new ArrayList<Module>();

void setup(){


  frameRate(10);
  int moduleNumber = 3;

  //-------------- VARIABLES A RENSEIGNER ----------------------
  
  numbers[0]= 18; //heure de naissance 
  numbers[1]= 30;  //minute de naissance
  numbers[2]= int(random(1, 61)); // seconde de naissance

  numbers[3]= 10; //jour de naissance
  numbers[4]= 10;  //mois de naissance
  numbers[5]= 86; // année de naissance

  numbers[6]= 1; //sexe
  numbers[7]= 6; //departement
  numbers[8]= 1; //nombre pre
//-------------- FIN VARIABLES A RENSEIGNER ----------------------

  modules[0]= 24; //heure 
  modules[1]= 60;  //minute 
  modules[2]= 60; // seconde 

  modules[3]= 30; //jour 
  modules[4]= 12;  //mois 0
  modules[5]= 100; // année 

  modules[6]= 2; //sexe
  modules[7]= 100; //departement
  modules[8]= 1; //??
	
  size(int(1000*1.2), int(400*1.2));
	background(0);  
	smooth();

  for (int i=0; i<moduleNumber; i++)
  { 
      moduleFarm.add(new Module(0,0));   
  }
}

void draw(){
	background(0);
  int k = 0;

  for(int i = 0; i < moduleFarm.size(); i++)
  {
    Module m = moduleFarm.get(i);
   

     m.setCircles(4,(space*0.1));
    
    for (int j = 0; j<3; j++){
      shape = int(random(1,5));
      if(shape == 2){shape = 3;}
      pushMatrix();
        if(i == 0){
          translate(width-((width/2)+position), height/2);
          
        }else if (i == 1) {
          translate(width-(width/2), height/2);
          
        }else if (i == 2) {
          translate(width-((width/2)-position), height/2);
          textSize(10);
        }

        m.setShapeForCircle(j+1,shape);

        if(shape == 1 || shape == 2){
            m.setSectionsForCircle(j+1,modules[k]);
            m.setHightligthForCircle(j+1,numbers[k]);
        }else if (shape == 3 || shape == 4){
            m.setSectionsForCircle(j+1,(modules[k]*2));
            m.setHightligthForCircle(j+1,(numbers[k]*2));
        }

          println(numbers[k]+" / "+modules[k]);
        k++;
         // !!!!!!
        
        m.render();
        popMatrix();
      }
  }
    noLoop();
    saveFrame(sujet+".jpg");
    exit();
}

public class Module
{
  float nSections = 0;
  float nSpace = 0;
  float nCircles = 0;
  float x,y,k,op;
  float r = 100;
  float a = 0.0;
  float space = 1;
  float hauteur = 1.2;
  int[] arraySections = new int[10];
  int[] arrayShapes = new int[10];
  int[] arrayHigthLight = new int[10];
  
  //--------------------------------------
  //  CONSTRUCTOR
  //--------------------------------------
  
  public Module (float _x,float _y) {
    x = _x;
    y = _y;
  }

  public Module (float _x,float _y, int _dataOne,int _dataTwo,int _dataThree ) {
    int dataOne = _dataOne;
    int dataTwo = _dataTwo;
    int dataThree = _dataThree;

    setSectionsForCircle(1,dataOne);
    setSectionsForCircle(2,dataTwo);
    setSectionsForCircle(3,dataThree);
    
    x = _x;
    y = _y;
  }

  public void setCircles(float _nCircles, float _nSpace) {
    nSpace = _nSpace;
    nCircles = _nCircles;
    
  }

  public int setSectionsForCircle(int _circle, int _sections) {
    int circle = _circle;
    int sections = _sections;
    return arraySections[circle] = sections;
  }

  public int setHightligthForCircle(int _circle, int _sections) {
    int circle = _circle;
    int sections = _sections;
    return arrayHigthLight[circle] = sections;  
  }

  public int setShapeForCircle(int _circle,int _shape) {
    int shape = _shape;
    int circle = _circle;
    return arrayShapes[circle] = shape;
  }

  public void render() {
    rotate(4.7);
    for (int j = 0; j<=nCircles; j++) { 
      //rotate(180); 
      //changement du nombre de sections si utilisation de setSectionsForCircle(int,int);
      if(arraySections[j] != 0){nSections = arraySections[j];}

      //Dessins des composants de chaque cerlces
      for (int i = 0; i<=nSections; i++) {
      float op = int(random(30,150));
          strokeWeight(0);
          if(arrayHigthLight[j] >= 1){
            if( arrayHigthLight[j] == i){
              fill(255);
            }else{
              fill(32, 141, 134, op);
            }
      }else{
        fill(32, 141, 134, op);
      }
          //Module simple
            x = r*cos(a)*0.4*(j*nSpace);
            y = r*sin(a)*0.4*(j*nSpace);
            noStroke();
            strokeWeight(0);
            
        customCircle(j,i,nCircles);
        
          //changement de l'angle
          a = TWO_PI / (nSections/i);
        }
      }
  }

  public void customCircle(int _j, int _i, float _nCircles){
    float nCircles = _nCircles;
    int i = _i;
    int j = _j;

    for (int k = 0; k<nCircles; k++){
      if(j == k){
      if(arrayShapes[j] != 0){
        if(arrayShapes[j] == 1){
          moduleCircle(5);
        }else if (arrayShapes[j] == 2) {
          moduleLine(i);  
        }else if (arrayShapes[j] == 3) {
          moduleTriangle(i);
        }else if (arrayShapes[j] == 4) {
          moduleSquare(i);
        }
      }else{
        //moduleCircle(10);
      }
    }
  } 
  }

  public void moduleSquare(int _i) {
    int i = _i;
      if (i%2 != 0) {
          beginShape();
          vertex(x, y);
          vertex(x*hauteur, y*hauteur);
        
        }else {
          vertex(x*hauteur, y*hauteur);
          vertex(x, y);
          endShape();
        }
  }

  public void moduleCircle(float _sizeCircle) {
    float sizeCircle = _sizeCircle;
    ellipse(x, y, sizeCircle, sizeCircle);
  }

  public void moduleTriangle(int _i) {
    int i = _i;
      if (i%2 != 0) {
          beginShape(TRIANGLES);
          vertex(x, y);
          vertex(x*hauteur, y*hauteur);
        
        }else {
          vertex(x, y);
          endShape();
        }
  }

  public void moduleLine(int _i) {
    int i = _i;
    stroke(32, 141, 134);     
          beginShape(LINES);
          vertex(x, y);
          vertex(x*hauteur, y*hauteur);
        endShape();
        
  }
}
