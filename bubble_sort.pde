PImage img;
int dup = 3;
int dup_width = 0;
int dup_width_up = 0;
int dup_up = 1;
int bright_up = 1;
int speed_factor = 1;
color dup_threshold_upper = color(255);
color dup_threshold_lower = color(12);
int x_dup = width -1;
int x_dup_right = 0;
String filename = "Sans.png";
void setup() {
  size(720,720);
  img = loadImage(filename);
  img.resize(width, height);
  
  
}


void draw() {
  loadPixels();
  image(img, 0, 0);
  if (dup == 0 && bright_up == 1) {
  for (int y = 0; y < height - 1; y++) {
    for (int x = 0; x < width - 1; x++) {
     //sort_pix_bright_left(x, y);
     sort_pix_bright_up(x, y);
     }
    }
  }
  
  if (dup == 0 && bright_up == 0) {
  for (int y = height - 1; y > 0; y--) {
    for (int x = width - 1; x > 0; x--) {
     //sort_pix_bright_right(x, y);
     sort_pix_bright_down(x, y);
     }
    }
  }

    if (dup == 1 && dup_up == 1) {
    for (int y = 0; y < (height - 1) * speed_factor; y++) {
    for (int x = 0; x < (width - 1) * speed_factor; x++) {
     if (y % speed_factor == 0 && x % speed_factor == 0)
     dup_pix_up(x/speed_factor,y/speed_factor);
     dup_pix_left(x/speed_factor,y/speed_factor);
     //dup_pix_down(x,y);
     }
    }
    //if ((int)random(100) == 0)
      //dup_up = 0;
    }
    if (dup == 1 && dup_up == 0) {
    for (int y = height - 1; y > 0; y--) {
    for (int x = width - 1; x > 0; x--) {
     dup_pix_down(x,y);
     dup_pix_right(x,y);
     }
    }
    //if ((int)random(100) == 0)
      //dup_up = 1;
    }
    if (dup_width == 1 && dup_width_up == 1) {
      for (int y = 0; y < height - 1; y++) {
        //dup_pix_right(width - x_dup - 1, height - y - 1);
       dup_pix_up_left(x_dup, y);
      }
     // if ((int)random(100) == 0)
       // dup_width_up = 0;
    }
     if (dup_width == 1 && dup_width_up == 0) {
      for (int y = 0; y < height - 1; y++) {
        //dup_pix_right(width - x_dup - 1, height - y - 1);
       dup_pix_up_right(x_dup_right, y);
      }
      //if ((int)random(100) == 0)
        //dup_width_up = 1;
    }
    if (x_dup_right == width -1)
      x_dup_right = 0;
    else
      x_dup_right++;
    if (x_dup == 0)
      x_dup = width - 1;
    else
      x_dup--;
    updatePixels();
    image(img, 0, 0);
}

void sort_pix_bright_left(int x, int y) {
  if (brightness(img.pixels[y * width + x]) >  brightness(img.pixels[y * width + x + 1])) {
       color c = img.pixels[y * width + x + 1];
       img.pixels[y * width + x + 1] = img.pixels[y * width + x];
       img.pixels[y * width + x] = c;
       img.updatePixels();
  }
}

void sort_pix_bright_up(int x, int y) {
  if (y >= 1 && brightness(img.pixels[y * width + x]) > 180 && brightness(img.pixels[y * width + x]) <  brightness(img.pixels[(y - 1) * width + x])) { 
       color c = img.pixels[(y - 1) * width + x];
       img.pixels[(y-1) * width + x] = img.pixels[y * width + x];
       img.pixels[y * width + x] = c;
       img.updatePixels();
  }
  else
    sort_pix_bright_left(x,y);
}

void sort_pix_bright_right(int x, int y) {
  if (x < width - 1 && brightness(img.pixels[y * width + x]) >  brightness(img.pixels[y * width + x - 1])) {
       color c = img.pixels[y * width + x - 1];
       img.pixels[y * width + x - 1] = img.pixels[y * width + x];
       img.pixels[y * width + x] = c;
       img.updatePixels();
  }
}

void sort_pix_bright_down(int x, int y) {
  if (y < height - 1  && brightness(img.pixels[y * width + x]) > 180 && brightness(img.pixels[y * width + x]) <  brightness(img.pixels[(y + 1) * width + x])) {
       color c = img.pixels[(y + 1) * width + x];
       img.pixels[(y+1) * width + x] = img.pixels[y * width + x];
       img.pixels[y * width + x] = c;
       img.updatePixels();
  }
   else
     sort_pix_bright_right(x,y);
}

void dup_pix_left(int x, int y) {
  if (brightness(img.pixels[y * width + x]) >  brightness(img.pixels[y * width + x + 1])) {
       color c = img.pixels[y * width + x + 1];
       if (img.pixels[(y) * width + x] > dup_threshold_lower && img.pixels[(y) * width + x] < dup_threshold_upper)
       img.pixels[y * width + x] = img.pixels[y * width + x + 1];
       //img.pixels[y * width + x] = c;
       img.updatePixels();
       //image(img, 0, 0);
}
}

void dup_pix_up(int x, int y) {
  if (y >= 1 &&  brightness(img.pixels[y * width + x]) > brightness(img.pixels[(y - 1) * width + x])) {
       color c = img.pixels[(y - 1) * width + x];
       if (img.pixels[(y) * width + x] > dup_threshold_lower && img.pixels[(y) * width + x] < dup_threshold_upper)
       img.pixels[(y-1) * width + x] = img.pixels[y * width + x];
       //img.pixels[y * width + x] = c;
       img.updatePixels();
       //image(img, 0, 0);
}
}

void dup_pix_up_left(int x, int y) {
  if (y >= 1 && x >=1 &&  brightness(img.pixels[y * width + x]) >  brightness(img.pixels[(y - 1) * width + x - 1])
      && brightness(img.pixels[y * width + x]) >  brightness(img.pixels[(y) * width + x - 1]))
  {
       img.pixels[(y-1) * width + x - 1] = img.pixels[y * width + x];
       img.updatePixels();
  }
}

void dup_pix_down_right(int x, int y) {
  if (y < height - 1 && x < width - 1 &&  brightness(img.pixels[y * width + x]) >  brightness(img.pixels[(y + 1) * width + x + 1])
      && brightness(img.pixels[y * width + x]) >  brightness(img.pixels[(y) * width + x + 1]))
  {
       img.pixels[(y+1) * width + x + 1] = img.pixels[y * width + x];
       img.updatePixels();
  }
}

void dup_pix_up_right(int x, int y) {
  if (y >= 1 && x < width - 1 &&  brightness(img.pixels[y * width + x]) >  brightness(img.pixels[(y - 1) * width + x + 1])
      && brightness(img.pixels[y * width + x]) >  brightness(img.pixels[(y) * width + x + 1]))
  {
       img.pixels[(y-1) * width + x + 1] = img.pixels[y * width + x];
       img.updatePixels();
  }
}

void dup_pix_down(int x, int y) {
  if (y <= height - 2 &&  brightness(img.pixels[y * width + x]) > brightness(img.pixels[(y + 1) * width + x])) {
       color c = img.pixels[(y + 1) * width + x];
       if (img.pixels[(y) * width + x] > dup_threshold_lower && img.pixels[(y) * width + x] < dup_threshold_upper)
       img.pixels[(y+1) * width + x] = img.pixels[y * width + x];
       //img.pixels[y * width + x] = c;
       img.updatePixels();
       //image(img, 0, 0);
}
}

void dup_pix_right(int x, int y) {
  if (x < width -1 && brightness(img.pixels[y * width + x]) >  brightness(img.pixels[y * width + x - 1])) {
       color c = img.pixels[y * width + x - 1];
       if (img.pixels[(y) * width + x] > dup_threshold_lower && img.pixels[(y) * width + x] < dup_threshold_upper)
       img.pixels[y * width + x] = img.pixels[y * width + x - 1];
       //img.pixels[y * width + x] = c;
       img.updatePixels();
       //image(img, 0, 0);
}
}

void mousePressed() {
  img = loadImage(filename);
  img.resize(width, height);
  dup = 3;
}

void keyPressed() {
 if (keyCode == DOWN)
   dup_up = 0;
 if (keyCode == UP)
   dup_up = 1;
 if (keyCode == LEFT)
   dup_width_up = 1;
 if (keyCode == RIGHT)
   dup_width_up = 0;
 if (key == 'z') {
   if (bright_up == 0)
     bright_up = 1;
   else
     bright_up = 0;
 }
 if (key == 'b') {
   if (dup == 0)
   dup = 3;
   else
   dup = 0;
 }
 if (key == 'd') {
   if (dup == 1)
   dup = 3;
   else
   dup = 1;
}

 if (key == 's') {
   if (dup_width == 0)
   dup_width = 1;
     else
   dup_width = 0;
 }
}
