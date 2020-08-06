# Hitobito Cvp

This hitobito wagon defines the organization hierarchy with groups and roles
of Cvp.

[![Build
Status](https://travis-ci.org/hitobito/hitobito_cvp.svg)](https://travis-ci.org/hitobito/hitobito_cvp)



## Organization Hierarchy


    * Bund
      * Bund
        * Leitung: [:layer_and_below_full, :admin, :impersonation, :finance]
        * Mitglied: [:group_read]
    * Kanton
      * Kanton
        * Leitung: [:layer_and_below_full, :contact_data]
    * Bezirk
      * Bezirk
        * Rolle: [:layer_and_below_full, :contact_data]
    * Ort
      * Ort
        * Leitung: [:layer_and_below_full, :contact_data]
    * Vereinigung
      * Vereinigung
        * Leitung: [:layer_and_below_full, :admin]
        * Mitglied: [:group_read]
