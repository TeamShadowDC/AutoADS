


## docker run

```bash
docker run -ti --name AutoADS_t --cap-add=NET_ADMIN --sysctl net.ipv6.conf.all.disable_ipv6=0 j4ck/auto
ads bash -c "cp ~/.zshrc ~/.zshrc.temp; cat ~/.zshrc.temp | sed 's/USER_NAME/MarcHortelano/g;s/DOMAIN_NAME/ITB/g;s/MACHINE_IP/-/g'
 > ~/.zshrc; zsh"
```
