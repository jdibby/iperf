### PULL LATEST ALPINE OS
FROM alpine:latest

### INSTALL IPERF3 WITH NO CACHE AND ADD IPERF USER
RUN apk add --no-cache iperf3 \
  && adduser -S iperf

### RUN CONTAINER AS IPERF USER
USER iperf
    
### EXPOSE TCP AND UDP PORT 5201 FOR TESTING
EXPOSE 5201/tcp 5201/udp

### ENTRY IS IPERF3 TO EXPOSE FLAGS TO BE USED
ENTRYPOINT ["iperf3"]

### VALIDATE IPERF3 WORKS BY THROUGHPUT TESTING TO ITSELF
HEALTHCHECK --timeout=2s \
 CMD iperf3 -k 1 -c 127.0.0.1 || exit 1

### RUN IPERF3 IN SERVER MODE
CMD ["-s"]
