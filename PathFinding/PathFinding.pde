import java.security.*;
NodeMap worldMap;

int deltaTime = 0;
int previousTime = 0;

int mapRows = 100;
int mapCols = 100;

color baseColor = color (0, 127, 0);

void setup () {
  //size (420, 420);
  fullScreen();
  
  initMap();
}

void draw () {
  deltaTime = millis () - previousTime;
  previousTime = millis();
  
  update(deltaTime);
  display();
}

void update (float delta) {
  worldMap.update(delta);
}

void display () {
  
  if (worldMap.path != null) {
    for (Cell c : worldMap.path) {
      c.setFillColor(color (125, 0, 0));
    }
  }
  
  worldMap.display();
} //<>//

void initMap () {
  worldMap = new NodeMap (mapRows, mapCols); 
  
  worldMap.setBaseColor(baseColor);
  
  Boolean setOK = false;
  PVector randomset;
  
  worldMap.makeWall (mapCols / 2, 0, 20, true);
  worldMap.makeWall (mapCols / 2 - 9, 10, 10, false);
  worldMap.makeWall (mapCols / 2 -19, 20, 30, false);
  worldMap.makeWall (mapCols / 2 , 0, 60, true);
  worldMap.makeWall (mapCols / 2 + 20, 50, 50, true);
  worldMap.makeWall (mapCols / 2 - 20, 50, 50, true);
  worldMap.makeWall (mapCols / 2 , 60, 30, true);
  worldMap.makeWall (mapCols / 2 -15, 60, 30, false);
  worldMap.makeWall (mapCols / 2 -40, 30, 30, false);
  worldMap.makeWall (mapCols / 2 -15, 60, 30, false);
  
  while(setOK == false)
  {
    randomset = new PVector((int)random(0,mapCols),(int)random(0,mapRows));
    
    if(worldMap.getstartCelliswalkable((int)randomset.x,(int)randomset.y));
    {
      worldMap.setStartCell((int)randomset.x,(int)randomset.y);
      setOK=true;
    }
    
  }
   
  setOK = false;
 
  while(setOK == false)
  {
    randomset = new PVector((int)random(0,mapCols),(int)random(0,mapRows));
    
    if(worldMap.getstartCelliswalkable((int)randomset.x,(int)randomset.y));
    {
      worldMap.setEndCell((int)randomset.x,(int)randomset.y);
      setOK=true;
    }
    
  }
  
  
  // Mise à jour de tous les H des cellules
  worldMap.updateHs();
    
  worldMap.generateNeighbourhood();
      
  worldMap.findAStarPath();
}
