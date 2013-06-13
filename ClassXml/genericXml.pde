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
        return 0.0;
      }
  } 

  public float getAttributeTypeFloatInNode(int _nameNode, String _nameAttribute) {
      String nameAttribute= _nameAttribute;
      int nameNode = _nameNode;

      XML temp = getNodeById(nameNode);
      if(temp.hasAttribute(nameAttribute)){
      return temp.getFloat(nameAttribute);
      }else{
        return 0.0;
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