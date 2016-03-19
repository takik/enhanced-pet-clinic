FROM codenvy/debian_jdk8

USER root 

#RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 
#RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

# server ports (8180 for server and 80 for nginx)
#EXPOSE 8180 80
EXPOSE 8888

#RUN apt-get update && apt-get install -y ca-certificates nginx && rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
#RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# GET ATM server/client code
COPY ./enhanced-pet-clinic-exec.jar	/tmp/

# extract the war to run server/UI in standalone
#RUN rm -rf /tmp/enhanced-pet-clinic && mkdir -p /tmp/enhanced-pet-clinic && cd /tmp/enhanced-pet-clinic

# COPY THE UI DISTRIBUTION IN NGINX HTTP FOLDER
#RUN cp -r /tmp/ATM-SERVER/node-client/* /usr/share/nginx/html/

# GET entry point script running server and client binaries
COPY ./pet-clinic-startup.sh /tmp/
RUN whoami && ls -l /tmp/pet-clinic-startup.sh && chmod +x /tmp/pet-clinic-startup.sh

# EXECUTE ENTRY POINT LAUNCHING THE SERVER AND CLIENT TO PROVIDE
ENTRYPOINT [ "/tmp/pet-clinic-startup.sh" ]