space_age(Planet, AgeSec, Years) :-
    orbital_factor(Planet, Factor),
    Years is (AgeSec / 31557600) / Factor.

orbital_factor("Mercury", 0.2408467).
orbital_factor("Venus",   0.61519726).
orbital_factor("Earth",   1.0).
orbital_factor("Mars",    1.8808158).
orbital_factor("Jupiter", 11.862615).
orbital_factor("Saturn",  29.447498).
orbital_factor("Uranus",  84.016846).
orbital_factor("Neptune", 164.79132).
