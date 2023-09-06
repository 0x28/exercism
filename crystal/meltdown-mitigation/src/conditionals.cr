class Reactor
  def self.is_criticality_balanced?(temperature, neutrons_emitted)
    temperature < 800 &&
      neutrons_emitted > 500 &&
      temperature * neutrons_emitted < 500_500
  end

  def self.reactor_efficiency(voltage, current, theoretical_max_power)
    generated_power = voltage * current
    efficiency = (generated_power / theoretical_max_power) * 100

    if efficiency >= 80
      "green"
    elsif efficiency >= 60
      "orange"
    elsif efficiency >= 30
      "red"
    else
      "black"
    end
  end

  def self.fail_safe(temperature, neutrons_produced_per_second, threshold)
    value = temperature * neutrons_produced_per_second

    if value < 0.9 * threshold
      "LOW"
    elsif value <= 1.1 * threshold
      "NORMAL"
    else
      "DANGER"
    end
  end
end
