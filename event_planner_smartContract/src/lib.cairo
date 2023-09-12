#[starknet::contract]

mod EventPlanner{
    
    #[storage]
    struct Storage{
        event:Event
    }

    #[derive(Drop, starknet::Store)]
    struct Event{
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
            self.event.write(Event{name:'Starknet hackathon',description:'best event ever ',
    date:'23/10/2023', time:'4pm',location:'Nairobi,Kenya',ticket_price:2,available_tickets:0,})
        }
        fn get_event(self:@ContractState){
            self.event.read()
        }
    }
}