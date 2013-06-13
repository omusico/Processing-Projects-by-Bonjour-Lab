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
		for (int j = 0; j<=nCircles; j++) {  
			//changement du nombre de sections si utilisation de setSectionsForCircle(int,int);
			if(arraySections[j] != 0){nSections = arraySections[j];}

			//Dessins des composants de chaque cerlces
			for (int i = 0; i<=nSections; i++) {
	        strokeWeight(0);
	        if(arrayHigthLight[j] >= 1){
	        	if( arrayHigthLight[j] == i){
	        		fill(32, 141, 134, 255);
	        	}else{
	        		fill(32, 141, 134, 100);
	        	}
			}else{
				fill(32, 141, 134, 100);
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
          vertex(x*hauteur, y*hauteur);
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