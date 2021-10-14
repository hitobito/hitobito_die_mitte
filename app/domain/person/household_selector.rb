# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

class Person::HouseholdSelector

  def initialize(people)
    @people = people.presence || []
  end
  
  def select(count = 2)
    [
      with_most_used_last_name,
      with_complete_name
    ].find(->{ @people }) { |ordering| ordering.count >= count }.first(count)
  end

  private

  def with_most_used_last_name
    with_complete_name.select{ |member| member.last_name == most_used_last_name }
  end

  def most_used_last_name
    @most_used_last_name ||= last_name_counts.max_by {|_, count| count}.first
  end

  def last_name_counts
    @last_name_counts ||= with_complete_name.each_with_object(Hash.new(0)) do |member, counts|
      counts[member.last_name] += 1
    end
  end

  def with_complete_name
    @with_complete_name ||= @people.select do |member|
      member.first_name.present? && member.last_name.present?
    end
  end
end
