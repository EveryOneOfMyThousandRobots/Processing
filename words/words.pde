String getWord(int i) {
  String returnValue = "";

  String[] tensList = {"", "ten", "twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"};
  String[] unitsList = {"", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
  String[] teensList = {"ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", 
    "seventeen", "eighteen", "nineteen"};

  int tens = (i % 100) / 10;
  int hundreds = i / 100;
  int units = i % 10;

  String hundreds$ = "";
  String tens$ = "";
  String units$ = "";


  if (i == 0) {
    units$ = "zero";
  } else {
    if (hundreds > 0 ) {
      hundreds$ = getWord(hundreds) + " hundred";
    }

  }

  if (hundreds > 0 && (tens + units > 0)) {
    returnValue = trim(hundreds$) + " and ";
    if (tens > 1 && units > 0) {
      
        returnValue += getWord((tens * 10) + units);
      
    } else {
      returnValue += trim(tens$);
    }
  } else if (hundreds > 0 && (tens + units == 0)) {
    returnValue = trim(hundreds$);
    
  } else {
    if (units > 0) {
    returnValue = trim(tens$) + trim(units$);
    } else {
      returnValue = tens$;
    }
  }



  return trim(returnValue);
}



void setup() {
  noLoop();
  for (int i = 0; i < 999; i += 1) {
    println(i + ":\t\t" + getWord(i));
  }
}