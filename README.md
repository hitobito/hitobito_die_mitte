# Hitobito Cvp

This hitobito wagon defines the organization hierarchy with groups and roles
of Cvp.

[![Build
Status](https://travis-ci.org/hitobito/hitobito_cvp.svg)](https://travis-ci.org/hitobito/hitobito_cvp)


## Organization Hierarchy

    * Bund
      * Gewählte
        * Bundesrat: []
        * Ständerat: []
        * Nationalrat: []
        * Bundesrichter (Vollamt): []
        * Bundesrichter (Nebenamt): []
        * Bundesverwaltungsrichter: []
        * Bundespatentrichter: []
        * Bundesstrafrichter: []
      * Vorstand
        * Mitglied: []
      * Praesidium
        * Präsident: []
        * Vizepräsident: []
        * Mitglied: []
        * Gast: []
      * Sekretariat
        * Generalsekretär: [:layer_and_below_full, :contact_data]
        * Mitarbeiter: [:layer_and_below_full, :contact_data]
        * It-Support: [:impersonation]
        * Kassier: [:finance]
      * Kommission
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Parteigremium
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
      * Delegierte
        * Delegierte: []
        * Ersatzdelegierte: []
    * Kanton
      * Gewählte
        * Kantonale Exekutive: []
        * Kantonale Legislative: []
        * Mitglied kantonales Gericht obere Instanz: []
        * Mitglied kantonales Gericht erste Instanz: []
        * Staatsanwaltschaft: []
        * Parlamentarische Geschaeftsfuehrung: []
        * Fraktionschef: []
      * Vorstand
        * Mitglied: []
        * Kassier: [:finance]
      * Praesidium
        * Präsident: [:contact_data]
        * Vizepräsident: []
        * Mitglied: []
      * Sekretariat
        * Leitung: [:layer_and_below_full, :finance, :contact_data]
        * Mitarbeiter: [:layer_and_below_full]
      * Kommission
        * Präsident: []
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Parteigremium
        * Leitung: [:group_full]
        * Mitglied: [:group_read]
      * Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
      * Delegierte
        * Delegierte: []
        * Ersatzdelegierte: []
      * Mitglieder
        * Mitglied: []
        * Sympathisant nach kant. Statut: []
      * Sympathisanten
        * Sympathisant: []
    * Region
      * Vorstand
        * Mitglied: []
        * Kassier: [:finance]
      * Praesidium
        * Präsident: []
        * Vizepräsident: []
        * Kassier: [:finance]
        * Mitglied: []
      * Sekretariat
        * Leitung: [:layer_and_below_full]
        * Mitarbeiter: [:layer_and_below_full]
      * Parteigremium
        * Leitung: []
        * Mitglied: []
    * Ortspartei
      * Gewählte
        * Fraktionschef: []
        * Kommunale Exekutive: []
        * Kommunale Legislative: []
        * Schulpflege/- kommission: []
        * Rechnungsprüfungskommission: []
        * Mitglied weitere Kommissionen: []
      * Vorstand
        * Mitglied: []
        * Kassier: [:finance]
      * Praesidium
        * Präsident: [:contact_data]
        * Vizepräsident: []
        * Kassier: [:finance]
        * Mitglied: []
        * Gast: []
      * Sekretariat
        * Leitung: [:layer_full]
        * Mitarbeiter: [:layer_full]
      * Kommission
        * Präsident: []
        * Mitglied: []
      * Parteigremium
        * Leitung: []
        * Mitglied: []
      * Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
      * Mitglieder
        * Mitglied: []
        * Sympathisant nach kant. Statut: []
      * Sympathisanten
        * Sympathisant: []
    * Vereinigung
      * Gewählte
        * Fraktionschef: []
        * Vereinigung Exekutive: []
        * Rolle: []
      * Vorstand
        * Mitglied: []
        * Kassier: [:finance]
      * Praesidium
        * Präsident: [:contact_data]
        * Vizepräsident: []
        * Kassier: [:finance]
        * Mitglied: []
      * Sekretariat
        * Leitung: [:layer_and_below_full, :contact_data, :finance]
        * Mitarbeiter: [:layer_and_below_full]
      * Kommission
        * Präsident: []
        * Mitglied: []
      * Parteigremium
        * Leitung: []
        * Mitglied: []
      * Kontakte
        * Medien: []
        * Spender: []
        * Kontakt: []
