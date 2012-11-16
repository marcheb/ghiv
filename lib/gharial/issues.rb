module Gharial
  class Issues < Base

    def self.fields
      ['url', 'html_url', 'number', 'state', 'title', 'body']
    end

    def self.labels(labels=[])
      records = Gharial::Transceiver.new("#{GH_URL}/issues?labels=#{labels.join(',')}", ssl: true).get
      records.map { |r| self.new(r) }
    end
  end
end
