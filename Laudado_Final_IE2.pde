/*
 Flavia Laudado - Final Imagen Electrónica II
 Aplicación con inspiración en caja de música, de Jorge Macchi.
 Siguiendo el juego de una tarde de otoño.
 El movimiento en un video es sensado para generar una sonorización.
 Una partitura no convencional. Utilizando el video como partitura.
 */

import processing.video.*;
import processing.sound.*;

SoundFile[] file;
int nAudios = 8;
Movie video;
PImage img;
boolean presencia = false;
boolean flag = true;
boolean comenzar = false;

ArrayList <Pixel> pixeles;
int nPuntos = 8;
float x1 = 10;
float x2 = 630;
float x3 = 650;
float x4 = 1270;
float y1 = 165;
float y2 = 520;
float[] pixelX = {x1, x2, x3, x4, x1, x2, x3, x4};
float[] pixelY = {y1, y1, y1, y1, y2, y2, y2, y2};

void setup() {
  frameRate(25);
  //size(1280, 720);
  fullScreen();
  noCursor();
  video = new Movie(this, "../../videos/4.mp4");
  video.loop();
  img = loadImage("../../videos/4.png");
  //sonido = new SoundFile(this, "../../audios_marimba/FLAVIA_MARIMBA.wav");
  file = new SoundFile[nAudios];
  for (int i = 0; i < nAudios; i++) {
    file[i] = new SoundFile(this, "../../audios_marimba/" + (i+1) + ".wav");
  }

  pixeles = new ArrayList<Pixel>();
  for (int i = 0; i < nAudios; i++) {
    Pixel crearPixel = new Pixel(); 
    //crearPixel.setearColor(pixelY[i], pixelY[i]);
    pixeles.add(crearPixel);
  }
}

void draw() {
  background(0);
  //image(video, 0, 0, 1280, 720);
  image(video, 0, 0, width, height);
  posicionMouse();
  for (int i = 0; i< nAudios; i++) {//chequeo si hubo cambios
    Pixel pixelActual = pixeles.get(i);
    pixelActual.detectarPixel();
    pixelActual.cambiaColor();
    if (comenzar) {
      if (pixelActual.presencia && pixelActual.flag) {
        file[i].play();
        pixelActual.flag = false;
      }
    }
    if (pixelActual.presencia == false && pixelActual.flag == false) {
      pixelActual.flag = true;
    }
  }
  // text("frame: " + video.time(), 30, 400);
}

void posicionMouse() {
  int x = mouseX;
  int y = mouseY;
  fill(255);
  text(x + "," + y, x + 20, y);
}

void movieEvent(Movie m) {
  m.read();
}

void mousePressed() {
  video.pause();
}

void mouseReleased() {
  video.play();
}

void keyPressed() {
  if (key==' ') {
    //setearColor();
    for (int i = 0; i < nAudios; i++) {
      Pixel newPixel = pixeles.get(i);     
      newPixel.setearColor(pixelX[i], pixelY[i]);
      // newPixel.flag = false;
    }
  }
  if (key=='1') {
    comenzar = true;
  }
  if (key=='2') {
    video.jump(random(video.duration()));
  }
  if (key=='3') {  
    video.speed(1.0);
  }
  if (key=='4') {  
    video.speed(2.0);
  }
  if (key=='5') {  
    video.speed(4.0);
  }
  if (key=='6') {  
    video.speed(8.0);
  }
}