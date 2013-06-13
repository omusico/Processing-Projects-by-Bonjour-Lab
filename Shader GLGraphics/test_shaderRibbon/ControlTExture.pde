class PFrame extends Frame {
    public PFrame() {
        setBounds(100,100,400,300);
        s = new secondApplet();
        add(s);
        s.init();
        show();
    }
}
class secondApplet extends PApplet {
    public void setup() 
    {
        size(400, 800);
        
    }
    public void draw() 
    {
      background(0);
      imageDisplay();
      fill(255);
      text("frame rate : "+frameRate, 20, 20);
    }
    
    void imageDisplay()
    {
       float s = 0.25;
      image(offscreenDisp.getTexture(), 0, 0, s*width, s*height);
      image(offscreenRibbon.getTexture(), 0, 250, s*width, s*height);
    }
}

