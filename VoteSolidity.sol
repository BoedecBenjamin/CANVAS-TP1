pragma solidity ^0.4.0;
contract Vote {
    bool End =false;
    
    struct Votant{
        string nom;
        address Id;
        bool voted;
    }

    
    struct Candidature{
        bytes32 proposition;
        uint8  NbVote;
    }
    
    Candidature[] Propositions;
    Votant[] newvotants;
    address public Admin;
    

    function Vote(bytes32[] Desc_Projets)
    {
        
        // Initialise Admin à la personne accedant au constructeur
        Admin = msg.sender;
        
        
        for (uint i = 0; i < Desc_Projets.length; i++) 
        {
            // On remplit les candidature
            Propositions.push(Candidature({
                proposition : Desc_Projets[i],
                NbVote : 0
            }));
        }
        
    }
    
    function AjoutVotant(string name){
        if(End){throw;}
        for(uint8 i=0;i<newvotants.length; i++)
        {
            if (newvotants[i].Id == msg.sender)
            {
                throw;
            }
        }
        newvotants.push(Votant({
        nom : name,
        Id : msg.sender,
        voted : false
            }));
        
        
    }
    
    function ToVote(uint8 Choice){
        if(End){throw;}
        uint8 k;
        k=0;
          for(uint8 i=0;i<newvotants.length; i++)
        {
            if (newvotants[i].Id == msg.sender)
            {
                k=i+1;
            }
        }
        
        
        
        if(msg.sender == Admin ||  k == 0 || newvotants[k-1].voted )
        {
            throw;
        }
        else{
            Propositions[Choice].NbVote +=1; 
        }
    }
    
    
    function winner()
     returns (bytes32 winnerName)
    {
        
        for (uint i = 0; i < Propositions.length; i++) 
        {
            if(Propositions[i].NbVote >= 10000){
                winnerName = Propositions[i].proposition;
                End=true;
            }
        }
    }
    
    
    
}