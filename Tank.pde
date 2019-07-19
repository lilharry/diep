public class Tank{
 int health;
 int size;
 int moveSpeed;
 int x, y;
 
 public Tank(int x, int y, int m, int s, int h) {
   this.x = x;
   this.y = y;
   moveSpeed = m;  
   size = s;
   health = h;
 }
 
 public void move(int xd, int yd) {
  x += xd * moveSpeed;
  y += yd * moveSpeed;
 }
 
 public int getX() {
   return x;
 }

 public int getY() {
   return y;
 } 
 
 public void setX(int x){
   this.x = x;
 }
 
 public void setY(int y){
   this.y = y;
 }
 
 public int getSize() {
   return size;
 } 
 
 public int getSpeed(){
   return moveSpeed;
 }
}
