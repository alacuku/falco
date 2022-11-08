ARG FALCO_IMAGE_TAG=0.33.0
FROM falcosecurity/falco:${FALCO_IMAGE_TAG}

LABEL maintainer="cncf-falco-dev@lists.cncf.io"


ENV HOST_ROOT /host
ENV HOME /root

COPY ./gvisor.sh /

ENTRYPOINT ["/gvisor.sh"]