datatype planet = Mercury | Venus | Earth | Mars
                  | Jupiter | Saturn | Uranus | Neptune

fun planet_factor Mercury = 0.2408467
  | planet_factor Venus   = 0.61519726
  | planet_factor Earth   = 1.0
  | planet_factor Mars    = 1.8808158
  | planet_factor Jupiter = 11.862615
  | planet_factor Saturn  = 29.447498
  | planet_factor Uranus  = 84.016846
  | planet_factor Neptune = 164.79132

fun age_on planet seconds =
    Real.fromInt(seconds) / 31557600.0 / planet_factor planet
