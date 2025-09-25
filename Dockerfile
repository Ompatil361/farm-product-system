# Use an official Tomcat image which includes Java
FROM tomcat:9.0-jdk11-openjdk

# The application's WAR file must be copied to the webapps directory
# I am assuming your project builds 'farm-product-system.war' inside the 'dist' folder.
# If your .war file has a different name, change it here.
COPY dist/farm-product-system.war /usr/local/tomcat/webapps/ROOT.war
