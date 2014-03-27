template "/var/lib/tomcat7/webapps/cardProvisioning#v1/WEB-INF/classes/configInventoryCardOrder.properties" do
  source "configInventoryCardOrder.properties.erb"
  mode 0644
  owner "tomcat7"
  group "tomcat7"
  variables({
     :cardProvisioning_sqs => node[:cardProvisioning][:sqs],
     :cardProvisioning_aws_access_key => node[:cardProvisioning][:aws_access_key],
     :cardProvisioning_aws_secret_key => node[:cardProvisioning][:aws_secret_key],
     :cardProvisioning_rds => node[:cardProvisioning][:rds],
     :cardProvisioning_rds_uid => node[:cardProvisioning][:rds_uid],
     :cardProvisioning_rds_pwd => node[:cardProvisioning][:rds_pwd]
  })
  notifies :restart, 'service[tomcat7]'
end

service 'tomcat7' do
  action :restart
end