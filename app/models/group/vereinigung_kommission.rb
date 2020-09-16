# encoding: utf-8

#  Copyright (c) 2012-2020, CVP Schweiz. This file is part of
#  hitobito_cvp and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_cvp.

class Group::VereinigungKommission < Group

  class Praesident < Role
    self.permissions = []
  end

  class Mitglied < Role
    self.permissions = []
  end

  roles Praesident, Mitglied

  children Group::VereinigungKommission
end
