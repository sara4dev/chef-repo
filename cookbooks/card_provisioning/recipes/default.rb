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
  mode 0644
  owner "tomcat7"
  group "tomcat7"
  variables({
     :cardProvisioning_sqs => node[:cardProvisioning][:sqs],
     :cardProvisioning_rds => node[:cardProvisioning][:rds]
  })
end

service 'tomcat' do
  case node['platform']
  when 'centos', 'redhat', 'fedora', 'amazon'
    service_name "tomcat#{node['tomcat']['base_version']}"
    supports :restart => true, :status => true
  when 'debian', 'ubuntu'
    service_name "tomcat#{node['tomcat']['base_version']}"
    supports :restart => true, :reload => false, :status => true
  when 'smartos'
    service_name 'tomcat'
    supports :restart => false, :reload => false, :status => true
  else
    service_name "tomcat#{node['tomcat']['base_version']}"
  end
  action [:start, :enable]
  notifies :run, 'execute[wait for tomcat]', :immediately
  retries 4
  retry_delay 30
end