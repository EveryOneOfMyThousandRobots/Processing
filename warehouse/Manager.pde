class Manager {
  ArrayList<Ticket> waiting = new ArrayList<Ticket>();
  ArrayList<Ticket> picking = new ArrayList<Ticket>();
  ArrayList<Ticket> complete = new ArrayList<Ticket>();
  
  
  
  
  void update() {
    if (waiting.size() == 0) {
      waiting.add(new Ticket(5));
    }
  }
  
  void complete(Ticket ticket) {
    picking.remove(ticket);
    complete.add(ticket);
  }
  
  Ticket getTicket() {
    Ticket ticket = null;
    if (waiting.size() > 0) {
      ticket = waiting.remove(0);
      picking.add(ticket);
      
      
    }
    
    return ticket;
  }
}
