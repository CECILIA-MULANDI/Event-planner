use option::OptionTrait;
use array::ArrayTrait;
use debug::PrintTrait;
// create a structure for an event
#[derive(Copy,Drop)]
struct Event{
    name:felt252,
    description:felt252,
    date:felt252,
    time:felt252,
    location:felt252,
    ticket_price:u16,
    available_tickets:u16,
}
#[derive(Copy,Drop)]
struct User{
    username:felt252,
    address:felt252,
}
// structure to store array of events
#[derive(Drop)]
struct EventsStore{
    events:Array<Event>,
    users:Array<User>
}
// Event - {name,desc}


trait EventTrait{
    fn purchase_ticket(ref self:Event,price:u16);
}

    
trait EventsStoreTrait{
    fn add_to_store(ref self:EventsStore,event:Event);
    fn add_user(ref self:EventsStore,user:User);
    fn search_user(self:@EventsStore,username:felt252);
    // fn display_events(ref self: EventsStore);
}

impl EventImpl of EventTrait {

   fn purchase_ticket(ref self:Event,price:u16){
    if self.available_tickets>0{
        'sold'.print();
        let mut remaining_tickets=self.available_tickets-1;
        remaining_tickets.print()
    }
    'sold out'.print()
   }

} 

impl EventsStoreImpl of EventsStoreTrait{
    fn add_to_store(ref self:EventsStore,event:Event){
        self.events.append(event);
    }
    // add the user to the database after creation
    fn add_user(ref self:EventsStore,user:User){
        let mut added_user=self.users.append(user);
    }
    fn search_user(self:@EventsStore,username:felt252){
        let mut i =0;
        
        loop {
            let mut found_user:User=*self.users[i];
            if found_user.username==username{
                'user found'.print();
                break;
            }
            i=i+1;
        }
    }
    
}

fn main(){
    // create an instance

    let mut new_event = Event{name:'Starknet hackathon',description:'best event ever ',
    date:'23/10/2023', time:'4pm',location:'Nairobi,Kenya',ticket_price:2,available_tickets:0,};
    new_event.description.print();
    new_event.purchase_ticket(2);

    // add the event created to the array of events

    let mut added_new_data=EventsStore{
        events:ArrayTrait::new(),
        users:ArrayTrait::new(),
    };
    added_new_data.add_to_store(new_event);
    added_new_data.events.len().print();
    // added_event.display_events();

    // create an instance of the user
    let mut new_user = User{username:'Cecilia',address:'0x12345'};
    added_new_data.add_user(new_user);
    added_new_data.search_user('Cecilia');
   
}