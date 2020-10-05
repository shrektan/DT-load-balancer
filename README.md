# An example to illustrate deploying DT with a load balancer

There're a lot of questions about the server-side processing mode of DT can't work well with a load balancer. I believe the reason is the DT table in the browser needs to POST an Ajax request to the original server in order to update the data. So my suggestion is always to enable the stick session of the load balancer.

However, users still report that my suggestion fails. Finally, I decide to set up an example about this so that I can be confident to say that the issue is not caused by DT.

## The steps to recreate my example

1. Pull the source code of this repo to a folder, e.g., ~/DT-load-balancer.
1. CD into that folder.
1. Run `docker swarm init` to init the docker swarm.
1. Run `docker stack deploy -c traefik.yml traefik` to start traefik (a load balancer).
1. Run `docker stack deploy -c shiny.yml shiny` to start a shiny app.

## Thanks

- Thanks @richardtc for providing [an example to start with](https://github.com/rstudio/DT/issues/849#issuecomment-700036427)
- Thanks [Yihui Fan](https://www.databentobox.com/authors/yihui-fan/) for his post [Effectively Deploying and Scaling Shiny Apps with ShinyProxy, Traefik and Docker Swarm](https://www.databentobox.com/2020/05/31/shinyproxy-with-docker-swarm/#optional-deploying-r-shiny-apps-without-shinyproxy). 
