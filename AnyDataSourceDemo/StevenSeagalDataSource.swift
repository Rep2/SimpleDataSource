import AnyDataSource

class StevenSeagalMoviesDataSource {
    static let bestMoviesEver = [
        Movie(name: "Above the Law", releaseYear: 1988, actors: [
            Actor(name: "Steven Seagal"),
            Actor(name: "Pam Grier"),
            Actor(name: "Henry Silva")
            ]
        ),
        Movie(name: "Under Siege", releaseYear: 1992, actors: [
            Actor(name: "Steven Seagal"),
            Actor(name: "Gary Busey"),
            Actor(name: "Tommy Lee Jones")
            ]
        ),
        Movie(name: "Under Siege 2: Dark Territory", releaseYear: 1995, actors: [
            Actor(name: "Steven Seagal"),
            Actor(name: "Eric Bogosian"),
            Actor(name: "Everett McGill")
            ]
        ),
        Movie(name: "Black Dawn", releaseYear: 2005, actors: [
            Actor(name: "Steven Seagal"),
            Actor(name: "Tamara Davies"),
            Actor(name: "John Pyper-Ferguson")
            ]
        ),
        Movie(name: "Kill Switch", releaseYear: 2008, actors: [
            Actor(name: "Steven Seagal"),
            Actor(name: "Dan Stevens"),
            Actor(name: "Bérénice Marlohe")
            ]
        ),
        Movie(name: "Machete", releaseYear: 2010, actors: [
            Actor(name: "Steven Seagal"),
            Actor(name: "Danny Trejo"),
            Actor(name: "Michelle Rodriguez"),
            Actor(name: "Robert De Niro")
            ]
        )
    ]

    static let movieTableViewCellModels: [[AnyDequeuableTableViewCellViewModel]] {
        return bestMoviesEver.map {
            return [
                $0.tableViewPresentable,
                $0.actors.flatMap { $0.tableViewPresentable }
            ]
        }
    }
}
