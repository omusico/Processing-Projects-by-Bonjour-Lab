class textureRibbon
{
  //variables

  //constructeur
  textureRibbon()
  {
    
  }

  //methodes
  void offScrennSolMove(GLGraphicsOffScreen g)
  {
    g.beginShape(QUADS);
    g.fill(255);
    g.texture(tex2);
    g.vertex(0, 0, 0, 0, 0);
    g.vertex(width, 0, 0, 1, 0);
    g.vertex(width, height, 0, 1, 1);
    g.vertex(0, height, 0, 0, 1);
    g.endShape();
  }
}

