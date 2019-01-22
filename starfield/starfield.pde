/*--------------------*/
/*--------------------*/

Star[] stars = new Star[200];
float cameraSpeed = 10;
float depth = 1000;
boolean showFrameRate = true;
boolean paused = false;

void setup() {
    size(300, 400);
    colorMode(HSB, 360, 100, 100);
    background(color(340, 60, 20));
    frameRate(60);
    textAlign(LEFT, TOP);

    for (int i = 0; i < stars.length; i++) {
        stars[i] = new Star(random(-width / 2, width / 2),
                            random(-height / 2, height / 2),
                            random(0, depth));
    }
}

void draw() {
    background(color(340, 60, 20));
    translate(width / 2, height / 2);

    for (int i = 0; i < stars.length; i++) {
        stars[i].update();
        stars[i].show();
    }

    if (showFrameRate) {
        fill(0, 0, 0);
        text(frameRate, -width / 2, -height / 2);
    }
}

/*--------------------*/

public abstract class Body {
    protected PVector p;
    protected float r;
    
    protected PVector velocity;
}

/*--------------------*/

public class Star extends Body {

    public Star(float x, float y, float z) {
        p =  new PVector(x, y, z);
        r = 5;
    }

    public void update() {
        p.z -= cameraSpeed;

        if (p.z < 1 || p.x < -width / 2 || p.y < -height / 2 || p.x > width / 2 || p.y > height / 2) {
            p.x = random(-width / 2, width / 2);
            p.y = random(-height / 2, height / 2);
            p.z = depth;
        }
    }

    public void show() {
        float sx = map(p.x / ((p.z / depth) * width), -1, 1, -width / 2, width / 2);
        float sy = map(p.y / ((p.z / depth) * height), -1, 1, -height / 2, height / 2);
        float sr = map(p.z / depth, 0, 1, r, 0);
        float brightness = map(p.z / depth, 0, 1, 100, 20);

        fill(color(340, 60, brightness));
        noStroke();
        ellipse(sx, sy, sr * 2, sr * 2);
    }
}

/*--------------------*/
/*--------------------*/