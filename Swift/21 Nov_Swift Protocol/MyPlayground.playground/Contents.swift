import UIKit

class Media {
    var name:String
    
    init(name:String) {
        self.name = name
    }
}

class Song: Media {
    var artist:String
    init(name: String, artist:String) {
        self.artist = artist
        super.init(name:name)
    }
    
}
class Movie : Media{
    var director:String
    init(name: String, director:String) {
        self.director = director
        super.init(name:name)
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
        let newMedia = eachMedia as? Song
        
        if let songName = newMedia?.name, let songArtist = newMedia?.artist {
            print("Song Name - \(songName)")
            print("Director - \(songArtist)")
        }
    }
    if eachMedia is Movie {
        let newMedia = eachMedia as! Movie
        print("Movie Name - \(newMedia.name)")
        print("Movie Director - \(newMedia.director)")
    }
}

//let newMedia = eachMedia as! Song
//print("Name - \(newMedia.name)")
//print("Artist - \(newMedia.artist)")
