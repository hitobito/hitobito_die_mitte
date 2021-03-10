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
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * Präsident: []
        * Vizepräsident: []
        * Mitglied: []
        * Gast: []
      * Sekretariat
        * Leitung: [:layer_and_below_full, :contact_data, :admin]
        * Mitarbeiter: [:layer_and_below_full, :contact_data, :admin]
        * It-Support: [:impersonation]
        * Kassier: [:finance]
        * Webadministrator: []
      * Kommission
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Arbeitsgruppe
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
      * Delegierte
        * Delegierte: []
        * Ersatzdelegierte: []
        * Delegierte von Amtes wegen: []
      * Mitglieder
        * Mitglied: []
      * Sympathisanten
        * Sympathisant: []
    * Kanton
      * Gewählte
        * Kantonale Exekutive: []
        * Kantonale Legislative: []
        * Mitglied kantonales Gericht erste Instanz: []
        * Mitglied kantonales Gericht zweite Instanz: []
        * Staatsanwaltschaft: []
        * Parlamentarische Geschaeftsfuehrung: []
        * Fraktionschef: []
        * Weitere Mandate: []
      * Parteigremium
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * Präsident: [:contact_data]
        * Vizepräsident: []
        * Mitglied: []
        * Gast: []
        * Kassier: [:finance]
      * Sekretariat
        * Leitung: [:layer_and_below_full, :finance, :contact_data]
        * Mitarbeiter: [:layer_and_below_full]
        * Webadministrator: []
      * Kommission
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Arbeitsgruppe
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
      * Delegierte
        * Delegierte: []
        * Ersatzdelegierte: []
        * Delegierte von Amtes wegen: []
      * Mitglieder
        * Mitglied: []
      * Sympathisanten
        * Sympathisant: []
    * Region
      * Parteigremium
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * Präsident: []
        * Vizepräsident: []
        * Kassier: [:finance]
        * Mitglied: []
      * Sekretariat
        * Leitung: [:layer_and_below_full]
        * Mitarbeiter: [:layer_and_below_full]
        * Webadministrator: []
      * Arbeitsgruppe
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Delegierte
        * Delegierte: []
        * Ersatzdelegierte: []
      * Mitglieder
        * Mitglieder: []
      * Sympathisanten
        * Sympathisant: []
      * Externe Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
    * Ortspartei
      * Gewählte
        * Fraktionschef: []
        * Kommunale Exekutive: []
        * Kommunale Legislative: []
        * Schulpflege/- kommission: []
        * Rechnungsprüfungskommission: []
        * Mitglied weitere Gemeindekommissionen: []
      * Parteigremium
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * Präsident: [:contact_data]
        * Vizepräsident: []
        * Kassier: [:finance]
        * Mitglied: []
        * Adressverwalter: [:layer_and_below_full]
        * Gast: []
      * Sekretariat
        * Leitung: [:layer_full]
        * Mitarbeiter: [:layer_full]
        * Webadministrator: []
      * Arbeitsgruppe
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
      * Mitglieder
        * Mitglied: []
      * Sympathisanten
        * Sympathisant: []
    * Vereinigung
      * Parteigremium
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Praesidium
        * Präsident: [:contact_data]
        * Vizepräsident: []
        * Kassier: [:finance]
        * Mitglied: []
      * Sekretariat
        * Leitung: [:layer_and_below_full, :contact_data, :finance]
        * Mitarbeiter: [:layer_and_below_full]
        * Webadministrator: []
      * Kommission
        * Präsident: []
        * Mitglied: []
      * Arbeitsgruppe
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
        * Gast: []
      * Externe Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
      * Mitglieder
        * Mitglieder: []
      * Sympathisanten
        * Sympathisant: []
      * Delegierte
        * Delegierte: []
        * Ersatzdelegierte: []
        * Delegierte von Amtes wegen: []
