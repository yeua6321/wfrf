FROM nginx:latest

EXPOSE 80

WORKDIR /home/choreouser

COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh ./

RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl vim netcat-openbsd &&\
    wget -O temp.zip $(wget -qO- "https://api.github.com/repos/v2fly/v2ray-core/releases/latest" | grep -m1 -o "https.*linux-64.*zip") &&\
    unzip temp.zip v2ray geoip.dat geosite.dat &&\
    mv v2ray v &&\
    rm -f temp.zip &&\
    chmod -v 755 v entrypoint.sh &&\
    echo 'ewogICAgImxvZyI6ewogICAgICAgICJsb2dsZXZlbCI6Indhcm5pbmciLAogICAgICAgICJhY2Nl\
c3MiOiIvZGV2L251bGwiLAogICAgICAgICJlcnJvciI6Ii9kZXYvbnVsbCIKICAgIH0sCiAgICAi\
aW5ib3VuZHMiOlsKICAgICAgICB7CiAgICAgICAgICAgICJwb3J0IjoxMDAwMCwKICAgICAgICAg\
ICAgInByb3RvY29sIjoidm1lc3MiLAogICAgICAgICAgICAibGlzdGVuIjoiMTI3LjAuMC4xIiwK\
ICAgICAgICAgICAgInNldHRpbmdzIjp7CiAgICAgICAgICAgICAgICAiY2xpZW50cyI6WwogICAg\
ICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgImlkIjoiVVVJRCIsCiAg\
ICAgICAgICAgICAgICAgICAgICAgICJhbHRlcklkIjowCiAgICAgICAgICAgICAgICAgICAgfQog\
ICAgICAgICAgICAgICAgXQogICAgICAgICAgICB9LAogICAgICAgICAgICAic3RyZWFtU2V0dGlu\
Z3MiOnsKICAgICAgICAgICAgICAgICJuZXR3b3JrIjoid3MiLAogICAgICAgICAgICAgICAgIndz\
U2V0dGluZ3MiOnsKICAgICAgICAgICAgICAgICAgICAicGF0aCI6Ii92bWVzcyIKICAgICAgICAg\
ICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIH0sCiAgICAgICAgewogICAgICAgICAgICAi\
cG9ydCI6MjAwMDAsCiAgICAgICAgICAgICJwcm90b2NvbCI6InZsZXNzIiwKICAgICAgICAgICAg\
Imxpc3RlbiI6IjEyNy4wLjAuMSIsCiAgICAgICAgICAgICJzZXR0aW5ncyI6ewogICAgICAgICAg\
ICAgICAgImNsaWVudHMiOlsKICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAg\
ICAgICAgICJpZCI6IlVVSUQiCiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAg\
XSwKICAgICAgICAgICAgICAgICJkZWNyeXB0aW9uIjoibm9uZSIKICAgICAgICAgICAgfSwKICAg\
ICAgICAgICAgInN0cmVhbVNldHRpbmdzIjp7CiAgICAgICAgICAgICAgICAibmV0d29yayI6Indz\
IiwKICAgICAgICAgICAgICAgICJ3c1NldHRpbmdzIjp7CiAgICAgICAgICAgICAgICAgICAgInBh\
dGgiOiIvdmxlc3MiCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAg\
ICBdLAogICAgIm91dGJvdW5kcyI6WwogICAgICAgIHsKICAgICAgICAgICAgInByb3RvY29sIjoi\
ZnJlZWRvbSIsCiAgICAgICAgICAgICJzZXR0aW5ncyI6ewoKICAgICAgICAgICAgfQogICAgICAg\
IH0KICAgIF0sCiAgICAiZG5zIjp7CiAgICAgICAgInNlcnZlcnMiOlsKICAgICAgICAgICAgIjgu\
OC44LjgiLAogICAgICAgICAgICAiOC44LjQuNCIsCiAgICAgICAgICAgICJsb2NhbGhvc3QiCiAg\
ICAgICAgXQogICAgfQp9Cg==' > config &&\
    addgroup --gid 10001 choreo &&\
    adduser --disabled-password  --no-create-home --uid 10001 --ingroup choreo choreouser &&\
    usermod -aG sudo choreouser

ENTRYPOINT [ "./entrypoint.sh" ]

USER 10001
