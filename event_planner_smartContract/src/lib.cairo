#[starknet::contract]

mod EventPlanner{
    
    #[storage]
    struct Storage{
        event:Events
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event{
        EventCreated:EventCreated

    }
     #[derive(Drop, starknet::Event)]
     struct EventCreated{
        message:felt252
     }

    #[derive(Drop, starknet::Store)]
    
    struct Events{
        name:felt252,
        description:felt252,
        date:felt252,
        time:felt252,
        location:felt252,
        ticket_price:u16,
        available_tickets:u16,
    }
    #[external(v0)]
    #[generate_trait]
    impl EventTraitImpl of EventPlanner{
        fn create_event(ref self:ContractState){
            self.event.write(Events{name:'Starknet hackathon',description:'best event ever ',
    date:'23/10/2023', time:'4pm',location:'Nairobi,Kenya',ticket_price:2,available_tickets:0,});
            self.emit(Event::EventCreated(EventCreated{message:'event created'}));
        }
        fn get_event(self:@ContractState){
            self.event.read();
        }
    }
}