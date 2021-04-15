# Hitobito Die Mitte

This hitobito wagon defines the organization hierarchy with groups and roles of Die Mitte.

[![Build
Status](https://travis-ci.org/hitobito/hitobito_die_mitte.svg)](https://travis-ci.org/hitobito/hitobito_die_mitte)


## Organization Hierarchy

    * Schweiz
      * Gewählte
        * Bundesrat: []
        * Bundeskanzler: []
        * Ständerat: []
        * Nationalrat: []
        * Bundesrichter (Vollamt): []
        * Bundesrichter (Nebenamt): []
        * Bundesverwaltungsrichter: []
        * Bundespatentrichter: []
        * Bundesstrafrichter: []
      * Parteigremium
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * PräsidentIn: [:layer_and_below_full, :contact_data, :finance]
        * VizepräsidentIn: []
        * Mitglied: []
        * Gast: []
      * Sekretariat
        * Leitung: [:layer_and_below_full, :contact_data, :admin]
        * MitarbeiterIn: [:layer_and_below_full, :contact_data, :admin]
        * It-Support: [:impersonation]
        * KassierIn: [:finance]
        * WebadministratorIn: []
      * Kommission
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Arbeitsgruppe
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * SpenderIn: []
        * Kontakt: []
      * Delegierte
        * DelegierteR: []
        * ErsatzdelegierteR: []
        * DelegierteR von Amtes wegen: []
      * Mitglieder
        * Mitglied: []
      * Sympathisanten
        * SympathisantIn: []
    * Kanton
      * Gewählte
        * Kantonale Exekutive: []
        * Kantonale Legislative: []
        * Mitglied kantonales Gericht erste Instanz: []
        * Mitglied kantonales Gericht zweite Instanz: []
        * Staatsanwaltschaft: []
        * Parlamentarische Geschaeftsfuehrung: []
        * FraktionschefIn: []
        * Weitere Mandate: []
      * Parteigremium
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * PräsidentIn: [:layer_and_below_full, :contact_data, :finance]
        * VizepräsidentIn: []
        * Mitglied: []
        * Gast: []
        * KassierIn: [:finance]
      * Sekretariat
        * Leitung: [:layer_and_below_full, :finance, :contact_data]
        * MitarbeiterIn: [:layer_and_below_full]
        * WebadministratorIn: []
      * Kommission
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Arbeitsgruppe
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * SpenderIn: []
        * Kontakt: []
      * Delegierte
        * DelegierteR: []
        * ErsatzdelegierteR: []
        * DelegierteR von Amtes wegen: []
      * Mitglieder
        * Mitglied: []
      * Sympathisanten
        * SympathisantIn: []
    * Region
      * Gewählte
        * FraktionschefIn: []
        * Region Exekutive: []
        * Region Legislative: []
        * Region Judikative: []
      * Parteigremium
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * PräsidentIn: [:layer_and_below_full, :contact_data, :finance]
        * VizepräsidentIn: []
        * KassierIn: [:finance]
        * Mitglied: []
      * Sekretariat
        * Leitung: [:layer_and_below_full]
        * MitarbeiterIn: [:layer_and_below_full]
        * WebadministratorIn: []
      * Arbeitsgruppe
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Delegierte
        * DelegierteR: []
        * ErsatzdelegierteR: []
      * Mitglieder
        * Mitglieder: []
      * Sympathisanten
        * SympathisantIn: []
      * Externe Kontakte
        * Medien: []
        * SpenderIn: []
        * Kontakt: []
    * Ortspartei
      * Gewählte
        * FraktionschefIn: []
        * Kommunale Exekutive: []
        * Kommunale Legislative: []
        * Schulpflege/- kommission: []
        * Rechnungsprüfungskommission: []
        * Mitglied weitere Gemeindekommissionen: []
      * Parteigremium
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * PräsidentIn: [:layer_and_below_full, :contact_data, :finance]
        * VizepräsidentIn: []
        * KassierIn: [:finance]
        * Mitglied: []
        * AdressverwalterIn: [:layer_and_below_full]
        * Gast: []
      * Sekretariat
        * Leitung: [:layer_full]
        * MitarbeiterIn: [:layer_full]
        * WebadministratorIn: []
      * Arbeitsgruppe
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * SpenderIn: []
        * Kontakt: []
      * Mitglieder
        * Mitglied: []
      * Sympathisanten
        * SympathisantIn: []
    * Vereinigung
      * Gewählte
        * FraktionschefIn: []
        * Vereinigung Exekutive: []
        * Vereinigung Legislative: []
      * Parteigremium
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * PräsidentIn: [:layer_and_below_full, :contact_data, :finance]
        * VizepräsidentIn: []
        * KassierIn: [:finance]
        * Mitglied: []
      * Sekretariat
        * Leitung: [:layer_and_below_full, :contact_data, :finance]
        * MitarbeiterIn: [:layer_and_below_full]
        * WebadministratorIn: []
      * Kommission
        * PräsidentIn: []
        * Mitglied: []
      * Arbeitsgruppe
        * PräsidentIn: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * SpenderIn: []
        * Kontakt: []
      * Mitglieder
        * Mitglieder: []
      * Sympathisanten
        * SympathisantIn: []
      * Delegierte
        * DelegierteR: []
        * ErsatzdelegierteR: []
        * DelegierteR von Amtes wegen: []
