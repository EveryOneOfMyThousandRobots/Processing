class Episode {
  String ep;// = "011";
  //String guest1;// = "Elena Kerrigan";
  //String guest2;// = "Kathy Manson";
  //String guest3;// = "Annie Harris";
  String[] guests;

  Episode(String ep, String... guests) {
    this.ep = ep;
    this.guests = guests;
  }
}

ArrayList<Episode> episodes = new ArrayList<Episode>();

void makeEpisodes() {
  //addEp("001", "Matt Callaghan");
  //addEp("002", "Louis Heriz-Smith", "Carrie White");
  //addEp("003", "Simon Goodway", "Ben Tucker");
  //addEp("004", "Alex Morgan", "Ben Tucker");
  //addEp("005", "Heather Urquhart", "Ben Tucker");
  //addEp("006", "Louis Heriz-Smith");
  //addEp("007", "Louis Heriz-Smith", "Jack Heriz-Smith");
  //addEp("008", "Jen Rowe", "Simon Goodway");
  //addEp("009", "John Cremer", "Ben Tucker");
  //addEp("010", "Annie Harris");
  //addEp("011", "Elena Kerrigan", "Kathy Mason", "Annie Harris");
  addEp("012", "Katharine Steer", "Simon Goodway");
}

void addEp(String ep, String... g) {

  episodes.add(new Episode(ep, g));
}
