#!/usr/bin/env ruby

require "octokit"
require "yaml"
require "pp"

# should debugging output be enabled?
def debugging?
  ENV['DEBUG'] && ENV['DEBUG'] != ''
  true  #TODO remove
end

def exit_with_usage!
  STDERR.puts "Usage:"
  STDERR.puts "  #{$0} <organization_name>                           # displays list of organization projects"
  STDERR.puts "  #{$0} <organization_name> <project_id>              # displays list of columns in an organization project"
  STDERR.puts "  #{$0} <organization_name> <project_id> <column_id>  # imports subject data as cards into an organization project column"
  exit 1
end

def create_project_cards(client, organization, project_id, column_id)
end

def show_project_columns(client, organization, project_id)
end

def show_organization_projects(client, organization)
  client.org_projects(organization).each do |project|
    puts "name: #{project[:name]}"
    puts "body: #{project[:body]}"
    puts "url: #{project[:url]}"
    puts "project_id: #{project[:url].sub(%r{^.*/}, '')}"
    puts
  end
end

# retrieve GitHub API token
creds = YAML.load(File.read(File.expand_path('~/.github.yml')))
access_token = creds["token"]

client = Octokit::Client.new :access_token => access_token
puts "Current octokit rate limit: #{client.rate_limit.inspect}" if debugging?

# gather command-line parameters
organization = ARGV.shift
project_id   = ARGV.shift
column_id    = ARGV.shift

if organization
  if project_id
    if column_id
      create_project_cards(client, organization, project_id, column_id)
    else
      show_project_columns(client, organization, project_id)
    end
  else
    show_organization_projects(client, organization)
  end
else
  exit_with_usage!
end

