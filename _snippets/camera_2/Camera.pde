class Camera {
  PVector eye, center, up;
  PVector deye, dcenter;
  float damp;

  Camera(PVector eye, PVector center, PVector up) {
    this.eye = eye;
    this.center = center;
    this.up = up;

    deye = eye.get();
    dcenter = center.get();
    damp = 0.1;
  }

  Camera(PVector eye, PVector center) {
    this(eye, center, new PVector(0, 1, 0));
  }

  void apply() {
    // eyeX, eyeY, eyeZ, 
    // centerX, centerY, centerZ, 
    // upX, upY, upZ
    camera(eye.x, eye.y, eye.z, center.x, center.y, center.z, up.x, up.y, up.z);
  }

  void setEye(PVector e) {
    deye = e.get();
  }

  void setEye(float x, float y, float z) {
    deye.set(x, y, z);
  }

  void setCenter(PVector c) {
    dcenter = c.get();
  }

  void setCenter(float x, float y, float z) {
    dcenter.set(x, y, z);
  }

  void interpolate() {
    eye.x += (deye.x - eye.x) * damp;
    eye.y += (deye.y - eye.y) * damp;
    eye.z += (deye.z - eye.z) * damp;
    center.x += (dcenter.x - center.x) * damp;
    center.y += (dcenter.y - center.y) * damp;
    center.z += (dcenter.z - center.z) * damp;
  }
}

