public class Bullet{
 
  int radius;
  int x,y;
  float xs, ys;
  int damage;
  int speed;
  int time;
  
  public Bullet(int x, int y, int r,int d, int s, float xs, float ys) {
  
    radius = r;
    this.x = x;
    this.y = y;
    damage = d;
    speed = s;
    this.xs = xs;
    this.ys = ys;
    time = millis();
  }
  
 public int getX() {
   return x;
 }

 public int getY() {
   return y;
 } 
 public int getR() {
   return radius;
 }
 
 public int getTime(){
   return time;
 }
 public void move(){
   x += xs;
   y += ys;
   /*if (xs > 0){
     xs -= abs(xs / (100 * ys + 100 * xs));
   }else{
     xs += abs(xs / (100 * ys + 100 * xs));
   }
   if (ys > 0){
     ys -= abs(ys / (100 * ys + 100 * xs));
   }else{
     ys += abs(ys / (100 * ys + 100 * xs));
   }*/
   
 }
 
 
}
