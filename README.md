# logDNA Add-on

This repository provides [LogDNA](https://docs.logdna.com/docs/getting-started) add-on for Jelastic Platform.

**LogDNA** is the easiest centralized log management software

**Type of nodes this add-on can be applied to**: 
- All CentOS based nodes.

### What it can be used for?
LogDNA is a cloud log management software that aggregates all system and application logs in one centralized logging system. Our easy, blazing fast system allows you to collect, monitor, parse, live tail, graph, and analyze logs with clear visualizations and smart alerting. Sign up for an account at logdna.com. Get setup and start logging within minutes!

### Deployment
In order to get this solution instantly deployed, click the "Deploy to Jelastic" button

[![GET IT HOSTED](https://raw.githubusercontent.com/jelastic-jps/jpswiki/master/images/getithosted.png)](https://app.j.layershift.co.uk/?manifest=https://raw.githubusercontent.com/layershift/jps-logDNA/master/logDNA.jps)

To deploy this package to Jelastic Private Cloud, import [this JPS manifest](https://raw.githubusercontent.com/layershift/jps-logDNA/master/logDNA.jps) within your dashboard ([detailed instruction](https://docs.jelastic.com/environment-export-import#import)).

For more information on what Jelastic add-on is and how to apply it, follow the [Jelastic Add-ons](https://github.com/jelastic-jps/jpswiki/wiki/Jelastic-Addons) reference.

### Installation Process

![Install](https://raw.githubusercontent.com/layershift/jps-logDNA/master/images/install_options.png)

* Ingestion Key : The Ingestion Key provided in your LogDNA dashboard
* Tags : Tag to add to sent log entries
* Logs to monitor : Multiple folders from where to read the logs. 1.linne
```
#lines starting with # are ignored
#Nginx load balancer
#/var/log/nginx/*access_log
#/var/log/nginx/*error_log
#Tomcat nodes
#/opt/tomcat/logs/catalina.out
#/opt/tomcat/logs
```
### Actions

![Options](https://raw.githubusercontent.com/layershift/jps-logDNA/master/images/options.png)

Once installed you can:

* Restart LogDNA
* Change the configuration parameters using Configure button
* Show the configration file content using Show Configuration File button
* Check LogDNA status using Status button

* Status to check the service status
* Dashboard to open logDNA dashboard

### CLI options:
```
sudo /etc/init.d/logdna-agent status
sudo /etc/init.d/logdna-agent stop
sudo /etc/init.d/logdna-agent start
logdna-agent -h
```
