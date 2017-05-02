FROM qnib/uplain-init

ARG COCKROACH_VER=v1.0-rc.1
RUN apt-get update \
 && apt-get install -y wget \
 && wget -qO - https://binaries.cockroachdb.com/cockroach-${COCKROACH_VER}.linux-amd64.tgz |tar xfz - --strip-components=1 -C /usr/local/bin/ \
 && apt-get purge -y wget
COPY opt/qnib/cockroach/bin/start.sh /opt/qnib/cockroach/bin/
CMD ["/opt/qnib/cockroach/bin/start.sh"]
