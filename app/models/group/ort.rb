
# encoding: utf-8

class Group::Ort < Group

  self.layer = true

  class Leitung < Role
    self.permissions = [:layer_and_below_full, :contact_data]
  end

  roles Leitung

end

