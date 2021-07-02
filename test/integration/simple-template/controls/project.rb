title "Test simple template"

# Terraform outputs defined in examples/*/outputs.tf
# become directly available to Ispec tests as attributes
message = attribute("message")

describe echo(message) do
    its('stdout') { should include message}
end