FROM grubykarol/locust:0.11.0-python3.7-alpine3.9
RUN  pip install --no-cache-dir elasticsearch>=7.0.0
RUN  mkdir /script-home
COPY tools /script-home/tools
COPY docker-entrypoint.sh /script-home/docker-entrypoint.sh
EXPOSE 8089 5557 5558
RUN chmod +x /script-home/docker-entrypoint.sh
ENTRYPOINT ["/script-home/docker-entrypoint.sh"]
