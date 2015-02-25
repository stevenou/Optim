module Algorithm
  class Ucb
    def choose_variant(optimizable:, category:)
      best = nil
      best_rate = nil
      optimizable.optimizable_variants.each { |variant|
        rate = variant.conversion_rate(category) + self.confidence_interval(optimizable, variant, category)
        if best_rate.nil? or rate > best_rate
          best = variant
          best_rate = rate
        end
      }
      best
    end

    def confidence_interval(optimizable, variant, category)
      # force alt_participant_count to start at 1 to avoid divide by 0 errors
      # force total_participant_count to start at 1 to avoid taking log of 0 errors
      total_participant_count = [optimizable.total_participant_count, 1].max
      variant_participant_count = [variant.participant_count, 1].max
      # scale to 100 to match conversion_rate output
      Math.sqrt(2 * Math.log(total_participant_count) / variant_participant_count) * 100
    end
  end
end