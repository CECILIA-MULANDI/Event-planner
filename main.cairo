// find out how to choose between <org and attendee>
// figure out how access would be granted
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
    usertype:UserType,
    
   
}

// structure to store array of events
#[derive(Drop)]
struct EventsStore{
    events:Array<Event>,
    users:Array<User>
}
#[derive(Copy,Drop)]
enum UserType{
    Organization:(),
    Attendee:(),

}


trait EventTrait{
    fn purchase_ticket(ref self:Event,price:u16);
     fn display_info(ref self: Event);
}


    
trait EventsStoreTrait{
    fn add_to_store(ref self:EventsStore,event:Event);
    fn add_user(ref self:EventsStore,user:User);
    fn search_user(self:@EventsStore,username:felt252);
    fn search_events(self:@EventsStore,name:felt252);
    fn  display_events(self:@EventsStore);
}

impl EventImpl of EventTrait {

   fn purchase_ticket(ref self:Event,price:u16){
    if self.available_tickets>0{
        'sold'.print();
        'access granted'.print();
        let mut remaining_tickets=self.available_tickets-1;
        remaining_tickets.print()
    }
    'sold out'.print()
   }
    fn display_info(ref self: Event){
        self.name.print();
        self.ticket_price.print();
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
                username.print();
                found_user.address.print();
                found_user.usertype.print();
                break;
            }
            i=i+1;
        }
    }
    fn search_events(self:@EventsStore,name:felt252){
        let mut i = 0;
        loop{
            let found_event:Event=*self.events[i];
            if found_event.name==name{
                'event found'.print();
                found_event.name.print();
                break;
            }
            i=i+1;
        }

    }
     fn display_events(self:@EventsStore){
        let len = self.events.len();
        let mut i = 0;

        loop {
            if (i >= len) {
                break;
            }
            let mut event: Event = *self.events[i];
            event.display_info(); // event.ticket_price.print();
            i += 1;
        }
    }
}
    
    

impl ProcessUserTypeImpl of PrintTrait<UserType>{
    fn print(self:UserType){
        match self{
           UserType::Organization(()) => {
            'registered as organization'.print();
                
            },
            UserType::Attendee(()) => {
                'registered as attendee'.print();
                
            },
        }

    }
}
fn main(){
    // create an instance

    let mut new_event = Event{name:'Starknet hackathon',description:'best event ever ',
    date:'23/10/2023', time:'4pm',location:'Nairobi,Kenya',ticket_price:2,available_tickets:0,};
      let mut new_event2 = Event{name:'Cairo hackathon',description:'best event ever ',
    date:'23/10/2023', time:'4pm',location:'Nairobi,Kenya',ticket_price:9,available_tickets:0,};
    new_event.description.print();
    new_event.purchase_ticket(2);

    // add the event created to the array of events

    let mut added_new_data=EventsStore{
        events:ArrayTrait::new(),
        users:ArrayTrait::new(),
    };
    added_new_data.add_to_store(new_event);
     added_new_data.add_to_store(new_event2);
    // added_new_data.events.len().print();
    added_new_data.search_events('Starknet hackathon');

    // create an instance of the user
    let mut new_user = User{username:'Cecilia',address:'0x12345',usertype:UserType::Attendee(())};
    added_new_data.add_user(new_user);
    added_new_data.search_user('Cecilia');
    added_new_data.display_events();
    added_new_data.display_events();
   
}