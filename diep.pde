import java.util.ArrayList;
 
Tank player;
PImage drawTank;
ArrayList<Square> squares;
ArrayList<Bullet> bullets;
ArrayList<Bullet> enemyBullet;
ArrayList<Tank> enemy;
int nSquares;
int nEnemy;
int x, y;


boolean movingLeft, movingUp, movingRight, movingDown;
boolean shooting;

int bulletSpeed;
int time;
int delay;

void settings() {
  size(1000, 1000);
}

void setup(){
  player = new Tank(0, 0, 3, 80, 100);
  drawTank = loadImage("img/Tank.png");
  nSquares = 5000;
  nEnemy = 100;
  x = height/2;
  y = width/2;
  movingLeft = movingUp = movingRight = movingDown = false;
  squares = new ArrayList<Square>(5000);
  bullets = new ArrayList<Bullet>();
  enemy = new ArrayList<Tank>();
  enemyBullet = new ArrayList<Bullet>();
  shooting = false;
  bulletSpeed = 10;
  generateSquares();
  generateEnemy();
  
  delay = 300;
  time = 0;
  rectMode(CENTER);
  imageMode(CENTER);
}

void draw(){
  background(209, 209, 209);
  translate(x, y);
  strokeWeight(2);
  
  drawGrid();
  drawSquares();
  movePlayer();
  moveBullets();
  shoot();
  drawBullets();
  drawPlayer();
  drawEnemy();
  checkCollision();
}

void drawGrid(){
  stroke(205, 205, 205);
  fill(205, 205, 205);
  for (int i = -5000; i < 5000; i+= 20){
    line(i, -5000, i, 5000);
  }
  for (int i = -5000; i < 5000; i+= 20){
    line(-5000, i, 5000, i);
  }
}

public float direction() {
  if (mouseY == height/2 && mouseX <= width/2) {return 3*PI/2;}
  else if (mouseY == height/2 && mouseX > width/2) {return PI/2;}

  if (mouseY > 500){
    return PI + atan(- float(mouseX - width/2) / (mouseY - height/2));
  } else {
    return atan(- float(mouseX - width/2) / (mouseY - height/2));
  }
}
void drawPlayer(){
  pushMatrix();
  translate(player.getX(), player.getY());
  rotate(direction());
  ellipse(0,0,10,10);
  drawTank.resize(player.getSize(), player.getSize());
  image(drawTank, 0, 0);
  popMatrix();
}

void movePlayer(){
  if (movingLeft){
    x += player.getSpeed();
    player.setX(player.getX() - player.getSpeed());
  }
  if (movingRight){
    x -= player.getSpeed();
    player.setX(player.getX() + player.getSpeed());
  }
  if (movingUp){
    y += player.getSpeed();
    player.setY(player.getY() - player.getSpeed());
  }
  if (movingDown){
    y -= player.getSpeed();
    player.setY(player.getY() + player.getSpeed());
  }
}

void generateSquares(){
  for (int i = 0; i < nSquares; i++){
    squares.add(new Square(int(random(-5000,5000)), int(random(-5000,5000)), 35));
  }
}

void generateEnemy(){
  for (int i = 0; i < nEnemy; i++) {
    enemy.add(new Tank(int(random(-5000,5000)), int(random(-5000,5000)), 0, int(random(50,100)), 50));
  }
}

void drawSquares(){
  for (Square s : squares){
    stroke(191, 174, 79);
    fill(255,232,105);
    rect(s.getX(), s.getY(), s.getSize(), s.getSize());
  }
}

void drawEnemy(){
  for (Tank t : enemy) {
    image(drawTank, t.getX(), t.getY());
  }
}
  
void keyPressed(){
  if (key == 'a' || key == 'A'){
    movingLeft = true;}
  if (key == 's' || key == 'S') {
    movingDown = true;}
  if (key == 'w' || key == 'W') {
    movingUp = true;}
  if (key == 'd' || key == 'D') {
    movingRight = true;}
}

void keyReleased(){
  if (key == 'a' || key == 'A'){
    movingLeft = false;}
  if (key == 's' || key == 'S') {
    movingDown = false;}
  if (key == 'w' || key == 'W') {
    movingUp = false;}
  if (key == 'd' || key == 'D') {
    movingRight = false;}
}

void shoot(){
  if (shooting && millis() - time > delay ){
    float xs;
    float ys;
    
    if (mouseY == height/2 && mouseX <= width/2) {xs = -bulletSpeed; ys = 0;}
    else if (mouseY == height/2 && mouseX > width/2) {xs = bulletSpeed; ys = 0;}
    
    float theta = -PI/2 + atan(- float(mouseX - width/2) / (mouseY - height/2));
    if (mouseY > 500){
      xs = bulletSpeed * cos(PI + theta);
      ys = bulletSpeed * sin(PI + theta);
    } else {
      xs = bulletSpeed * cos(theta);
      ys = bulletSpeed * sin(theta);
    }

    bullets.add(new Bullet(player.getX(), player.getY(), 10, 1, bulletSpeed, xs, ys));
    
    time = millis();
  }
}

void enemyShoot() {
  for (int i = 0; i < enemy.size(); i++) {
    }
}
  
  
void moveBullets(){
  for (Bullet b: bullets){
    b.move();
    if (millis() - b.getTime() > 10000){
      bullets.remove(b);
      return;
    }
  }
}
void drawBullets(){
  for (Bullet b: bullets){
    stroke(2, 134, 168);
    fill(0, 178, 225);
    ellipse(b.getX(), b.getY(), b.getR() * 2, b.getR() * 2);
  }
}

void checkCollision() {
  for (int i = 0; i < bullets.size(); i++){
    for (int j = 0; j < squares.size(); j++) {
      if (abs(bullets.get(i).getX() - squares.get(j).getX()) < bullets.get(i).getR() + squares.get(j).getSize() * sqrt(2) / 2  && 
          abs(bullets.get(i).getY() - squares.get(j).getY()) < bullets.get(i).getR() + squares.get(j).getSize() * sqrt(2) / 2){
        bullets.remove(i);
        squares.remove(j);
        return;
      }
    }
  }
}

void mousePressed(){
 shooting = true;
}

void mouseReleased(){
 shooting = false;
}
