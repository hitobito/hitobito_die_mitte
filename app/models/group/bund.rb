# encoding: utf-8

class Group::Bund < Group

  self.layer = true

  children Group::Kanton, Group::Vereinigung

  ### ROLES

  class Leitung < Role
    self.permissions = [:layer_and_below_full, :admin, :impersonation]
  end

  class Mitglied < Role
    self.permissions = [:group_read]
  end

  roles Leitung, Mitglied

end
