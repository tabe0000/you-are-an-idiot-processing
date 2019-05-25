import ddf.minim.*;

int winPosX = 200;
int winPosY = 300;

int winSizeX = 400;
int winSizeY = 300;

int parentWinSizeX = 1000;
int parentWinSizeY = 1000;

int winDirX = 1;
int winDirY = 1;

int winSpeedX = 25;
int winSpeedY = 25;

int nowWinColor = 0;
int oldWinColor = 255;

Minim minim;
AudioPlayer player;

boolean isPlaying = false;

protected enum WindowColor {
    WHITE,
    BLACK
}

protected enum State {
    START,
    HOME
}

State state = State.HOME;
WindowColor winColor = WindowColor.WHITE;

void settings(){
    size(parentWinSizeX, parentWinSizeY);
}

void setup() {
    background(255);
    smooth();
    frameRate(8);
    minim = new Minim(this);
    player = minim.loadFile("idiot.mp3");

    PFont font;
    font = createFont("MS Gothic", 36, true);
    textFont(font, 36);

}

void draw() {
    if(state == State.HOME){
        title();
    }else if(state == State.START) {
        window();
        if(!isPlaying){
            isPlaying = true;
            background(#4169e1);
            player.loop();
        }
    }

}

void title() {
    rectMode(CENTER);
    fill(255);
    rect(500, 500, 800, 300);
    translate(500, 500);
    textSize(30);
    fill(30);
    text("なんか懐かしいやつです。",-200 ,0);
    if(mousePressed) {
        state = State.START;
    }
}


void window(){
    rectMode(CORNER);

    //ウィンドウカラーをチェンジ
    if(winColor == WindowColor.WHITE){
        nowWinColor = 255;
        winColor = WindowColor.BLACK;
    }else {
        nowWinColor = 0;
        winColor = WindowColor.WHITE;
    }
    fill(nowWinColor);
    strokeWeight(2);
    stroke(25);
    rect(winPosX, winPosY , winSizeX, winSizeY);

    //ウィンドウの外に出た場合反射させる
    if(winPosX < 0 || winPosX + winSizeX > parentWinSizeX){
        winSpeedX *= -winDirX;
    }
    if(winPosY < 0 || winPosY + winSizeY> parentWinSizeY){
        winSpeedY *= -winDirY;
    }


    //閉じるボタンと上部ステータスバー
    translate(winPosX, winPosY);
    fill(245);
    rect(0, 0, winSizeX, 18);
    fill(#b80c09);
    rect(winSizeX-10, 2, 10, 10);
 

    //テキスト表示
    fill(oldWinColor);
    textSize(30);
    text("You are an idiot", 80, 100);
    

    //ニコニコマーク
    stroke(oldWinColor);
    ellipseMode(CENTER);
    int nicoPosX = winSizeX / 4;
    for(int i=1; i <= 3; i++){
        //目
        noFill();
        //ellipse(winSizeX / 2 -7, winSizeY / 2 + 10, 10, 10);
        //ellipse(winSizeX / 2 +7, winSizeY / 2 + 10, 10, 10);
        ellipse(nicoPosX * i -7, winSizeY / 2 + 10, 10, 10);
        ellipse(nicoPosX * i +7, winSizeY / 2 + 10, 10, 10);
        
        //口
        noFill();
        arc(nicoPosX * i, winSizeY / 2 + 20, 37, 37, radians(30), radians(150));

        //輪郭
        ellipse(nicoPosX * i, winSizeY / 2 + 20, 50, 50);
    }

    
    //ウィンドウを移動
    winPosX += winSpeedX;
    winPosY += winSpeedY;

    oldWinColor = nowWinColor;
}
