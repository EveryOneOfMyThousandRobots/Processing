enum STATE {
  IDLE, 
    FINDING_PATH_TO_RES, 
    GOING_TO_RES, 
    DOING_ACTION, 
    FINDING_PATH_TO_CHEST, 
    CARRYING_TO_CHEST, 
    JOB_COMPLETE, 
    FINDING_PATH_TO_RECHARGE, 
    GOING_TO_RECHARGE, 
    RESET;
}

enum ACTION_TYPE {
  COLLECTING, 
    RECHARGING, 
    DEPOSITING
}

float timeToCollect() {
  return floor(random(40, 100));
}

float timeToDeposit() {
  return floor(random(10, 20));
}

float timeToRecharge() {
  return floor(random(100, 500));
}
final float MAX_POWER = 1000;
class Robot extends DrawMe {
  //float choppingTimer = 0;
  //float choppingTimerMax = floor(random(50, 100));
  //float depositTimer = 0;
  //float depositTimerMax = floor(random(10, 20));
  float rppercent = 0;
  float remainingPower = MAX_POWER;
  float powerSpeed = 2;
  float lowPowerSpeed = 1;
  float speed = 2; 
  float actionTimer, actionTimerMax;
  STATE actionCompleteState = null;
  ACTION_TYPE action = null;

  Job job = null;
  Path path;
  Node start, goal;
  PVector rechargePos;
  Material carrying = null;
  int qty;
  PVector vel;
  STATE state = STATE.IDLE;
  //boolean recharching = false;

  Robot(float x, float y) {
    super(x, y, ROBOT_SIZE, color(128, 128, 0));
    vel = new PVector();
    rechargePos = pos.copy();
  }
  Robot() {
    this(random(width), random(height));
  }

  void draw() {
    //float r = map(remainingPower, 0, MAX_POWER, 128, 0);
    //this.c = color(r, 128, 0);  
    super.draw();
    float x = pos.x;
    float y = pos.y - 3;
    if (state == STATE.DOING_ACTION) { //STATE.COLLECTING || state == STATE.DEPOSITING) {
      //float current = (state == STATE.COLLECTING ? choppingTimer : depositTimer);
      //float max = (state == STATE.COLLECTING ? choppingTimerMax : depositTimerMax);

      GAME_WINDOW.fill(128, 0, 0);
      GAME_WINDOW.noStroke();
      GAME_WINDOW.rect(x, y, map((actionTimer / actionTimerMax), 0, 1, 0, ROBOT_SIZE), 3);
    }
    
    GAME_WINDOW.fill(0,128,255);
    GAME_WINDOW.noStroke();
    GAME_WINDOW.rect(pos.x+1, pos.y+1, 3, (ROBOT_SIZE*rppercent)-2);



    if (path != null) {
      if (path.foundPath) {
        path.draw();
      }
    }
  }

  void setPath(STATE newState) {
    path = new Path(start, goal);
    if (path.foundPath) {
      path.getNextNode();
      state = newState;
    } else {
      state = STATE.RESET;
      jobs.failed(job);
    }
  }

  void updatePower() {

    float powerLoss = 1;
    switch (state) {
    case IDLE:
    case RESET:
    case JOB_COMPLETE:
    case FINDING_PATH_TO_RES:
    case FINDING_PATH_TO_CHEST:
    case FINDING_PATH_TO_RECHARGE:
      powerLoss = 0.1;
      break;
    case DOING_ACTION:
      powerLoss = 1;
      break;
    case GOING_TO_RECHARGE:
    case GOING_TO_RES:
    case CARRYING_TO_CHEST:
      powerLoss = 0.5;
      break;
    }
    remainingPower -= powerLoss;
    if (remainingPower <= 0) {
      remainingPower = 0;
      speed = lowPowerSpeed;
    } else {
      speed = powerSpeed;
    }
    rppercent = remainingPower / MAX_POWER;
  }

  void update() {

    updatePower();
    PVector target = null;
    switch (state) {
    case RESET:
      carrying = null;
      qty = 0;
      job = null;
      state = STATE.IDLE;
      path = null;
      break;
    case FINDING_PATH_TO_RECHARGE:
      start = getNodeFromCoords(pos);
      goal = getNodeFromCoords(rechargePos);
      setPath(STATE.GOING_TO_RECHARGE);    
      //recharching = true;
      break;
    case DOING_ACTION:
      actionTimer -= 1;
      if (actionTimer <= 0) {
        actionComplete();
      } else {
        actionStep();
      }
      break;
    case FINDING_PATH_TO_CHEST:
      start = getNodeFromCoords(pos.x, pos.y);
      goal = getNodeFromCoords(job.structure.pos.x, job.structure.pos.y);
      setPath(STATE.CARRYING_TO_CHEST);

      break;
    case FINDING_PATH_TO_RES:
      start = getNodeFromCoords(pos.x, pos.y);
      goal = getNodeFromCoords(job.resource.pos.x, job.resource.pos.y);
      setPath(STATE.GOING_TO_RES);

      break;
    case IDLE:
      //job = jobs.apply(this);

      if (job != null) {
        state = STATE.FINDING_PATH_TO_RES;
      } else if (remainingPower <= 200) {
        state = STATE.FINDING_PATH_TO_RECHARGE;
      }
      break;
    case GOING_TO_RECHARGE:
      target = path.getCurrentNode().pos;
      break;
    case GOING_TO_RES:
      target = path.getCurrentNode().pos;
      //start = getNodeFromCoords(pos.x, pos.y);
      //goal = getNodeFromCoords(job.resource.pos.x, job.resource.pos.y);
      //path = new Path(start, goal);
      break;
      //case COLLECTING:
      //  choppingTimer -= 1;
      //  if (choppingTimer <= 0) {
      //    carrying = job.resource.type.gives;
      //    qty = job.resource.type.qty;
      //    state = STATE.FINDING_PATH_TO_CHEST;
      //  }
      //  break;
    case JOB_COMPLETE:
      job.structure.addMaterial(carrying, qty);
      jobFinished();
      state = STATE.RESET;
      break;
    case CARRYING_TO_CHEST:
      target = path.getCurrentNode().pos;
      break;
      //case DEPOSITING:
      //  depositTimer -= 1;
      //  if (depositTimer <= 0) {
      //    job.chest.addItem(carrying, qty);
      //    jobFinished();
      //  }
      //  break;
    }

    if (target != null) {
      vel = PVector.sub(target, pos);
      float dist = vel.mag();
      if (dist < speed) {
        Node n = path.getNextNode();
        if (n == null) {

          if (state == STATE.GOING_TO_RES) {
            state = STATE.DOING_ACTION;
            //choppingTimer = choppingTimerMax;
            actionTimerMax = timeToCollect();
            actionTimer = actionTimerMax;
            actionCompleteState = STATE.FINDING_PATH_TO_CHEST;
            action = ACTION_TYPE.COLLECTING;
          } else if (state == STATE.CARRYING_TO_CHEST) {
            state = STATE.DOING_ACTION;
            //choppingTimer = choppingTimerMax;
            actionTimerMax = timeToDeposit();
            actionTimer = actionTimerMax;
            actionCompleteState = STATE.JOB_COMPLETE;
            action = ACTION_TYPE.DEPOSITING;
            //state = STATE.DEPOSITING;
            //depositTimer = depositTimerMax;
          } else if (state == STATE.GOING_TO_RECHARGE) {
            state = STATE.DOING_ACTION;
            actionTimerMax = timeToRecharge();
            actionTimer = actionTimerMax;
            actionCompleteState = STATE.IDLE;
            action = ACTION_TYPE.RECHARGING;
          }
        }
      } else {
        vel.setMag(speed);
        pos.add(vel);
      }
    }
  }

  void actionStep() {
    switch(action) {
    case RECHARGING:
      remainingPower += MAX_POWER / actionTimerMax;
      break;
    case DEPOSITING:
      break;
    case COLLECTING:
      break;
    }
  }

  void actionComplete() {
    switch(action) {
    case RECHARGING:
      remainingPower = MAX_POWER;
      break;
    case DEPOSITING:
      break;
    case COLLECTING:
      carrying = job.resource.type.gives;
      qty = job.resource.type.qty;
      break;
    }
    if (actionCompleteState != null) {
      state = actionCompleteState;
    } else {
      state = STATE.RESET;
    }
    actionCompleteState = null;
  }

  void jobFinished() {
    state = STATE.IDLE;
    jobs.complete(job);
    job = null;
    carrying = null;
    qty = 0;
  }
}
