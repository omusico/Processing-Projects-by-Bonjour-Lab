// Class timer initialement developpée par Daniel Shiffman (Learning Processing)
// Modifié par Gustave Bernier (Bonjour, interactive Lab)
// http://www.learningprocessing.com
// http://www.bonjour-lab.com

class Timer {

  int savedTime; // Quand le timer Démarre
  int totalTime; // Temps du timer
  int remainingTime;
  boolean timerStarted, timerStopped;

  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
    timerStarted = false;
    timerStopped = true;
  }

  void start() {
    if (!timerStarted) {
      savedTime = millis();
      timerStarted = true;
      timerStopped = false;
    }
  }

  void stop() {
    timerStopped = true;
  }

  boolean isFinished() { 
    int passedTime = millis()- savedTime;
    remainingTime = totalTime-passedTime;
    if (passedTime > totalTime || timerStopped) {
      timerStarted = false;
      timerStopped = true;
      return true;
    } 
    else {
      return false;
    }
  }
  
  int getRemainingTime() {
    return remainingTime;
  }

  void reset(int tempTotalTime) {
    totalTime = tempTotalTime;
  }  
}

