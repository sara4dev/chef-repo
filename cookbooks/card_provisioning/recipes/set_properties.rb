template "/var/lib/tomcat7/webapps/cardProvisioning#v1/WEB-INF/classes/configInventoryCardOrder.properties" do
  source "configInventoryCardOrder.properties.erb"
  mode 0644
  owner "tomcat7"
  group "tomcat7"
  variables({
     :cardProvisioning_sqs => node[:cardProvisioning][:sqs],
     :cardProvisioning_rds => node[:cardProvisioning][:rds]
  })
  notifies :restart, 'service[tomcat7]'
end

service 'tomcat7' do
  action :restart
end