/*
 * ----------------------------------------------------------------------------
 * "THE BEER-WARE LICENSE" (Revision 42):
 * <contact@tutoprocessing.com> wrote this file. As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return Poul-Henning Kamp
 * ----------------------------------------------------------------------------
 */

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

Twitter twitter;
String filtreListener;
Configuration c;


void setup(){
    size(800,600);
    twitterConfiguration();
    setupListener(c);
}

void draw(){
    noLoop();
}

void twitterConfiguration(){
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey("34sJKGiU71xaVBVeutDA");
    cb.setOAuthConsumerSecret("sMGrXuf2zbhS29cEV9HYHDeNoU45aoGWcw1t2JbJMMk");
    cb.setOAuthAccessToken("1272243708-woC2NKzPErcj9CAsUGURNOmS9OL4ISdFI9hyQmh");
    cb.setOAuthAccessTokenSecret("D846JFR6nH9v13icgBcLfyNCUVWg53R9jhWwjmwuBU");
    
    c = cb.build();
    TwitterFactory tf = new TwitterFactory(c);
    twitter = tf.getInstance();
}

void setupListener(Configuration c){
    filtreListener = "love";
    TwitterStream ts = new TwitterStreamFactory(c).getInstance();
    FilterQuery filterQuery = new FilterQuery(); 
    filterQuery.track(new String[] {filtreListener});
     // On fait le lien entre le TwitterStream (qui récupère les messages) et notre écouteur  
    ts.addListener(new TwitterListener());
     // On démarre la recherche !
    ts.filter(filterQuery);
}


// ------------------------------------------------------------
// class TwitterListener
//
// Classe qui permet "d'écouter" les messages entrants
// récupérés par notre instance TwitterStream
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

  // onScrubGeo : récupération d'infos géographiques
  public void onScrubGeo(long userId, long upToStatusId) 
  {
    System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
  }

  public void onStallWarning(StallWarning warning){

  }
  // onException : une erreur est survenue (déconnexion d'internet, etc...)
  public void onException(Exception ex) 
  {
    ex.printStackTrace();
  }
}
