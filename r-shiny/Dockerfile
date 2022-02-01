FROM r-base:latest
LABEL maintainer="Xianying Tan <shrektan@126.com>"
RUN R -e "install.packages(c('shiny', 'DT'));" \
      -e "library('shiny'); library('DT')"
