# encoding: utf-8

class Group::Vereinigung < Group

  self.layer = true

  children Group::Kanton

  ### ROLES

  class Leitung < Role
    self.permissions = [:layer_and_below_full, :admin]
  end

  class Mitglied < Role
    self.permissions = [:group_read]
  end

  roles Leitung, Mitglied

end
