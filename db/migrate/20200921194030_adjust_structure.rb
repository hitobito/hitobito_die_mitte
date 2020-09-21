class AdjustStructure < ActiveRecord::Migration[6.0]
  def change
    layers = %w(Bund Vereinigung Kanton Region Ort)

    # Only adjust existing groups roles based on integration data
    layers.each do |layer, group|
      # 1
      Group.where(type: "Group::#{layer}Vorstand").update_all(type: "Group::#{layer}Parteigremium")
      Role.where(type: "Group::#{layer}Vorstand::Mitglied").update_all(type: "Group::#{layer}Parteigremium::Mitglied")
      # 4
      Group.where(type: "Group::#{layer}Kontakte").update_all(type: "Group::#{layer}ExterneKontakte")
    end
  end
end
