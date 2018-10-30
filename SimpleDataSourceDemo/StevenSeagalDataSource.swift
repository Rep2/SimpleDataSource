import SimpleDataSource

class BestMoviesEverDataSource {
    static let movies = [
        MovieViewModel(name: "Above the Law", releaseYear: 1988, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Pam Grier"),
            ActorViewModel(name: "Henry Silva")
            ]
        ),
        MovieViewModel(name: "Under Siege", releaseYear: 1992, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Gary Busey"),
            ActorViewModel(name: "Tommy Lee Jones")
            ]
        ),
        MovieViewModel(name: "Under Siege 2: Dark Territory", releaseYear: 1995, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Eric Bogosian"),
            ActorViewModel(name: "Everett McGill")
            ]
        ),
        MovieViewModel(name: "Black Dawn", releaseYear: 2005, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Tamara Davies"),
            ActorViewModel(name: "John Pyper-Ferguson")
            ]
        ),
        MovieViewModel(name: "Kill Switch", releaseYear: 2008, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Dan Stevens"),
            ActorViewModel(name: "Bérénice Marlohe")
            ]
        ),
        MovieViewModel(name: "Machete", releaseYear: 2010, actors: [
            ActorViewModel(name: "Steven Seagal"),
            ActorViewModel(name: "Danny Trejo"),
            ActorViewModel(name: "Michelle Rodriguez"),
            ActorViewModel(name: "Robert De Niro")
            ]
        )
    ]
}
