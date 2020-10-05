# An example to illustrate deploying DT under a load balancer

There're a lot of questions about the server-side processing mode of DT can't work well with a load balancer. I believe the reason is the DT table in the browser needs to POST an Ajax request to the original server in order to update the data. So my suggestion is always to enable the stick session of the load balancer.

However, users still report that my suggestion fails. Finally, I decide to set up an example about this so that I can be confident to say that the issue is not caused by DT.

## System requires

OSX with docker desktop installed. Other systems should be fine but you may or may not to tweak the details.

## The steps to re-create the example

### Prepare example repo and docker images

1. Pull the source code of this repo to a folder, e.g., ~/DT-load-balancer.
1. CD into that folder.
1. Prepare the docker images
    - `docker pull traefik:v2.3.0` (for reverse proxy and load balancer)
    - `docker pull shrektan/rdocker4working:latest` (for serving shiny apps)

### Paste the below code into the terminal and execute them

```shell
docker swarm init
docker network create --driver=overlay traefik-public
docker stack deploy -c traefik.yml traefik
docker stack deploy -c shiny-sticky.yml shiny-sticky
docker stack deploy -c shiny-no-sticky.yml shiny-no-sticky
```

#### The meaning of the above codes

1. `docker swarm init`: init the docker swarm.
1. `docker network create --driver=overlay traefik-public`: create a network so that services can find each other.
1.`docker stack deploy -c xxx.yml xxx` to start xxx as a service.

## Use Chrome to check the result

(Safari seems not work well for traefik on my Mac - haven't checked the cause yet)

1. Again, you'd better use Chrome
1. http://traefik.sys.localhost/ : the dashboard of traefik
1. http://shiny-sticky.docker.localhost/ : the shiny app with sticky session enabled - should work **without** Ajax errors
1. http://shiny-no-sticky.docker.localhost/ : the shiny app without sticky session enabled - should work **with** Ajax errors

For the last two shiny apps, please pay attention to the last line of the apps, where the internal IP address is displayed. **You should see that when sticky session is disabled, the IP address gets changed each time you refresh the webpage.**

## Clean up

Remove the services and networks: 

```shell
docker swarm leave --force
```

## Thanks

- Thanks @richardtc for providing [an example to begin with](https://github.com/rstudio/DT/issues/849#issuecomment-700036427).

- Thanks [Yihui Fan](https://www.databentobox.com/authors/yihui-fan/) for his post [Effectively Deploying and Scaling Shiny Apps with ShinyProxy, Traefik and Docker Swarm](https://www.databentobox.com/2020/05/31/shinyproxy-with-docker-swarm/#optional-deploying-r-shiny-apps-without-shinyproxy).
