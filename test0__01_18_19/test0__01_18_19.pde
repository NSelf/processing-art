void setup() {
  size(1280, 720);
  background(0);
  
  PFont f = createFont("Arial", 11, true);
  textFont(f, 32);
  textAlign(CENTER);
  colorMode(HSB, 512);
}


String defaultMessage = "Type out a message!";
StringBuffer userMessage = new StringBuffer();

void keyPressed() {
  if (key == BACKSPACE && userMessage.length() > 0) 
    userMessage.setLength(userMessage.length() - 1);
  else if (key != CODED && 
            key != BACKSPACE &&
            key != ENTER &&
            key != RETURN && 
            key != ESC &&
            key != DELETE)
    userMessage.append(key);
  // println(Character.getType(key).toString());
}

void draw() {
  if (userMessage.length() != 0) {
    int lastChar = (int) userMessage.charAt(userMessage.length() - 1);
    //lowercase are pastel
    if (lastChar > 97 && lastChar < 122)
      background(color(map(lastChar, 97, 122, 0, 512), 256, 256));
    //uppercase are brighter
    else if (lastChar > 65 && lastChar < 90)
      background(color(map(lastChar, 97, 122, 0, 512), 256, 512));
    //puntuation is neon 
    else if (lastChar > 32 && lastChar < 64)
      background(color(map(lastChar, 97, 122, 0, 512), 512, 512));
    //other is gray
    else
      background(color(0, 0, map(lastChar, 0, 669, 0, 512)));
  }
  else
    background(0);
    
  if (userMessage.length() != 0)
    text(userMessage.toString(), width/2, height/2);
  else
    text(defaultMessage, width/2, height/2);
}
