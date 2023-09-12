float h;
float r;
float c;
float speed=0.002;
float angleDirection = 1;
float angle = 0.0;
float angleH = 1; 
 int x=0, y=0;
float angleX = 3, angleY = 3; 
float offset = 0;
float easing = 0.03;
int cl = 255;
int mn1 =135;
int mn2 =206;
int mn3 = 235;
int sn1 =253;
int sn2 =184;
int sn3 = 19;
int bg1 =135;
int bg2 =206;
int bg3 = 235;
PShape sun;
PShape moon;
PShape cloud1;
PShape cloud2;
PShape cloud3;
PShape fire;
PShape logo;
PShader toon;

void setup(){
size(1000, 700,P3D);
 toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
 toon.set("fraction", 1.0);
 fire = loadShape("fire.svg");
 cloud1 = loadShape("cloud1.svg");
 cloud2 = loadShape("cloud2.svg");
 cloud3 = loadShape("cloud3.svg");
 sun = loadShape("sun.svg");
 moon = loadShape("moon.svg");
}

void draw(){
background(bg1,bg2,bg3);     


pushStyle();    
sun.disableStyle();
moon.disableStyle();   
fill(mn1,mn2,mn3);
noStroke();
shape(moon,20,30,170,120);
fill(sn1,sn2,sn3);
shape(sun,850,30,120,120);
popStyle();


pushMatrix();
cloud(0,0);
cloud(0,-420);
popMatrix();
float targetOffset = map(h, 0, height, -40, 40);
offset += (targetOffset - offset) * easing;


if(mousePressed){
mn1 =244;
mn2= 246;
mn3=240; 
cl=100;
 bg1 =25;
 bg2 =25;
 bg3 = 112;
 sn1 =25;
 sn2 =25;
 sn3 = 112;
}
else{
 mn1 =135;
 mn2 =206;
 mn3 = 235;
cl=255;
 bg1 =135;
 bg2 =206;
 bg3 = 235;
 sn1 =253;
 sn2 =184;
 sn3 = 19;
}


//center robot
scale(0.68);
robot(150,100+offset,70,50);

pushMatrix();
//left robot 1
scale(0.6);
float smallerOffset = offset * 0.7;
robot(0,50+ smallerOffset,180,80);

//left robot 2
scale(0.8);
robot(-250,100,80,255);

//left robot 3
scale(1.8);
robot(-300,-10,255,255);
popMatrix();


//right robot 1
scale(0.6);
robot(1200,50,100,150);

//rabbit
pushMatrix();
scale(0.45);
rabbit(20,1400+offset);
popMatrix();
//right robot 2
scale(0.8);
robot(450,100,0,205);

//right robot 3
scale(0.8);
robot(400,10,202,205);




}
void cloud(float xx,float yy){  
translate(xx,yy);
cloud1.disableStyle();
cloud2.disableStyle();
cloud3.disableStyle();    
pushStyle();
fill(cl);   
noStroke();
c+=2;
shape(cloud1,30,c+220,150,70);
shape(cloud2,150,c+170,160,70);
shape(cloud3,300,c+220,170,70);
shape(cloud1,400,c+320,150,70);
shape(cloud2,500,c+150,160,70);
shape(cloud3,600,c+220,170,70);
shape(cloud2,750,c+270,160,70);
shape(cloud3,600,c+400,170,70);
popStyle();
}
void robot(float x, float y,float g,float i){  
translate(x,y);
pushStyle();
strokeWeight(3);
fill(200,i,g);
rect( 415, 268,8,40);
pushMatrix();
translate( 420, 270);
rotate(radians(r));
fill(g,30,i);
ellipse(0,0,10,10);
ellipse(21,0,22,7);  
ellipse(0,21,7,22); 
ellipse(-21,0,22,7);
ellipse(0,-21,7,22);
r+=10;
popMatrix();
popStyle();
strokeWeight(7);

//hat
fill(200,i,g);
rect( 350, 350,140,20); //+290 +325
arc( 420, 350, 100,80,radians(-180), radians(0));
//face 
fill(i,103,g);
rect( 370, 375,100,70);

//eyes
fill(100,255,i);
ellipse( 404, 400,14,13);
ellipse( 436, 400,14,13);
arc( 420, 420, 30,20,0, PI);

//body
fill(i,103,g);
rect( 370, 460,100,110);

////left hand
pushMatrix();
beginShape();
translate(350, 490);
rotate(angle*2);
vertex( 0,  0);
vertex( -25,  0);
vertex( -25,   70);  
vertex( 0, 70); 
endShape(CLOSE);
ellipse(-12,85,25,25);
popMatrix();

//right hand
pushMatrix();
beginShape();
translate(490, 490);
rotate(-angle*2);
vertex( 0,  0);
vertex( 25,  0);
vertex( 25,   70);  
vertex( 0, 70); 
endShape(CLOSE);
ellipse(12,85,25,25);
popMatrix();

//left foot
rect( 370, 575,35,90);
ellipse( 388, 668,36,23);

//right foot
rect( 435, 575,35,90);
ellipse( 453, 668,36,23);

angle += speed * angleDirection;
 if ((angle > radians(65)) || (angle < 0)) {
 angleDirection = -angleDirection;
 }
 h+=angleH;
if((h > 500)||(h<-500)){
angleH = -angleH;
}
 h+=angleH;
if((h > 500)||(h<-500)){
angleH = -angleH;
}
if(c >1000){
c=-500;
}
}
void rabbit(float b, float d){
  pushStyle();
  noStroke();
translate(b,d);
//eye
pushMatrix();
fill(255);
translate(240, 420);
shader(toon);
float dirY = (y / float(height) - 0.5) * 2;
float dirX = (x / float(width) - 0.5) * 2;
directionalLight(0, 0, 0, -dirX, -dirY, -1);
sphere(30);
translate(120,0);
sphere(32);
x+=1*angleX;
y+=1*angleY;
if((y > 400)||(y<0)){
angleY = -angleY;
}
if((x > 800)||(x<0)){
angleX = -angleX;
}
resetShader();
noLights();
popMatrix();


//face
fill(#F0FFF0);
ellipse(300,450,400,400);

//daun telinga
ellipse(220,200,100,250);
ellipse(380,200,100,250);

//telinga
fill(#f6b4b5);
ellipse(220,190,50,125);
ellipse(380,190,50,125);

//mulut
fill(#f2dfbe);
ellipse(300,520,160,140);

//hidung
fill(0);
ellipse(300,490,40,30);

//alis
arc(240,350,35,25,radians(180),radians(360));
arc(360,350,35,25,radians(180),radians(360));

//pipi
fill(#ff7970);
ellipse(170,490,50,50);
ellipse(430,490,50,50);


//garis hidung dan mulut
pushStyle();
noFill();
stroke(#9d3b27);
strokeWeight(5);
line(300,505,300,542);
arc(282,538,35,40,radians(0),radians(180));
arc(318,538,35,40,radians(0),radians(180));
popStyle();

//tangan
pushMatrix();
beginShape();
fill(#F0FFF0);
translate(130, 750);
rotate(angle/2.5);
vertex( 0,  0);
vertex( -300,  0);
vertex( -300,   75);  
vertex( 0, 75); 
endShape(CLOSE);
arc(-300,37,75,75,radians(90),radians(270));
popMatrix();

pushMatrix();
beginShape();
fill(#F0FFF0);
translate(470, 750);
rotate(-angle/2.5);
vertex( 0,  0);
vertex( 300,  0);
vertex( 300,   75);  
vertex( 0, 75); 
endShape(CLOSE);
arc(300,37,75,75,radians(270),radians(550));
popMatrix();

//kaki
pushMatrix();
beginShape();
fill(#F0FFF0);
translate(340, 1150);
vertex( 0,  0);
vertex( 0,  350);
vertex( 75,   350);  
vertex(75, 0); 
endShape(CLOSE);
fill(#ff7970);
rect(0,290,75,75);
ellipse(90,360,180,80);
rotate(radians(180));
shape(fire,-120,-620,100,200);
popMatrix();

pushMatrix();
beginShape();
fill(#F0FFF0);
translate(260, 1150);
vertex( 0,  0);
vertex( 0,  350);
vertex( -75,   350);  
vertex(-75, 0); 
endShape(CLOSE);
fill(#ff7970);
rect(-75,290,75,75);
ellipse(-90,360,180,80);
rotate(radians(180));
shape(fire,-30,-620,100,200);
popMatrix();

//badan
fill(#F0FFF0);
ellipse(300,920,430,600);
popStyle();
}
