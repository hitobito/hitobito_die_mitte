# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.

class Group::KantonKommission < Group::Simple

  class Praesident < Role
    self.permissions = []
  end

  class Leitung < Simple::Leitung
  end

  class Mitglied < Simple::Mitglied
  end

  roles Praesident, Leitung, Mitglied

  children Group::KantonKommission
end
