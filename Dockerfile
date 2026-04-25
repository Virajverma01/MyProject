
FROM tomcat:9.0

COPY MyProject.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
