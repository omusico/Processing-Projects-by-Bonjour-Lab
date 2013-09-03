import java.util.*;

ArrayList <String> names;
names = new ArrayList();

names.add("Sofia");   // 0
names.add("Marco");   // 1
names.add("Fritz");   // 2
names.add("Rebecca"); // 3
names.add("Robert");  // 4

/*
println( "Hello my name is " + names.get(0) + ".");
 println( "Hello my name is " + names.get(1) + ".");
 println( "Hello my name is " + names.get(2) + ".");
 println( "Hello my name is " + names.get(3) + ".");
 println( "Hello my name is " + names.get(4) + ".");
 */

/*
for (int i=0; i<names.size(); i++){
 println( "Hello my name is " + names.get(i) + ".");
 }
 */

/*
for(String s : names){
 println( "Hello my name is " + s + ".");
 } 
 */

Iterator<String> i = names.iterator();
while (i.hasNext ()) {
  String name = i.next();
  if (name.equals("Fritz")) i.remove();  
  println("Hello my name is " + name + ".");
}

println("--------------------------------------");

for (String s : names) {
  println( "Hello my name is " + s + ".");
} 

