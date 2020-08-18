



enum VIRUS_STATE {
  NONE, 
    INFECTED, 
    IMMUNE
}

int ID = 0;
final int INFECTION_DAYS = 10;
PGraphics graph;

final int MAX_AGE = 50;
final int MAX_PEOPLE = 1000;
final float INFECT_CHANCE = 0.05;
final float LOSE_IMMUNITY_CHANCE = 0.01;
final float SOCIAL_DISTANCE_CHANCE = 0.8;
ArrayList<Loc> homes = new ArrayList<Loc>();
ArrayList<Person> people = new ArrayList<Person>();
ArrayList<Loc> businesses = new ArrayList<Loc>();

void setup() {
  size(800, 800);
  graph = createGraphics(200, 200);
  for (int i = 0; i < MAX_PEOPLE / 10; i += 1) {
    businesses.add( new Loc());
  }


  while (people.size() < MAX_PEOPLE) {
    Loc home = new Loc();
    if (random(1) < SOCIAL_DISTANCE_CHANCE) {
      home.socialDist = true;
    }
    homes.add(home);
    int count = 0;
    while (count < 3 && people.size() < MAX_PEOPLE) {
      Loc b = getRandomBusiness();
      Person p = new Person(home, b, home, floor(random(MAX_AGE)));

      people.add(p);
      count += 1;
    }
  }

  int infected = 0;
  while (infected < 100) {
    Person p = people.get(floor(random(people.size())));
    if (p.vState == VIRUS_STATE.NONE) {
      p.vState = VIRUS_STATE.INFECTED;
      infected += 1;
    }
  }
}


ArrayList<PVector> data = new ArrayList<PVector>();

void checkInfections(ArrayList<Loc> locs) {
  for (Loc loc : locs) {
    int numInfected = 0;
    for (Person p : loc.occupants) {
      if (p.vState == VIRUS_STATE.INFECTED) {
        numInfected += 1;
      }
    }

    if (numInfected > 0) {
      for (Person p : loc.occupants) {
        if (p.vState == VIRUS_STATE.NONE) {
          if (random(1) < (float)numInfected * INFECT_CHANCE) {
            p.vState = VIRUS_STATE.INFECTED;
          }
        }
      }
    }
  }
}


void checkInfections() {
  checkInfections(homes);
  checkInfections(businesses);
}

int dayCounter = 0;
enum DAY_STATE {
  MORNING_CHECK, 
    GOTO_WORK, 
    GOTO_SHOPS, 
    GOTO_HOME, 
    COLLECT_DATA
}

DAY_STATE dState = DAY_STATE.GOTO_WORK;
int hw = 20;
int hh = 20;
int padding = 4;

void draw() {
  background(0);

  switch (dState) {
  case MORNING_CHECK:
    for (Person p : people) {
      if (p.vState == VIRUS_STATE.INFECTED) {
        p.infectionTimer -= 1;
        if (p.infectionTimer <= 0) {
          p.vState = VIRUS_STATE.IMMUNE;
        }
      } else if (p.vState == VIRUS_STATE.IMMUNE) {
        if (random(1) < LOSE_IMMUNITY_CHANCE) {
          p.vState = VIRUS_STATE.NONE;
        }
      } else if (p.vState == VIRUS_STATE.NONE) {
        if (random(1) < INFECT_CHANCE) {
          p.vState = VIRUS_STATE.INFECTED;
        }
      }
    }   

    for (int i = people.size()-1; i >= 0; i -= 1) {
      Person p = people.get(i);
      p.age += 1;
      float c = ((float) p.age / MAX_AGE) / 10;
      if (random(1) < c) {
        Loc h = p.home;
        people.remove(i);
        p.currentLoc.leave(p);
        Person pp =new Person(h, getRandomBusiness(), h, 0);

        people.add(pp );
      }
    }

    dState = DAY_STATE.GOTO_WORK;
    break;
  case GOTO_WORK:
    for (Person p : people) {
      p.gotoWork();
    }
    checkInfections();
    dState = DAY_STATE.GOTO_SHOPS;
    break;
  case GOTO_SHOPS:
    for (int i = 0; i < 2; i += 1) {
      for (Person p : people) {
        p.gotoRandomBusiness();
      }
      checkInfections();
    }  
    dState = DAY_STATE.GOTO_HOME;
    break;
  case GOTO_HOME:
    for (Person p : people) {
      p.gotoHome();
    }
    checkInfections();
    dState = DAY_STATE.COLLECT_DATA;
    break;
  case COLLECT_DATA:
    PVector day = new PVector();
    for (Person p : people) {
      switch (p.vState) {
      case NONE:
        day.x += 1;
        break;
      case INFECTED:
        day.y += 1;
        break;
      case IMMUNE:
        day.z += 1;
        break;
      }
    }
    data.add(day);
    dayCounter += 1;
    dState = DAY_STATE.MORNING_CHECK;

    //if (data.size() > 100) {
    //  for (int i = data.size()-1; i >= 1; i -= 1) {
    //    if (i % 5 != 0) {
    //      data.remove(i);
    //    }
    //  }
    //}
    break;
  }


  //go to work 







  if (data.size() > 0) {
    graph.beginDraw();
    graph.background(0);
    float w = (float)graph.width / (float)data.size();
    float x = 0;
    for (PVector p : data) {
      float infectH = map(p.y, 0, MAX_PEOPLE, 0, graph.height);
      float immuneH = map(p.z, 0, MAX_PEOPLE, 0, graph.height);
      float noneH   = map(p.x, 0, MAX_PEOPLE, 0, graph.height);

      graph.noStroke();
      graph.fill(0, 255, 0);
      graph.rect(x, graph.height-infectH, w+1, infectH);

      graph.noStroke();
      graph.fill(100);
      graph.rect(x, graph.height-infectH-immuneH, w+1, immuneH);

      graph.noStroke();
      graph.fill(0, 0, 255);
      graph.rect(x, graph.height-infectH-immuneH-noneH, w+1, noneH);





      x += w;
    }
    int y = 0;
    float step = (float) graph.height / 10;
    graph.stroke(255, 128);
    for (y = graph.height; y >= 0; y -= step) {
      graph.line(0, y, graph.width, y);
    }
    graph.endDraw();
  }
  int x = 0; 
  int y = 0;
  for (Loc home : homes) {

    noFill();
    stroke(255);

    rect(x, y, hw-1, hh-1);
    fill(255);
    text(home.occupants.size(), x+2, y+5);


    y += hh + padding;
    if (y > height-hh) {
      y = 0;
      x += hw + padding;
      if (x > width-hw) {
        x = 0;
      }
    }
  }
  y = 0;
  x += (hw + padding)*2;
  for (Loc bs : businesses) {

    noFill();
    stroke(255);

    rect(x, y, hw-1, hh-1);
    fill(255);
    text(bs.occupants.size(), x+2, y+5);


    y += hh + padding;
    if (y > height-hh) {
      y = 0;
      x += hw + padding;
      if (x > width-hw) {
        x = 0;
      }
    }
  }

  image(graph, width-graph.width, 0);




  fill(255);
  text(dayCounter + "\n" + dState, 10, 10);
}
