# encoding: utf-8

namespace :app do
  namespace :license do
    task :config do
      @licenser = Licenser.new('hitobito_cvp',
                               'CVP Schweiz',
                               'https://github.com/hitobito/hitobito_cvp')
    end
  end
end
