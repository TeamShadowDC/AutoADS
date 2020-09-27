FROM kalilinux/kali-rolling
LABEL maintainer="Jack21"

ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive

#Working Directory
WORKDIR /root
RUN mkdir ${HOME}/toolkit && \
    mkdir /work && \
    mkdir ${HOME}/wordlists && \
    mkdir -p ${HOME}/scripts/Enumeration && \ 
    mkdir ${HOME}/scripts/PrivEsc  


# Install Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    iputils-ping\
    git \
    vim \
    wget \
    awscli \
    tzdata \
    curl \
    make \
    nmap \
    whois \
    python2 \
    python3-venv \    
    python3 \
    python3-pip \
    perl \
    nikto \
    dnsutils \
    net-tools \
    neovim\
    zsh\
    libzip-dev \ 
    nodejs \
    npm \
    pkg-config \
    openssh-client \
    rlwrap \
    && rm -rf /var/lib/apt/lists/*

#Install Dependencies 
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # sqlmap
    sqlmap \
    # wfuzz
    #python-pycurl \
    # dnsenum
    cpanminus \
    #Metasploit
    metasploit-framework \ 
    # dnsrecon
    dnsrecon \
    #crackmapexe
    libssl-dev \
    libffi-dev\
    python-dev \ 
    build-essential \
    #netcat
    netcat \
    #enum4linux 
    enum4linux \
    #dnsenum
    dnsenum \
    #hashcat
    hashcat \
    hash-identifier \
    #tcpdump 
    tcpdump \ 
    && rm -rf /var/lib/apt/lists/*


    # configure python(s)
RUN python3 -m pip install --upgrade setuptools && python3 -m pip install --upgrade setuptools


# go
RUN cd /opt && \
    wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz && \
    tar -xvf go1.13.3.linux-amd64.tar.gz && \
    rm -rf /opt/go1.13.3.linux-amd64.tar.gz && \
    mv go /usr/local 
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}


# ffuf 
RUN go get github.com/ffuf/ffuf


# zsh 
RUN wget https://raw.githubusercontent.com/TeamShadowDC/PcConfig/master/LABS/docker/config/zsh/.oh-my-zsh/themes/oxide.zsh-theme && \
    mv oxide.zsh-theme .zshrc && \
    chsh -s /bin/zsh && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --depth 1 && \
    echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"


# Crackmapexe
RUN python3 -m pip install pipx && \
    python3 -m pipx ensurepath && \
    python3 -m pip install virtualenv && \
    python3 -m pipx install crackmapexec

#evil-winrm
RUN gem install evil-winrm


# Download wordlist
# SecList
RUN cd ${HOME}/wordlists && \
    git clone --depth 1 https://github.com/danielmiessler/SecLists.git && \
    tar -zxvf  SecLists/Passwords/Leaked-Databases/rockyou.txt.tar.gz


#Nvim like vscode


#Tmux 

# Add alias
RUN echo -n "\n\n#Alias\n" >> .zshrc && \
    echo 'alias ll="ls -l"' >> .zshrc && \
    echo 'alias la="ls -a"' >> .zshrc && \
    echo 'alias lla="ls -la"' >> .zshrc && \
    echo 'alias cme="cracmapexe"' >> .zshrc 