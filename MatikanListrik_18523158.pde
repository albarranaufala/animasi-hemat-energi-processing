// Nama: Albarra Naufala Erdanto
// NIM: 18523158
// Topik: Hemat Energi
// Tema: Matikan Listrik Jika Tidak Digunakan

import processing.sound.*;
SoundFile desaSFX;
SoundFile lalatSFX;
SoundFile jamSFX;
SoundFile rekaman;
SoundFile musik;
PFont montserratBold;
float kecepatanRotasi = 12;
float scale = 1;
float volMusic = 0.5;
float fade = 0;

void setup(){
  size(1280,720);
  background(255);
  frameRate(48);
  strokeWeight(5);
  montserratBold = createFont("/Font/Montserrat/Montserrat-Bold.ttf",42);
  textFont(montserratBold);
  desaSFX = new SoundFile(this, "/Audio/desaSFX.mp3");
  lalatSFX = new SoundFile(this, "/Audio/lalatSFX.mp3");
  jamSFX = new SoundFile(this, "/Audio/jamSFX.mp3");
  rekaman = new SoundFile(this, "/Audio/rekaman.mp3");
  musik = new SoundFile(this, "/Audio/musik1.mp3");
  desaSFX.play();
  desaSFX.amp(0.2);
  lalatSFX.play();
  jamSFX.play();
  jamSFX.amp(0.2);
  rekaman.play();
}

void draw(){
  //music handler
  if(frameCount == 1500){
    musik.play();
    musik.amp(volMusic);
  }
  
  //scene handler
  if(frameCount < 480){
    scene2();
  } else if(frameCount < 960){
    scene1();
  } else if(frameCount < 1380){
    scene2();
  } else if(frameCount < 1740){
    scene1();
  } else if(frameCount < 2000){
    jamSFX.stop();
    desaSFX.stop();
    scene3();
  } else if(frameCount < 2244){
    scene4();
  } else if(frameCount < 2500){
    scene5();
  } else{
    scene5();
    volMusic = volMusic >= 0 ? volMusic - 0.005 : 0;
    musik.amp(volMusic);
    //gelap
    fade = fade <= 255 ? fade + 5 : 255;
    pushMatrix();
      noStroke();
      fill(0,0,0,fade);
      rect(0,0,1280,720);
      stroke(0);
    popMatrix();
  }
}

void scene1(){
  float rotasiKipas;
  rotasiKipas = (frameCount%360)*kecepatanRotasi;
  background(242, 236, 121);
  
  if(frameCount >= 1500){
    translate(width/2,height/2);
    scale(scale);
    translate(-width/2, -height/2);
    scale += 0.0005;
  }
  
  //jam dinding
  fill(255);
  circle(25,25,250);
  pushMatrix();
    translate(25,25);
    rotate(radians(20 + frameCount/48 * 4));
    line(0,0,100,0);
  popMatrix();
  pushMatrix();
    translate(25,25);
    rotate(radians(100));
    line(0,0,50,0);
  popMatrix();
  
  //saklar
  noFill();
  beginShape();
    vertex(width/2 + 220, 0);
    vertex(width/2 + 220, 15);
  endShape();
  fill(166, 81, 75);
  beginShape();
    vertex(width/2 + 180, 500 - 485);
    vertex(width/2 + 260, 500 - 485);
    vertex(width/2 + 260, 600 - 485);
    vertex(width/2 + 180, 600 - 485);
  endShape(CLOSE);
  fill(143, 255, 160);
  beginShape();
    vertex(width/2 + 205, 530 - 485);
    vertex(width/2 + 220, 515 - 485);
    vertex(width/2 + 235, 530 - 485);
    vertex(width/2 + 235, 570 - 485);
    vertex(width/2 + 220, 585 - 485);
    vertex(width/2 + 205, 570 - 485);
  endShape(CLOSE);
  fill(73, 173, 88);
  int ySaklar = 530;
  if(frameCount >= 1280){
    ySaklar = 530 + frameCount - 1280;
    if(ySaklar >= 570){
      ySaklar = 570;
    }
  }
  circle(width/2 + 220, ySaklar - 485, 30);
  
  //meja
  fill(163, 97, 62);
  beginShape();
    vertex(width/2 - 400, height/2+150);
    vertex(width/2 + 400, height/2+150);
    vertex(width/2 + 700, height);
    vertex(width/2 - 700, height);
  endShape(CLOSE);
  
  //batang kipas
  fill(43, 43, 64);
  rect(width/2 - 25, height/2-50, 50, 200);
  
  //kaki kipas bagian atas
  beginShape();
    vertex(width/2 - 25, height/2+150);
    vertex(width/2 + 25, height/2+150);
    vertex(width/2 + 150, height/2+175);
    vertex(width/2 - 150, height/2+175);
  endShape(CLOSE);
  
  //kaki kipas bagian bawah
  beginShape();
    vertex(width/2 + 150, height/2+175);
    vertex(width/2 + 125, height/2+225);
    vertex(width/2 - 125, height/2+225);
    vertex(width/2 - 150, height/2+175);
  endShape(CLOSE);
  
  //saklar kipas
  fill(143, 255, 160);
  beginShape();
    vertex(width/2 - 30, height/2+185);
    vertex(width/2 + 30, height/2+185);
    vertex(width/2 + 35, height/2+200);
    vertex(width/2 + 30, height/2+215);
    vertex(width/2 - 30, height/2+215);
    vertex(width/2 - 35, height/2+200);
  endShape(CLOSE);
  fill(73, 173, 88);
  float xKipas = width/2 - 20;
  if(frameCount >= 1400){
    xKipas =  width/2 - 20 + frameCount - 1400;
    if(xKipas >= width/2 + 20){
      xKipas =  width/2 + 20;
      if(frameCount % 10 == 0){
        kecepatanRotasi = kecepatanRotasi * 0.5;
      }
      rotasiKipas = (frameCount%360)*kecepatanRotasi;
    }
  }
  circle(xKipas, height/2+200, 30);
  
  pushMatrix();
    float x = 0;
    float y = 0;
    
    //ke tengah
    translate(width/2, height/2-50);
    
    //mutar
    rotate(radians(rotasiKipas));
    
    //baling 1
    fill(135, 161, 124);
    beginShape();
      vertex(x+200,y);
      vertex(x+200,y+100);
      vertex(x,y);
    endShape(CLOSE);
    
    //baling 2
    beginShape();
      vertex(x,y+200);
      vertex(x-100,y+200);
      vertex(x,y);
    endShape(CLOSE);
    
    //baling 3
    beginShape();
      vertex(x-200,y);
      vertex(x-200,y-100);
      vertex(x,y);
    endShape(CLOSE);
    
    //baling 4
    beginShape();
      vertex(x,y-200);
      vertex(x+100,y-200);
      vertex(x,y);
    endShape(CLOSE);
    
    //pusat kipas
    fill(151, 184, 151);
    circle(x, y, 100);
  popMatrix();
  
  //gelap
  float gelap = 0;
  if(frameCount >= 1320){
    gelap = 100;
  }
  pushMatrix();
    noStroke();
    fill(0,0,0,gelap);
    rect(0,0,1280,720);
    stroke(0);
  popMatrix();
  
}

void scene2(){
  float gelap = 0;
  background(242, 236, 121);
  
  //saklar
  fill(166, 81, 75);
  beginShape();
    vertex(width/2 + 180, 500);
    vertex(width/2 + 260, 500);
    vertex(width/2 + 260, 600);
    vertex(width/2 + 180, 600);
  endShape(CLOSE);
  fill(143, 255, 160);
  beginShape();
    vertex(width/2 + 205, 530);
    vertex(width/2 + 220, 515);
    vertex(width/2 + 235, 530);
    vertex(width/2 + 235, 570);
    vertex(width/2 + 220, 585);
    vertex(width/2 + 205, 570);
  endShape(CLOSE);
  fill(73, 173, 88);
  int ySaklar = 530;
  if(frameCount >= 1280){
    ySaklar = 530 + frameCount - 1280;
    if(ySaklar >= 570){
      ySaklar = 570;
      gelap = 100;
    }
  }
  circle(width/2 + 220, ySaklar, 30);
  
  //atap
  fill(214, 209, 120);
  beginShape();
    vertex(-25, -25);
    vertex(width+25, -25);
    vertex(width+25, 300);
    vertex(-25, 300);
  endShape(CLOSE);
  
  //kabel
  noFill();
  beginShape();
    vertex(width/2, 170);
    vertex(width/2 + 300, 170);
    vertex(width/2 + 220, 300);
    vertex(width/2 + 220, 500);
  endShape();
  
  //jam dinding
  fill(255);
  circle(25,500,250);
  pushMatrix();
    translate(25,500);
    rotate(radians(20 + frameCount/48 * 4));
    line(0,0,100,0);
  popMatrix();
  pushMatrix();
    translate(25,500);
    rotate(radians(100));
    line(0,0,50,0);
  popMatrix();
  
  //tempat lampu
  fill(153, 118, 66);
  beginShape();
    vertex(width/2 - 60, 150);
    vertex(width/2 + 60, 150);
    vertex(width/2 + 60, 165);
    vertex(width/2 - 60, 165);
  endShape(CLOSE);
  beginShape();
    vertex(width/2 - 60, 165);
    vertex(width/2 + 60, 165);
    vertex(width/2 + 50, 200);
    vertex(width/2 - 50, 200);
  endShape(CLOSE);
  
  //lampu
  fill(255);
  beginShape();
    vertex(width/2 - 40, 180);
    bezierVertex(width/2 - 40, 170, width/2 + 40, 170, width/2 + 40, 180);
    vertex(width/2 + 40, 220);
    bezierVertex(width/2 + 80, 300, width/2 - 80, 300, width/2 - 40, 220);
    vertex(width/2 - 40, 220);
  endShape(CLOSE);
  
  //lalat
  pushMatrix();
    fill(84, 45, 42);
    noStroke();
    if(frameCount >= 240){
      if(frameCount == 240){
        lalatSFX.play();
      }
      translate((frameCount - 155) * 8, 180);
    } else {
      translate(frameCount < 85 ? frameCount * 8 : 85 * 8, 180);
    }
    circle(0,0,10);
  popMatrix();
  stroke(0);
  
  //gelap
  pushMatrix();
    noStroke();
    fill(0,0,0,gelap);
    rect(0,0,1280,720);
    stroke(0);
  popMatrix();
}

float xPohon[] = {-20,60,140,220,300,380,460,540,620,700,780,860,940,1020,1100,1180,1260};
float xGaris[] = {-150, 50, 250, 450, 650, 850, 1050, 1250};
void scene3(){
  background(171, 204, 255);
  
  //matahari
  fill(255,255,0);
  stroke(217, 217, 54);
  circle(width - 100, 80, 100);
  stroke(0);

  //pohon
  for(int i = 0; i < 17; i++){
    pohon(xPohon[i]);
    xPohon[i] = xPohon[i] >= width + 20 ? -20 : xPohon[i] + 5;
  }
  
  //daratan
  fill(121, 237, 119);
  beginShape();
    vertex(-20,300);
    vertex(width+20, 300);
    vertex(width+20, height+20);
    vertex(-20, height+20);
  endShape(CLOSE);
  
  //jalan
  fill(64);
  beginShape();
    vertex(-20,400);
    vertex(width+20, 400);
    vertex(width+20, 650);
    vertex(-20, 650);
  endShape(CLOSE);
  
  //garis
  for(int i = 0; i < 8; i++){
    garisPutih(xGaris[i]);
    xGaris[i] = xGaris[i] >= width + 150 ? -150 : xGaris[i] + 10;
  }
  
  //mobil
  fill(255, 255, 3);
  beginShape();
    vertex(width/2 - 200, 300);
    vertex(width/2 + 200, 300);
    vertex(width/2 + 250, 390);
    vertex(width/2 + 350, 400);
    vertex(width/2 + 350, 525);
    vertex(width/2 - 350, 525);
    vertex(width/2 - 350, 400);
    vertex(width/2 - 250, 390);
    vertex(width/2 - 200, 300);
  endShape(CLOSE);

  //kaca mobil
  fill(255);
  beginShape();
    vertex(width/2 - 220, 390);
    vertex(width/2 + 220, 390);
    vertex(width/2 + 185, 325);
    vertex(width/2 - 185, 325);
  endShape(CLOSE);
  line(width/2 - 100, 325, width/2 - 100, 390);
  line(width/2 + 100, 325, width/2 + 100, 390);
  
  //roda1
  pushMatrix();
    fill(255);
    translate(width/2 - 200, 525);
    strokeWeight(20);
    circle(0,0,100);
    strokeWeight(5);
    rectMode(CENTER);
    rotate(radians(frameCount*-8));
    line(-50,0,50,0);
    line(0,-50,0,50);
    rectMode(CORNER);
  popMatrix();
  
  //roda2
  pushMatrix();
    fill(255);
    translate(width/2 + 200, 525);
    strokeWeight(20);
    circle(0,0,100);
    strokeWeight(5);
    rectMode(CENTER);
    rotate(radians(frameCount*-8));
    line(-50,0,50,0);
    line(0,-50,0,50);
    rectMode(CORNER);
  popMatrix();
}

void scene4(){
  if(frameCount%24==0 || frameCount == 2000){
    background(random(255), random(255), random(255));
  }
  textAlign(CENTER);
  fill(0);
  text("Matikan listrik jika tidak digunakan", width/2, height/2);
}

void scene5(){
  if(frameCount%24==0 || frameCount == 2244){
    background(random(255), random(255), random(255));
  }
  textAlign(CENTER);
  fill(0);
  text("Dibuat oleh", width/2, height/2 - 50);
  text("Albarra Naufala", width/2, height/2);
}

void pohon(float xDaun){
  pushMatrix();
    //batang
    fill(115, 99, 55);
    rect(xDaun-10,200, 20,100);
    //daun
    fill(140, 247, 139);
    ellipse(xDaun,200, 60, 80);
  popMatrix();
}

void garisPutih(float xGaris){
  pushMatrix();
    //batang
    fill(255);
    rect(xGaris, 525, 150, 20);
  popMatrix();
}
