use option::OptionTrait;
use array::ArrayTrait;
use debug::PrintTrait;
// create a structure for an event
#[derive(Drop)]
struct Event{
    name:felt252,
    description:felt252,
    date:felt252,
    time:felt252,
    location:felt252,
    ticket_price:u16,
}
// structure to store array of events
#[derive(Drop)]
struct EventsStore{
    events:Array<Event>
}
// Event - {name,desc}

// function to create an event
trait EventTrait{
    fn create_function(ref self:Event, name:felt252,
    description:felt252,
    date:felt252,
    time:felt252,
    location:felt252,
    ticket_price:u16);
    }
trait EventsStoreTrait{
    fn add_to_store(ref self:EventsStore,event:Event);
    fn display_events(ref self: EventsStore);
}

impl EventImpl of EventTrait {
   fn create_function(ref self:Event, name:felt252,description:felt252,date:felt252,time:felt252, location:felt252,ticket_price:u16){
    self.name=name;
    self.description=description;
    self.date=date;
    self.time=time;
    self.location=location;
    self.ticket_price=ticket_price;

 }
} 

impl EventsStoreImpl of EventsStoreTrait{
    fn add_to_store(ref self:EventsStore,event:Event){
        self.events.append(event);
    }
     fn display_events(ref self: EventsStore){
        // loop through each event
        let event_in_array=self.events.len();
        let mut i = 0;
        
        loop{
            if i==event_in_array{
                break;
            }
            *self.events.at(i).ticket_price.print();
            i=i+1;
        };
     }
   
}
fn main(){
    // create an instance

    let mut new_event = Event{name:'Starknet hackathon',description:'best event ever ',
    date:'23/10/2023', time:'4pm',location:'Nairobi,Kenya',ticket_price:2};
    new_event.description.print();

    // add the event created to the array of events

    let mut added_event=EventsStore{
        events:ArrayTrait::new()
    };
    added_event.add_to_store(new_event);
    added_event.events.len().print();
    added_event.display_events();
   
}