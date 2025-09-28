# Use the official Jenkins LTS image as the base
FROM jenkins/jenkins:lts

# Switch to root user to install Docker CLI and other tools
USER root

# Install Docker CLI
# The Docker daemon itself will run on the host, Jenkins will just use the CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release git && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Install necessary plugins (optional, but good for common CI/CD tasks)
# You can add more plugins here as needed
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Add jenkins user to Docker group so it can access /var/run/docker.sock
RUN groupadd -for -g 999 docker && usermod -aG docker jenkins

# Switch back to the jenkins user
USER jenkins
