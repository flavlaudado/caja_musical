/*
esta clase es para detectar los pixeles q cambian de color y triggear  
 */
class Pixel {
  //variables
  float x = 0;
  float y = 480;
  color c;
  float r, g, b, rgb = 0;
  float ra, ga, ba = 0;
  float r1, g1, b1 = 0;
  float rt, gt, bt = 0;
  boolean presencia = false;
  boolean flag = false;
  int umbral = 10;
  int timer = 40;
  int contador = timer;

  Pixel() {
  }

  void setearColor(float _x, float _y) {//seteo valor inicial del pixel
    x = _x;
    y = _y;  
    //video.read();
    image(img, 0, 0, width, height);
    c = img.get(int(x), int(y));
    //c = video.get(int(x), int(y));
    r = red(c);
    g = green(c);
    b = blue(c);
    /*
    println("seteando color, x:" + x + ", y: " + y); 
    text("r: " + r, 10, 305);
    text("g: " + g, 10, 330);
    text("b: " + b, 10, 355);*/
  }

  void detectarPixel() {//veo el estado actual del pixel
    actualizoPixel();     
    video.read();
    c = video.get(int(x), int(y));
    r1 = red(c);
    g1 = green(c);
    b1 = blue(c);
    rgb = (r + g + b) / 3;
    /*
    fill(255);
    text("r1: " + r1, 70, 305);
    text("g1: " + g1, 70, 320);
    text("b1: " + b1, 70, 335);
    //text("rgb: " + rgb, 20, 460);*/
  }

  void actualizoPixel() {
    ra = r1;
    ga = g1;
    ba = b1;
  }

  void cambiaColor() { //detecta si cambió de color
    rt = abs(r1 - ra);
    gt = abs(g1 - ga);
    bt = abs(b1 - ba);
    float diferencia = (rt + gt + bt) / 3;
    contador++;
    //if ( diferencia > umbral ){
    if ( diferencia > umbral && contador > timer) {  
      presencia = true;
      contador = 0;
    } else {
      presencia = false;
    }
    /*
    fill(255, 0, 0);
    text(diferencia, 150, 305);
    noStroke();
    fill(r, g, b);
    rect(150, 330, 20, 20);*/
  }
}