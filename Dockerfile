FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

#Install python in the agent to execute python scripts
RUN apt-get -y update
RUN apt install -y python3.8
RUN apt install -y python3-pip
RUN apt install -y python-is-python3


COPY ./start.sh .
RUN chmod +x start.sh

ENV AZP_URL=https://dev.azure.com/{replace_by_your_organization}
ENV AZP_TOKEN={your_personal_access_token}
ENV AZP_AGENT_NAME={name_wanted_as_your_dockeragentname}

ENTRYPOINT [ "./start.sh"]