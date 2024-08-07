FROM gitpod/workspace-base

USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/* && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install AWS CLI v2
RUN curl -sSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip && \
    unzip -q awscliv2.zip && \
    ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update && \
    rm -rf awscliv2.zip ./aws /usr/local/aws-cli/v2/dist/awscli/examples

USER gitpod
