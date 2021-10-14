# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte Schweiz. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::Person::Address

  private

  def combine_household_names(members)
    two_with_same_last_name(members) ||
        two_with_complete_name(members) ||
        any_two(members)
  end

  def two_with_same_last_name(members)
    members = members.select { |member| member.first_name.present? && member.last_name.present? }

    last_name_counts = members.each_with_object(Hash.new(0)) do |member, counts|
      counts[member.last_name] += 1
    end

    most_used, count = last_name_counts.max_by {|_, count| count}
    return nil unless count >= 2

    selected = members.select{ |member| member.last_name == most_used }

    I18n.t('people.address.two_with_same_last_name',
           first: selected.first.first_name,
           second: selected.second.first_name,
           last_name: most_used)
  end

  def two_with_complete_name(members)
    members = members.select { |member| member.first_name.present? && member.last_name.present? }
    return nil unless members.count >= 2

    members.first(2).map(&:full_name).join("\n")
  end

  def any_two(members)
    members.first(2).map(&:full_name).join("\n")
  end
end
