boolean goup,godown,goright,goleft=false;
PImage bg1,bg2,end1,end2,enemy,fighter,hp,enemy1,gainbomb,start1,start2,treasure;
int x,y,mx,my,i,j,t,t2,con =0;
final int Game_start=1,Game_win=2,Game_lose=3,Game_run=4;
int gameState;
float life=0;
int xspeed=5;
int yspeed=5;
int exspeed=5;
float eyspeed=2.5;
int randomY=0;
int currentFrame;
PImage []boom = new PImage[6];
int []boomnum = new int[6];
int [][]arrayX = new int[6][6];
int [][]arrayY = new int [6][6];
boolean [][]boomed = new boolean[6][6];

void setup () {

  life = 195*0.2;
  t2=-60*5;
  size(640, 480) ;
  x=width-50;
  y=height/2-25;
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  for (int i=1;i<=5;i++){
    boom[i] = loadImage("img/flame"+i+".png");
  }
  
  mx=floor(random(600));
  my=floor(random(440));
  randomY=floor(random(0,height-60));
  println(randomY);
  
  gameState = Game_start;
}

void draw() {
  
  switch (gameState){
    case Game_start:
         image(start2,0,0);
         if (mouseX>200 & mouseX<455 & mouseY>375 & mouseY<415){
             image(start1,0,0);
             if(mousePressed){
               t2=-60*5;
               for (int i=1;i<=5;i++){       // restart
                  for (int j=1;j<=5;j++){
                    boomed[i][j]=false;
                  }
               }
               gameState = Game_run;
             }
         }
         
         break; 
     case Game_run:
          image(bg1,t,0);
          image(bg2,t-640,0);
          image(bg1,t-1280,0);
          t++;
          t%=1280;
          
          fill(255,0,0);
          rect(10,0,life,20);
          
          image(hp,0,0);            //life          
          image(treasure,mx,my);
          image(fighter,x,y);         
          //translate(t2,0);  //group moving
          t2+=5;
          
          for (int i=1;i<=5;i++){
            for (int j=1;j<=5;j++){
              
              switch(con%3){
                case 0:
                //image(enemy,i*60,randomY);
                if (i==3 &(boomed[i][j]==false)){
                  arrayX[3][j]=j*60+t2;
                  arrayY[3][j]=randomY;
                }else{
                  arrayX[i][j]=width+60;
                  arrayY[i][j]=height+60;
                }
                break;
                case 1:
                if (i+j==6&(boomed[i][j]==false)){
                  arrayX[i][j]=i*60+t2;
                  arrayY[i][j]=randomY+(j-1)*40;
                //image(enemy,i*60,randomY+(j-1)*40);
                }else{
                  arrayX[i][j]=width+60;
                  arrayY[i][j]=height+60;
                }
                break;
                case 2:
                if ((abs(j-3)+abs(i-3)==2)&(boomed[i][j]==false)){
                  arrayX[i][j]=i*60+t2;
                  arrayY[i][j]=randomY+(j-1)*60;
                  //image(enemy,i*60,randomY+(j-1)*60);
                }else{
                  arrayX[i][j]=width+60;
                  arrayY[i][j]=height+60;
                }
                break;
              }
              // by hit
              if ((x>=arrayX[i][j]-50)&(x<=arrayX[i][j]+60)&(y>=arrayY[i][j]-50)&(y<arrayY[i][j]+60)){
                  //image(boom[],arrayX[i][j],arrayY[i][j]);
                  arrayX[i][j]=width+60;
                  arrayY[i][j]=height+60;
                  boomed[i][j]=true;
                  
                  image(enemy,arrayX[i][j],arrayY[i][j]);
                  life=life-19.5*2;
              }else{
                image(enemy,arrayX[i][j],arrayY[i][j]);
              }
              
              if ((frameCount % 10 ==0)&(boomed[i][j]==true)){
                int num =(currentFrame ++)% 5;
                image(boom[num+1],arrayX[i][j],arrayY[i][j]);
              }
              
            }
          }
          
          if (t2>=width){        // con++ //  next group
              t2=-60*5;  
              for (int i=1;i<=5;i++){
                for (int j=1;j<=5;j++){
                  boomed[i][j]=false;
                }
              }
              switch(con%3){
                case 0:
                randomY=floor(random(0,height-200));
                //println(randomY);
                break;
                case 1:
                randomY=floor(random(0,height-300));
                //println(randomY);
                break;
                case 2:
                randomY=floor(random(0,height-60));       
                //println(randomY);
                break;
              }
              con++;
          }

          if (goup){
            y-=yspeed;
          }
          if (godown){
            y+=yspeed;
          }
          if (goright){
            x+=xspeed;
          }
          if (goleft){
            x-=xspeed;
          }
          
          if (x<=0){
            x=0;
          }
          if (x>=width-50){
            x=width-50;
          }
          if (y<=0){
            y=0;
          }
          if (y>=height-50){
            y=height-50;
          }
                                    // get treasure
          if ((x>=mx-50)&(x<=mx+40)&(y>=my-50)&(y<my+40)){
            mx=floor(random(600));
            my=floor(random(440));
            life+=19.5;
               if (life >=195){
               life =195;
               }
          }
   
          if (life<=0){
               gameState = Game_lose;
           }
          break;
          
     case Game_lose:
          image(end2,0,0);
          if ((mouseX>=208)&(mouseX<=433)&(mouseY>=310)&(mouseY<=345)){
              image(end1,-0.5,0);
              if (mousePressed){
                life = 195*0.2;
                x=width-50;
                y=height/2-25;
                con=0;
                gameState=Game_start;
              }
          }else{
            image(end2,0,0);
          }
          break;
  }
         
}
void keyPressed(){
     if (key==CODED){
         if (keyCode == UP){
            goup=true;
         }else if (keyCode == DOWN){
                  godown=true;
               }
     
          if (keyCode == RIGHT){
             goright=true;
          }else if (keyCode == LEFT){
                    goleft=true;
                 }
     }

}
void keyReleased(){
     if (key==CODED){
         if (keyCode == UP){
            goup=false;
         }else if (keyCode == DOWN){
                  godown=false;
               }
     
        if (keyCode == RIGHT){
           goright=false;
        }else if (keyCode == LEFT){
                  goleft=false;
               }
     }

}
