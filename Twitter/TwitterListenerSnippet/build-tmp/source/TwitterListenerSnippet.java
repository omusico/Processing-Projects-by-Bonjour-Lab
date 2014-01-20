import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import twitter4j.conf.*; 
import twitter4j.internal.async.*; 
import twitter4j.internal.org.json.*; 
import twitter4j.internal.logging.*; 
import twitter4j.json.*; 
import twitter4j.internal.util.*; 
import twitter4j.management.*; 
import twitter4j.auth.*; 
import twitter4j.api.*; 
import twitter4j.util.*; 
import twitter4j.internal.http.*; 
import twitter4j.*; 
import twitter4j.internal.json.*; 
import java.util.*; 

import twitter4j.examples.block.*; 
import twitter4j.examples.trends.*; 
import twitter4j.conf.*; 
import twitter4j.json.*; 
import twitter4j.internal.async.*; 
import twitter4j.internal.logging.*; 
import twitter4j.api.*; 
import twitter4j.internal.json.*; 
import twitter4j.examples.friendsandfollowers.*; 
import twitter4j.*; 
import twitter4j.examples.directmessage.*; 
import twitter4j.media.*; 
import twitter4j.examples.list.*; 
import twitter4j.examples.stream.*; 
import twitter4j.examples.search.*; 
import twitter4j.examples.friendship.*; 
import twitter4j.examples.timeline.*; 
import twitter4j.util.*; 
import twitter4j.examples.tweets.*; 
import twitter4j.examples.user.*; 
import twitter4j.examples.async.*; 
import twitter4j.examples.help.*; 
import twitter4j.examples.media.*; 
import twitter4j.auth.*; 
import twitter4j.internal.util.*; 
import twitter4j.examples.account.*; 
import twitter4j.examples.geo.*; 
import twitter4j.internal.http.*; 
import twitter4j.examples.suggestedusers.*; 
import twitter4j.examples.spamreporting.*; 
import twitter4j.examples.oauth.*; 
import twitter4j.examples.favorite.*; 
import twitter4j.examples.json.*; 
import twitter4j.management.*; 
import twitter4j.examples.savedsearches.*; 
import twitter4j.internal.org.json.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TwitterListenerSnippet extends PApplet {

/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <contact@tutoprocessing.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Poul-Henning Kamp
 * ----------------------------------------------------------------------------
 */
















Twitter twitter;
String filtreListener;
Configuration c;


public void setup(){
    size(800,600);
    twitterConfiguration();
    setupListener(c);
}

public void draw(){
    noLoop();
}

public void twitterConfiguration(){
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("34sJKGiU71xaVBVeutDA");
    cb.setOAuthConsumerSecret("sMGrXuf2zbhS29cEV9HYHDeNoU45aoGWcw1t2JbJMMk");
    cb.setOAuthAccessToken("1272243708-woC2NKzPErcj9CAsUGURNOmS9OL4ISdFI9hyQmh");
    cb.setOAuthAccessTokenSecret("D846JFR6nH9v13icgBcLfyNCUVWg53R9jhWwjmwuBU");
    
    c = cb.build();
    TwitterFactory tf = new TwitterFactory(c);
    twitter = tf.getInstance();

}

public void setupListener(Configuration c){
    filtreListener = "love";
    TwitterStream ts = new TwitterStreamFactory(c).getInstance();
    FilterQuery filterQuery = new FilterQuery(); 
    filterQuery.track(new String[] {filtreListener});
     // On fait le lien entre le TwitterStream (qui r\u00e9cup\u00e8re les messages) et notre \u00e9couteur  
    ts.addListener(new TwitterListener());
     // On d\u00e9marre la recherche !
    ts.filter(filterQuery);
}


// ------------------------------------------------------------
// class TwitterListener
//
// Classe qui permet "d'\u00e9couter" les messages entrants
// r\u00e9cup\u00e9r\u00e9s par notre instance TwitterStream
// ------------------------------------------------------------
class TwitterListener implements StatusListener
{
  // onStatus : nouveau message qui vient d'arriver 
  int count = 0;
  public void onStatus(Status status) 
  {
    println("numer : "+count+" / "+status.getUser().getName() + " : " + status.getText());
    count++;
   // twitter_statuses.add(status);
  }  

  // onDeletionNotice
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) 
  {
  }

  // onTrackLimitationNotice
  public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
  }  

  // onScrubGeo : r\u00e9cup\u00e9ration d'infos g\u00e9ographiques
  public void onScrubGeo(long userId, long upToStatusId) 
  {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  public void onStallWarning(StallWarning warning){

  }
  // onException : une erreur est survenue (d\u00e9connexion d'internet, etc...)
  public void onException(Exception ex) 
  {
    ex.printStackTrace();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TwitterListenerSnippet" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
