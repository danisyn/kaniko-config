FROM debian:latest

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
 python3 \
 postfix \
 spamassassin \
 spamc \
 spamass-milter \
 sasl2-bin \
 postgrey \
 fail2ban \
 postfix-policyd-spf-python

RUN touch /var/log/auth.log
RUN touch /var/log/mail.log
RUN groupadd -g 5555 spamd
RUN useradd -u 5555 -g spamd -s /sbin/nologin -d /usr/local/spamassassin spamd
RUN mkdir -p /usr/local/spamassassin/log
RUN chown spamd:spamd -R /usr/local/spamassassin
RUN rm -rf /run/saslauthd
RUN ln -s /var/spool/postfix/var/run/saslauthd   /run/saslauthd
RUN dpkg-statoverride --add root sasl 710 /var/spool/postfix/var/run/saslauthd
RUN adduser postfix sasl 

CMD ["sleep", "infinity"]
