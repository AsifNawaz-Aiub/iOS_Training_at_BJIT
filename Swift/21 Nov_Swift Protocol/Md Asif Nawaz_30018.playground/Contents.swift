import UIKit

// Md Asif Nawaz 30018

// 1
class Plane {
    var name:String
    var manufacturer: String
    
    init(name:String, manufacturer:String) {
        self.name = name
        self.manufacturer = manufacturer
    }
}

protocol AttributesOfFighterJetPlane {
    var airToAirMissileName: String {get set}
    var airToGroundMissleName: String {get set}
}

extension AttributesOfFighterJetPlane {
    func displayWeapons (){
        print("Air to Air Missile  - \(airToAirMissileName) \n")
        print("Air to Ground Missile  - \(airToGroundMissleName)")
    }
    
}

class FighterJet : Plane, AttributesOfFighterJetPlane{
    
    var airToAirMissileName: String
    var airToGroundMissleName: String
    
    func displayFighterJetInformation(){
        print("Fighter Jet Name  - \(super.name) \n")
        print("Manufacturer - \(super.manufacturer) \n")
        displayWeapons()
    }
    
    init(name:String, manufacturer:String, airToAirMissileName:String,airToGroundMissleName: String ){
        self.airToAirMissileName = airToAirMissileName
        self.airToGroundMissleName = airToGroundMissleName
        super.init(name: name, manufacturer: manufacturer)
       
    }

}

protocol AttributesOfAirliner {
    var totalSeats: Int {get set}
    var route: String {get set}
}

extension Airliner {
    func displayAirlinerInformation (){
        print("Airliner Name  - \(name) \n")
        print("Manufacturer - \(manufacturer) \n")
        print("Total Seats  - \(totalSeats) \n")
        print("Route  - \(route)")
    }
}

class Airliner: Plane, AttributesOfAirliner {
    
    var totalSeats: Int
    var route: String
    
    init(name:String, manufacturer:String, totalSeats:Int,route: String ){
        self.totalSeats = totalSeats
        self.route = route
        super.init(name: name, manufacturer: manufacturer)
       
    }
    
}

var aAirliner : Plane  = Airliner(name: "A380", manufacturer: "AirBus", totalSeats: 200, route: "UK - USA")
var aFighterJet: Plane =  FighterJet(name: "F-16c", manufacturer: "Lockheed Martin", airToAirMissileName: "AIM 9", airToGroundMissleName: "Maverick")

var planes : [Plane] = []

planes.append(aAirliner)
planes.append(aFighterJet)


for eachPlane in planes {
    
    if eachPlane is Airliner {
        print("This is an Airliner  ---- \n")
        let airliner = eachPlane as? Airliner
        airliner?.displayAirlinerInformation()
        print("----------------------------\n")
    }
    if eachPlane is FighterJet {
        print("This is an Fighter Jet  ---- \n")
        let fighterJet = eachPlane as? FighterJet
        fighterJet?.displayFighterJetInformation()
        print("----------------------------\n")
    }
}


// 2

protocol Media {
    var name : String {get set}
    func playMedia()
}

class Movie: Media {
    var name: String
    var director: String
    init(name: String, director: String) {
        self.director = director
        self.name =  name
    }
   func playMedia() {
     print("\(name) by \(director) is being played in the media player!")
   }
      
}

class Song: Media {
    
    var name: String
    var artist: String
    
    init(name: String, artist: String) {
        self.artist = artist
        self.name =  name
    }
    
    func playMedia() {
     print("\(name) by \(artist) is being played in the media player!")
    }
      
}

var m1 = Movie(name:"Movie 1", director: "Director 1")
var m2 = Movie(name:"Movie 2", director: "Director 2")
var s1 = Song (name: "Song 1", artist: "Artist 1")
var s2 = Song (name: "Song 2", artist: "Artist 2")

var medias = [Media]()
medias.append(m1)
medias.append(m2)
medias.append(s1)
medias.append(s2)

for eachMedia in medias {

    if eachMedia is Song {
        let newMedia = eachMedia as! Song
        newMedia.playMedia()
    }
    if eachMedia is Movie {
        let newMedia = eachMedia as! Movie
        newMedia.playMedia()
    }
}


// 3

extension Collection {
    func summarize(){
        for (index, value) in self.enumerated(){
            print("\(index + 1). \(value)")
        }
    }
}
let beatles = Set(["John", "Paul", "George", "Ringo"])
beatles.summarize()

let scores = [23, 25, 21, 46, 21, 18]
scores.summarize()
