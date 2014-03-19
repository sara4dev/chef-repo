#
# Cookbook Name:: card_provisioning
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "deploy_war" do
  source "https://s3-us-west-1.amazonaws.com/card-provisioning-packages/cardProvisioning%23v1.war"
  path "/var/lib/tomcat7/webapps/cardProvisioning#v1.war"
  notifies :restart, 'service[tomcat]'
end

template "/var/lib/tomcat7/webapps/cardProvisioning#v1/WEB-INF/classes/configInventoryCardOrder.properties" do
  source "configInventoryCardOrder.properties.erb"
  mode 0440
  owner "root"
  group "root"
  variables({
     :cardProvisioning_sqs => node[:cardProvisioning][:sqs],
     :cardProvisioning_rds => node[:cardProvisioning][:rds]
  })
end