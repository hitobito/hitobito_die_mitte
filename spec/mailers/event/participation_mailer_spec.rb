# frozen_string_literal: true

#  Copyright (c) 2025, Die Mitte. This file is part of
#  hitobito_die_mitte and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_die_mitte.

require "spec_helper"

describe Event::ParticipationMailer do
  before do
    SeedFu.quiet = true
    SeedFu.seed [Rails.root.join("db", "seeds")]
  end

  let(:person) { people(:admin) }
  let(:event) { Fabricate(:event) }
  let(:participation) { Fabricate(:event_participation, event: event, person: person) }
  let(:mail) { Event::ParticipationMailer.confirmation(participation) }

  before do
    ["event_application_confirmation", "event_application_notification", "event_application_approval", "event_cancel_application"].each do |key|
      CustomContent.find_by(key: key)
        .translations
        .where(locale: "fr")
        .first
        .update!(subject: "Das französische Subjekt")
    end
  end

  subject { mail.parts.first.body }

  describe "#confirmation" do
    it "uses persons correspondence_language as locale when sending email" do
      participation.update!(active: true)
      person.update!(correspondence_language: :fr)
      expect(mail.subject).to eq "Das französische Subjekt"
    end

    it "uses current locale as fallback when person correspondence_language returns nil" do
      participation.update!(active: true)
      allow(person).to receive(:correspondence_language).and_return(nil)
      expect(mail.subject).to eq "Bestätigung der Anmeldung"
    end
  end

  describe "#notify_contact" do
    let(:recipient) { people(:sekretaer) }
    let(:mail) { Event::ParticipationMailer.notify_contact(participation, recipient) }

    subject { mail.body }

    it "uses persons correspondence_language as locale when sending email" do
      person.update!(correspondence_language: :fr)
      expect(mail.subject).to eq "Das französische Subjekt"
    end

    it "uses current locale as fallback when person correspondence_language returns nil" do
      allow(person).to receive(:correspondence_language).and_return(nil)
      expect(mail.subject).to eq "Anlass: Teilnehmer-/in hat sich angemeldet"
    end
  end

  describe "#approval" do
    subject { mail.body }

    let(:approvers) do
      [Fabricate(:person, email: "approver0@example.com", first_name: "firsty"),
        Fabricate(:person, email: "approver1@example.com", first_name: "lasty")]
    end
    let(:mail) { Event::ParticipationMailer.approval(participation, approvers) }

    it "uses persons correspondence_language as locale when sending email" do
      person.update!(correspondence_language: :fr)
      expect(mail.subject).to eq "Das französische Subjekt"
    end

    it "uses current locale as fallback when person correspondence_language returns nil" do
      allow(person).to receive(:correspondence_language).and_return(nil)
      expect(mail.subject).to eq "Freigabe einer Kursanmeldung"
    end
  end

  describe "#cancel" do
    let(:mail) { Event::ParticipationMailer.cancel(event, person) }

    subject { mail.body }

    it "uses persons correspondence_language as locale when sending email" do
      person.update!(correspondence_language: :fr)
      expect(mail.subject).to eq "Das französische Subjekt"
    end

    it "uses current locale as fallback when person correspondence_language returns nil" do
      allow(person).to receive(:correspondence_language).and_return(nil)
      expect(mail.subject).to eq "Bestätigung der Abmeldung"
    end
  end
end
