int TICKET_ID = 0;
class Ticket {
  final int id;
  {
    TICKET_ID += 1;
    id = TICKET_ID;
  }
  HashMap<Item, Integer> list;
  ArrayList<TicketItem> pickList;

  Ticket(int numItems) {
    list = new HashMap<Item, Integer>(numItems);
    pickList = new ArrayList<TicketItem>();
    for (int i = 0; i < numItems; i += 1) {
      Item item = getRandomItem();
      if (list.containsKey(item)) continue;

      list.put(item, floor(random(1,5)));
    }

    for (Item item : list.keySet()) {
      HashMap<Bay, Integer> itemBays = item.getBays();
      int qtyRequired = list.get(item);

      while (qtyRequired > 0) {
        for (Bay bay : itemBays.keySet()) {
          int qty = itemBays.get(bay);
          if (qty > 0) {
            int qtyTaken = 0;
            if (qty >= qtyRequired) {
              qtyTaken = qtyRequired;
            } else { 
              qtyTaken = qty;
            }

            if (qtyTaken > 0) {
              TicketItem ti = new TicketItem(this, bay, item, qtyTaken);
              pickList.add(ti);
              qtyRequired -= qtyTaken;
              itemBays.put(bay, qty - qtyTaken);
            }
          }
        }
      }
    }

    Collections.sort(pickList, new TicketItemSort());

    //for (TicketItem ti : pickList) {
    //  println(ti);
    //}
  }
}

import java.util.Comparator;
class TicketItem implements Comparable<TicketItem> {
  Ticket ticket;
  Item item;
  Bay bay;
  int qtyLeftToPick;
  int qtyTotal;

  String toString() {
    return item.id + ":" + bay.name + ":" + qtyLeftToPick + "\\" + qtyTotal;
  }

  TicketItem(Ticket ticket, Bay bay, Item item, int qty) {
    this.ticket = ticket;
    this.bay = bay;
    this.item = item;
    this.qtyLeftToPick = this.qtyTotal = qty;
  }

  int compareTo(TicketItem item) {
    return bay.name.compareTo(item.bay.name);
  }

  int hashCode() {
    return (bay.name + "_" + item.id).hashCode();
  }
}

class TicketItemSort implements Comparator<TicketItem> {
  int compare(TicketItem a, TicketItem b) {
    return a.compareTo(b);
  }
}
