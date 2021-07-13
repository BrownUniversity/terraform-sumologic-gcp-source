title "Test creation of GCP logging export resources"

# Terraform outputs defined in examples/*/outputs.tf
# become directly available to Ispec tests as attributes
sumologic_endpoint = attribute("sumologic_endpoint")
google_project_id = attribute("google_project_id")
google_pubsub_topic_id = attribute("google_pubsub_topic_id")
google_pubsub_topic_name = attribute("google_pubsub_topic_name")
google_pubsub_subscription_id = attribute("google_pubsub_subscription_id")
google_pubsub_subscription_name = attribute("google_pubsub_subscription_name")
google_topic_iam_publisher = attribute("google_topic_iam_publisher")


control 'gcp configuration' do
  describe google_pubsub_subscriptions(project: google_project_id) do
    its('count') { should be >= 1 }
  end

  describe google_pubsub_topic(project: google_project_id, name: google_pubsub_topic_name) do
    it { should exist }
  end

  google_pubsub_topic_iam_policy(project: google_project_id, name: google_pubsub_topic_name).bindings.each do |binding|
    describe binding do
      its('role') { should eq 'roles/pubsub.publisher'}
      its('members') { should include google_topic_iam_publisher}
    end
  end

  describe google_pubsub_subscription(project: google_project_id, name: google_pubsub_subscription_name) do
    it { should exist }
    its('topic') {should eq google_pubsub_topic_id}
    its('push_config.push_endpoint') {should eq sumologic_endpoint}
  end
end