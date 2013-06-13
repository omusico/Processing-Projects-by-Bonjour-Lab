class Ground
{
  //variable
  float y, vy, number;

  //constructeur
  Ground(float y_, int number_, float vy_)
  {
    number = number_;
    y = y_+(number*20);
    vy = vy_;
  }
  //methode
  void offScrennSolMove(GLGraphicsOffScreen g)
  {
    y += vy;
    checkEdge();
    // println(y);
    g.stroke(255, 0, 0);
    g.beginShape(QUADS);
    g.textureMode(NORMALIZED);
    g.texture(tex);
    g.vertex(0, 0+y, 0, 0, 0);
    g.vertex(width, 0+y, 0, 1, 0);
    g.vertex(width, height+y, 0, 1, 1);
    g.vertex(0, height+y, 0, 0, 1);
    g.endShape();
    //debug
    /*
    g.fill(255);
    g.textSize(20);
    g.text(number, width/2, y);
    */
  }

  void checkEdge()
  {
    if (y >=height)
    {
      y = -height;
    }
  }
}

