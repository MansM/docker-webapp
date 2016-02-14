FROM httpd:2.4
RUN mkdir /usr/local/apache2/htdocs/ui
COPY index.html /usr/local/apache2/htdocs/index.html