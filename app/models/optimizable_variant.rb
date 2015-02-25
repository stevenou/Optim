class OptimizableVariant < ActiveRecord::Base
  def self.policy_class
    OptimizablePolicy
  end
  
  belongs_to :optimizable
  delegate :optimizable_class, :to => :optimizable, :allow_nil => true
  delegate :project, :to => :optimizable, :allow_nil => true
  delegate :company, :to => :optimizable, :allow_nil => true
  counter_culture [:optimizable, :optimizable_class, :project]
  counter_culture [:optimizable, :optimizable_class]
  counter_culture [:optimizable]

  validates_uniqueness_of :url, :scope => :optimizable_id, :case_sensitive => false
  validates_presence_of :optimizable, :url

  def convert(category:, do_not_track: false)
    unless do_not_track
      self.increment_conversions(category)
    end
  end

  def increment_participants

  end

  def increment_conversions(category)

  end

  def participant_count

  end
  memoize :participant_count

  def conversion_count(category)

  end
  memoize :conversion_count

  def conversion_rate(category)
    pcount = participant_count
    ccount = conversion_count(category)
    (pcount == 0 or ccount == 0) ? 0 : (ccount.to_f / pcount.to_f * 100.0)
  end
  memoize :conversion_rate

  def lower_confidence_bound(category)
    conversion_rate(category) - confidence_interval(category)
  end

  def upper_confidence_bound(category)
    conversion_rate(category) + confidence_interval(category)
  end

  def standard_error(category)
    p = self.conversion_rate(category)/100.0
    n = self.participant_count

    if n > 0
      return Math.sqrt((p * [(1-p), 0].max) / n)*100.0
    else
      return 0
    end
  end

  def confidence_interval(category)
    self.standard_error(category) * 1.96
  end

  def significance(category)
    best = self.optimizable.best_variant(category)
    p_1 = best.conversion_rate(category)/100.0
    p_2 = self.conversion_rate(category)/100.0
    se_1 = best.standard_error(category)/100.0
    se_2 = self.standard_error(category)/100.0

    z_score = (p_2-p_1)/(Math.sqrt(se_1**2 + se_2**2))
    if (Math.sqrt(se_1**2 + se_2**2)) == 0 || z_score > 6
      return 0
    else
      return (1-poz(z_score.abs))*100
    end
  end

  def poz(z)
    if (z == 0.0)
        x = 0.0
        else
        y = 0.5 * z.abs
        if (y > (6 * 0.5))
            x = 1.0
            elsif (y < 1.0)
            w = y * y
            x = ((((((((0.000124818987 * w
                        - 0.001075204047) * w + 0.005198775019) * w
                      - 0.019198292004) * w + 0.059054035642) * w
                    - 0.151968751364) * w + 0.319152932694) * w
                  - 0.531923007300) * w + 0.797884560593) * y * 2.0
                  else
                  y -= 2.0
                  x = (((((((((((((-0.000045255659 * y
                                   + 0.000152529290) * y - 0.000019538132) * y
                                 - 0.000676904986) * y + 0.001390604284) * y
                               - 0.000794620820) * y - 0.002034254874) * y
                             + 0.006549791214) * y - 0.010557625006) * y
                           + 0.011630447319) * y - 0.009279453341) * y
                         + 0.005353579108) * y - 0.002141268741) * y
                       + 0.000535310849) * y + 0.999936657524
        end
    end
    return z > 0.0 ? ((x + 1.0) * 0.5) : ((1.0 - x) * 0.5)
  end
end
