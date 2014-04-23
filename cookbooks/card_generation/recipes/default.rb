#
# Cookbook Name:: card_generation
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
remote_file "deploy_war" do
  source "https://s3-us-west-1.amazonaws.com/card-provisioning-packages/cardGeneration%23v1.war"
  path "/var/lib/tomcat7/webapps/cardGeneration#v1.war"
  notifies :restart, 'service[tomcat7]'
end

service 'tomcat7' do
  action :restart
end