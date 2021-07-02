# Inspec custom resource. 
# Custom resources These become available with their respective names 
# and provide easy functionality to profiles. 
# This example shows calling a local command and capturing its stdout
# More about custom see https://docs.chef.io/inspec/dsl_resource/
class Echo < Inspec.resource(1)
    name 'echo'
    desc 'Validate printing a message'
    supports platform: 'unix'
  
    def initialize(message)
      @resp = inspec.command("echo #{message}")
    end
  
    def stdout
      @resp.stdout
    end
  
    def stderr
      @resp.stderr
    end
  
    def exit_status
      @resp.exit_status
    end
  end