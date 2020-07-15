# encoding: utf-8

class Group::Kanton < Group

  self.layer = true

  children Group::Bezirk

  class Leitung < Role
    self.permissions = [:layer_and_below_full, :contact_data]
  end

  roles Leitung
end

