title "Test creation of sumologic GCP logging source"

# Grab some env variables in order to validate certain configs

sumologic_base64 = ENV["SUMOLOGIC_BASE64"]

# Terraform outputs defined in examples/*/outputs.tf
# become directly available to Ispec tests as attributes
sumologic_source_id = attribute("id")
sumologic_collector_id = attribute("collector_id")
sumologic_source_name = attribute("name")
sumologic_endpoint = attribute("url")
sumologic_source_category = attribute("source_category")
sumologic_source_filters = attribute("filters")

control 'http_test' do
    describe http("https://api.us2.sumologic.com/api/v1/collectors/#{sumologic_collector_id}/sources/#{sumologic_source_id}",
                      headers: {
                        'Accept' => 'application/json',
                        'Authorization' => "Basic #{sumologic_base64}"
                      }) do
        its('status') { should eq 200 }
    end
end

control 'sumologic configuration' do
  http_request = http("https://api.us2.sumologic.com/api/v1/collectors/#{sumologic_collector_id}/sources/#{sumologic_source_id}",
                      headers: {
                        'Accept' => 'application/json',
                        'Authorization' => "Basic #{sumologic_base64}"
                      })

  describe json(content: http_request.body) do
    its(['source', 'id']) {should eq Integer(sumologic_source_id)}
    its(['source', 'name']) {should eq sumologic_source_name}
    its(['source', 'thirdPartyRef', 'resources', 0, 'serviceType']) {should eq 'GoogleCloudLogs'}
  end
end