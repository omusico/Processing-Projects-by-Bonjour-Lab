genericXml xml; 

void setup(){
	//genericXml va creer la balise principale, l'argument lui donne son nom
	xml = new genericXml("testProcessing");
}

void draw(){
	//Verifier si un document du meme nom exists
	xml.isset();


	for (int i = 0; i<10; i++){
		//Ajoute un noeud au Xml dont le nom est l'argument
		// Un deuxieme argument peut etre ajouté pour specifier le contenu (String) du Node
		xml.addNode("enfant");
		//SetAttribute prend toujours en premier argument le nom de l'attribut
		// Et en second un int/float/String correspondant à la valeur de lattribut
		xml.setAttribute("test",3.0); // ici exemple avec un float
		xml.setAttribute("pene","test string");// ici exemple avec une string
		xml.setAttribute("drole",int(random(0,100))); // ici exemple avec un int
	}

	xml.addNode("testName");
		//SetAttribute prend toujours en premier argument le nom de l'attribut
		// Et en second un int/float/String correspondant à la valeur de lattribut
		xml.setAttribute("test",3.0); // ici exemple avec un float
		xml.setAttribute("pene","test string");// ici exemple avec une string
		xml.setAttribute("drole",int(random(0,100))); // ici exemple avec un int

	//Sauvegarder l'xml, l'argument specifie le nom de celui ci
	xml.saveXml("testProcessing");

	// Pour toutes les methodes de type getAttributeType... le premier argument peut etre le nom (String)
	// ou l'id (int) de la balise voulu
	// le second argument doit etre une string
	// ATTENTION il existe une methode pour chaque type de valeur souhaité en retour
	String test = xml.getAttributeTypeStringInNode("testName","pene");
	int lol = xml.getAttributeTypeIntInNode("testName","drole");
	float pene = xml.getAttributeTypeFloatInNode("testName","test");
	
	println(test+" /"+lol+" /"+pene);
	noLoop();
}
