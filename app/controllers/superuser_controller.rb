class SuperuserController < ApplicationController
  def index
  end

  def patients
    patients = {}
    encounter_types = get_encounter_types
    get_patients(encounter_types).each do |patient|
      uuid = patient['uuid']
      if !patients[uuid]
        patients[uuid] = {
          :name => patient['display'],
          :stages => []
        }
        stages = patients[uuid][:stages]
        patient['encounters'].each do |encounter|
          stages << {
            :name => encounter_types[encounter['encounterType']],
            :start => parse_date_time(encounter['encounterDatetime'])
          }
        end
        stages.sort! {|s1, s2| s1[:start] <=> s2[:start]}
        puts stages.inspect

        (0..stages.length-2).each do |i|
          stages[i][:end] = stages[i+1][:start]
        end
        stages[-1][:end] = nil
      end
    end

    render :json => patients
  end

  protected
  def parse_date_time(datetime)
    return Chronic::parse(datetime.gsub(/T/, ' ').gsub(/\..*/, ''))
  end

  def get_encounter_types
    encounter_types = {}
    get_json_data('encountertype')['results'].each do |hash|
      encounter_types[hash['uuid']] = hash['display']
    end
    return encounter_types
  end

  def get_patients(encounter_types)
    patients = []
    encounter_types.each do |uuid, name|
      patients += get_json_data('raxacore/patientlist', {
        :startDate => Chronic::parse('1 week ago'),
        :endDate => Chronic::parse('today'),
        :encounterType => uuid
      })['patients']
    end
    return patients
  end

  def get_json_data(uri, params={})
    uri = URI('http://test.raxa.org:8080/openmrs/ws/rest/v1/' + uri)
    uri.query = URI.encode_www_form(params)

    req = Net::HTTP::Get.new(uri.request_uri)
    req['Content-type'] = 'application/json'
    req['Accept'] = 'application/json'
    req.basic_auth 'admin', 'Hello123'

    res = Net::HTTP.start(uri.hostname, uri.port) {|http|
      http.request(req)
    }
    return JSON.parse(res.body)
  end
end
