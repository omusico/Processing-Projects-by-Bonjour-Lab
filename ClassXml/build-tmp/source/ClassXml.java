import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class ClassXml extends PApplet {

genericXml xml; 

public void setup(){
	//genericXml va creer la balise principale, l'argument lui donne son nom
	xml = new genericXml("testProcessing");
}

public void draw(){
	//Verifier si un document du meme nom exists
	xml.isset();


	for (int i = 0; i<10; i++){
		//Ajoute un noeud au Xml dont le nom est l'argument
		// Un deuxieme argument peut etre ajout\u00e9 pour specifier le contenu (String) du Node
		xml.addNode("enfant");
		//SetAttribute prend toujours en premier argument le nom de l'attribut
		// Et en second un int/float/String correspondant \u00e0 la valeur de lattribut
		xml.setAttribute("test",3.0f); // ici exemple avec un float
		xml.setAttribute("pene","test string");// ici exemple avec une string
		xml.setAttribute("drole",PApplet.parseInt(random(0,100))); // ici exemple avec un int
	}

	xml.addNode("testName");
		//SetAttribute prend toujours en premier argument le nom de l'attribut
		// Et en second un int/float/String correspondant \u00e0 la valeur de lattribut
		xml.setAttribute("test",3.0f); // ici exemple avec un float
		xml.setAttribute("pene","test string");// ici exemple avec une string
		xml.setAttribute("drole",PApplet.parseInt(random(0,100))); // ici exemple avec un int

	//Sauvegarder l'xml, l'argument specifie le nom de celui ci
	xml.saveXml("testProcessing");

	// Pour toutes les methodes de type getAttributeType... le premier argument peut etre le nom (String)
	// ou l'id (int) de la balise voulu
	// le second argument doit etre une string
	// ATTENTION il existe une methode pour chaque type de valeur souhait\u00e9 en retour
	String test = xml.getAttributeTypeStringInNode("testName","pene");
	int lol = xml.getAttributeTypeIntInNode("testName","drole");
	float pene = xml.getAttributeTypeFloatInNode("testName","test");
	
	println(test+" /"+lol+" /"+pene);
	noLoop();
}
public class genericXml{

	public String name;
	public File f;
  public XML xml, newNode, child;
  //CONSTRUCTOR
	public genericXml (String _name) {
		  name = _name;
    	f = new File(dataPath(name+".xml"));
      xml = createXML(name);
	}

  //Verifier que le dossier existe
	public Boolean isset(){
    if (!f.exists()) {
      println("le xml n'existe pas encore");
      return false;
    }
    else{
      println("le XML existe");
      return true;
    }
  }

  //Ajout d'un noeud
  public XML addNode(String _nameChild, String _contentChild){
    String nameChild = _nameChild;
    String contentChild = _contentChild;
    if(contentChild == ""){contentChild = "empty";}
    newNode = xml.addChild(nameChild);
    newNode.setContent(contentChild);
    return newNode;
  }

  public XML addNode(String _nameChild){
    String nameChild = _nameChild;
    String contentChild = "empty";
    newNode = xml.addChild(nameChild);
    newNode.setContent(contentChild);
    return newNode;
  }
  // __ Fin de l'ajout d'un noeud

  public void setAttribute(String _name,String _String) {
    String name = _name;
    String value = _String;
    newNode.setString(name,value);
  }

  public void setAttribute(String _name, int _int) {
    String name = _name;
    int value = _int;
    newNode.setInt(name,value);
  }

  public void setAttribute(String _name, float _float) {
    String name = _name;
    float value = _float;
    newNode.setFloat(name,value);
  }

  public void saveXml(String _nameXml) {
    String nameXml = _nameXml;
    saveXML(xml, "data/"+nameXml+".xml");
  }

  public XML getNodeById(int _id) {
    int id = _id;
    child = xml.getChild(id); 
    return child;
  }

   public XML getNodeByName(String _name) {
    String name = _name;
    child = xml.getChild(name); 
    return child;
  }

  //int
  public int getAttributeTypeIntInNode(String _nameNode, String _nameAttribute) {
      String nameAttribute= _nameAttribute;
      String nameNode = _nameNode;

      XML temp = getNodeByName(nameNode);
      if(temp.hasAttribute(nameAttribute)){
      return temp.getInt(nameAttribute);
      }else{
        return 0;
      }
  } 

  public int getAttributeTypeIntInNode(int _nameNode, String _nameAttribute) {
      String nameAttribute= _nameAttribute;
      int nameNode = _nameNode;

      XML temp = getNodeById(nameNode);
      if(temp.hasAttribute(nameAttribute)){
      return temp.getInt(nameAttribute);
      }else{
        return 0;
      }
  } 

  //float
  public float getAttributeTypeFloatInNode(String _nameNode, String _nameAttribute) {
      String nameAttribute= _nameAttribute;
      String nameNode = _nameNode;

      XML temp = getNodeByName(nameNode);
      if(temp.hasAttribute(nameAttribute)){
      return temp.getFloat(nameAttribute);
      }else{
        return 0.0f;
      }
  } 

  public float getAttributeTypeFloatInNode(int _nameNode, String _nameAttribute) {
      String nameAttribute= _nameAttribute;
      int nameNode = _nameNode;

      XML temp = getNodeById(nameNode);
      if(temp.hasAttribute(nameAttribute)){
      return temp.getFloat(nameAttribute);
      }else{
        return 0.0f;
      }
  } 
  //String
    public String getAttributeTypeStringInNode(int _nameNode, String _nameAttribute) {
      String nameAttribute= _nameAttribute;
      int nameNode = _nameNode;

      XML temp = getNodeById(nameNode);
      if(temp.hasAttribute(nameAttribute)){
      return temp.getString(nameAttribute);
      }else{
        return "no String";
      }
  } 

    public String getAttributeTypeStringInNode(String _nameNode, String _nameAttribute) {
      String nameAttribute= _nameAttribute;
      String nameNode = _nameNode;

      XML temp = getNodeByName(nameNode);
      if(temp.hasAttribute(nameAttribute)){
      return temp.getString(nameAttribute);
      }else{
        return "no String";
      }
  } 

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "ClassXml" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
