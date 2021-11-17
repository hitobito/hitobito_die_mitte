# frozen_string_literal: true

#  Copyright (c) 2021, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

module DieMitte::MessagesController
  extend ActiveSupport::Concern

  def show
    respond_to do |format|
      format.csv { render_tabular_in_background(:csv) }
    end
  rescue ActionController::UnknownFormat
    super
  end

  private

  def render_tabular_in_background(format)
    render_in_background(format, entry.subject.parameterize)
  end
end
