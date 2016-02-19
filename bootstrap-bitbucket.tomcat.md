# remember to change...

@ /var/atlassian/application-data/bitbucket/shared/server.xml

# SSL settings

```
<!-- START: by carlessanagustin.com -->
<!--
        <Connector port="7990" protocol="HTTP/1.1"
                   connectionTimeout="20000"
                   useBodyEncodingForURI="true"
                   redirectPort="8443"
                   compression="on"
                   compressableMimeType="text/html,text/xml,text/plain,text/css,application/json,application/javascript,application/x-javascript" />
-->
<!-- source: https://confluence.atlassian.com/bitbucketserver/securing-bitbucket-server-behind-nginx-using-ssl-776640112.html-->
<Connector port="7990"
     protocol="HTTP/1.1"
     connectionTimeout="20000"
     useBodyEncodingForURI="true"
     redirectPort="443"
     compression="on"
     compressableMimeType="text/html,text/xml,text/plain,text/css,application/json,application/javascript,application/x-javascript"
     secure="true"
     scheme="https"
     proxyName="your.domain.com"
     proxyPort="443" />

<!-- source: https://confluence.atlassian.com/bitbucketserver/securing-bitbucket-server-with-tomcat-using-ssl-776640127.html -->
<!--
<Connector port="8443"
  maxHttpHeaderSize="8192"
  SSLEnabled="true"
        maxThreads="150"
  minSpareThreads="25"
  maxSpareThreads="75"
        enableLookups="false"
  disableUploadTimeout="true"
  useBodyEncodingForURI="true"
        acceptCount="100"
  scheme="https"
  keystoreFile="/home/administrador/keystore/bitbucket.jks"
  secure="true"
        clientAuth="false"
  sslProtocol="TLS" />
-->
<!-- END: by carlessanagustin.com -->
```

# URI folder

```
<!--
<Context path="/bitbucket"
		docBase="${catalina.home}/atlassian-bitbucket"
		reloadable="false"
		useHttpOnly="true">
-->
<Context path=""
		docBase="${catalina.home}/atlassian-bitbucket"
		reloadable="false"
		useHttpOnly="true">
```