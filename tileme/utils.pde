final int RESOURCE_WOOD = 1;
final int RESOURCE_WOOL = 2;
final int RESOURCE_GOLD = 3;
final int RESOURCE_COAL = 4;
final int RESOURCE_WATER = 5;
final int RESOURCE_CHEESE = 6;
final int RESOURCE_MILK = 7;
final int RESOURCE_WHEAT = 8;
final int RESOURCE_BREAD = 9;
final int RESOURCE_CAKE = 10;
final int RESOURCE_IPHONES = 11;
final int RESOURCE_ELECTRONICS = 12;
final int RESOURCE_MUFFINS = 13;
final int RESOURCE_CHIPS = 14;
final int RESOURCE_POTATOES = 15;
final int RESOURCE_LOWEST_NUM = RESOURCE_WOOD;
final int RESOURCE_HIGHEST_NUM = RESOURCE_POTATOES;

final int ACTION_NONE = 0;

final int ACTION_PICKUP = 1;
final int ACTION_DROP = 2;
color getResourceColour(int resourceId) {
  color returnValue = color(0);
  switch (resourceId) {
  case RESOURCE_WOOD:
    returnValue = color(20, 
    break;
  case RESOURCE_WOOL:
    returnValue ="Wool";
    break;
      case RESOURCE_MILK:
    returnValue ="MILK";
    break;
  case RESOURCE_GOLD:
    returnValue ="Gold";
    break;
  case RESOURCE_COAL:
    returnValue ="Coal";
    break;
  case RESOURCE_WATER:
    returnValue ="Water";
    break;
  case RESOURCE_CHEESE:
    returnValue ="Cheese";
    break;
  case RESOURCE_WHEAT:
    returnValue ="Wheat";
    break;
  case RESOURCE_BREAD:
    returnValue ="Bread";
    break;
  case RESOURCE_CAKE:
    returnValue ="Cake";
    break;
  case RESOURCE_ELECTRONICS:
    returnValue ="Electronics";
    break;
  case RESOURCE_MUFFINS:
    returnValue ="Muffins";
    break;
  case RESOURCE_IPHONES:
    returnValue ="iPhones";
    break;
  case RESOURCE_CHIPS:
    returnValue ="Chips";
    break;
  case RESOURCE_POTATOES:
    returnValue ="Chips";
    break;
  default:
    returnValue = "ERROR " + resourceId;
    
  }
  return returnValue;
}

String getResourceName(int resourceId) {
  String returnValue = "";
  switch (resourceId) {
  case RESOURCE_WOOD:
    returnValue ="Wood";
    break;
  case RESOURCE_WOOL:
    returnValue ="Wool";
    break;
      case RESOURCE_MILK:
    returnValue ="MILK";
    break;
  case RESOURCE_GOLD:
    returnValue ="Gold";
    break;
  case RESOURCE_COAL:
    returnValue ="Coal";
    break;
  case RESOURCE_WATER:
    returnValue ="Water";
    break;
  case RESOURCE_CHEESE:
    returnValue ="Cheese";
    break;
  case RESOURCE_WHEAT:
    returnValue ="Wheat";
    break;
  case RESOURCE_BREAD:
    returnValue ="Bread";
    break;
  case RESOURCE_CAKE:
    returnValue ="Cake";
    break;
  case RESOURCE_ELECTRONICS:
    returnValue ="Electronics";
    break;
  case RESOURCE_MUFFINS:
    returnValue ="Muffins";
    break;
  case RESOURCE_IPHONES:
    returnValue ="iPhones";
    break;
  case RESOURCE_CHIPS:
    returnValue ="Chips";
    break;
  case RESOURCE_POTATOES:
    returnValue ="Chips";
    break;
  default:
    returnValue = "ERROR " + resourceId;
    
  }
  return returnValue;
}