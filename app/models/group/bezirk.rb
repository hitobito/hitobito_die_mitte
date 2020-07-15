
# encoding: utf-8

class Group::Bezirk < Group

  self.layer = true

  children Group::Ort

  class Leitung < Role
    self.permissions = [:layer_and_below_full, :contact_data]
  end

  roles Leitung

end

