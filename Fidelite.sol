pragma solidity ^0.4.0;
contract PtsFidelite {
    
    struct Client{      // Structure comprenant le nom l'adresse et le  nombre de point d'un client
        string nom;
        address Id;
        uint Points;
    }

    
    Client[] clients;   // Liste des clients
        
    function AjoutClient(string _name)      // Ajout d'un client s'il n est pas dans la liste
    {
        for(uint8 i=0;i<clients.length; i++){   
            if (clients[i].Id == msg.sender){   // recherche du client dans la liste
                throw;                          // Si on le trouve on quitte la fonction
            }
        }
        
        clients.push(Client({                   // Sinon une fois que toute la liste est parcourue on l'ajoute a la fin
        nom : _name,
        Id : msg.sender,
        Points : 0
            }));
    }
    
    
    function AjoutPoints(uint _PrixAchat)
    {
        Client ActualClient;
        for(uint8 i=0;i<clients.length; i++){   //Recherche du client dans la liste
            if (clients[i].Id == msg.sender){
                ActualClient = clients[i];
                ActualClient.Points = _PrixAchat*100;   // on lui ajoute le nombre de points
                throw;                                  // Une fois fait on sort de la fonction
            }
        }
        
    }
    
    function Transfer(uint _NbPoints, address _Dest,string _NameDest) 
    {
        Client ActualClient;
        AjoutClient(_NameDest);                 // Ajout du destinataire
        for(uint i=0;i<clients.length;i++){     // Recherche de l'utilisateur qui donne ses points
          if(clients[i].Id == msg.sender){
                ActualClient = clients[i];      // Memorise le client qui donne des points
                break;                          // Sort de la boucle lorsqu'on l'a trouvé
              }
        }
        if (ActualClient.Points < _NbPoints){   // Verifie que le donneur a assez de points pour ce transfert
            throw;
        }
        else{
            for(uint j =0; j<clients.length;j++){
                 if(clients[j].Id == _Dest && ActualClient.Points >= _NbPoints) {  // On trouve le receveur
                    ActualClient.Points -= _NbPoints;               // Debite le donneur
                    clients[j].Points += _NbPoints;                 // Credite le receveur
                    throw;                                          // Quitte la fonction
                }
            }
        }
    }   
  
        
        
    
    
    function DepensePoints(uint _Nbpoints)    // Depense les points du client mais c est au caissier de faire la remise
    {
        Client ActualClient;
        for(uint8 i=0;i<clients.length; i++){
            if (clients[i].Id == msg.sender && clients[i].Points >= _Nbpoints ){
                ActualClient = clients[i];
                ActualClient.Points -= _Nbpoints;
                throw;
            }
        }
        
    }
    