import java.lang.reflect.*;

ArrayList<Class>foundClasses;

void setup() {
  foundClasses = scanClasses(this, "SuperClass");
  SuperClass b = createInstance(1);
  SuperClass c = createInstance("ClassC");
}

ArrayList<Class> scanClasses(PApplet parent, String superClassName) {
  ArrayList<Class> foundClasses = new ArrayList<Class>();  
  println("------------------------------------------------------");
  println("Searching for classes which extend " + superClassName + ":");  

  String infoText = "";
  Class[] c = parent.getClass().getDeclaredClasses();
  for (int i=0; i<c.length; i++) {
    if (c[i].getSuperclass() != null && (c[i].getSuperclass().getSimpleName().equals(superClassName) )) {
      foundClasses.add(c[i]);
      int n = foundClasses.size()-1;
      String numb = str(n);
      if (n < 10) numb = " " + n;
      infoText += numb + "     " + c[i].getSimpleName() + "\n";
    }
  }
  println(infoText);
  return foundClasses;
}

public SuperClass createInstance(int i) {
  if (i < 0 || i >= foundClasses.size()) return null;
  
  SuperClass f = null;
  try {
    Class c = foundClasses.get(i);
    Constructor[] constructors = c.getConstructors();
    f = (SuperClass) constructors[0].newInstance(this); // <-- "this" is the main PApplet instance
  } 
  catch (InvocationTargetException e) {
    System.out.println(e);
  } 
  catch (InstantiationException e) {
    System.out.println(e);
  } 
  catch (IllegalAccessException e) {
    System.out.println(e);
  } 

  if (f != null) {
    // Do something with the Class, for example add it to an ArrayList
  }
  return f;
}

public SuperClass createInstance(String className) {
  int index = -1;
  for (int i=0; i<foundClasses.size(); i++) {    
    if (foundClasses.get(i).getSimpleName().equals(className)) {
      index = i;
      break;
    }
  }
  if (index >= 0) return createInstance(index);
  return null;
}
