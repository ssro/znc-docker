# ZNC on docker

### ZNC IRC bouncer on docker

### Usage
 - clone this repo & make your changes
 - build the docker image
 - follow below setup (this is based on the quay.io docker image)

#### I don't have configuration files

If you start fresh and have no config files continue reading. If you have the config files, you can skip this part and jump to [I have the configuration files](#i-have-the-configuration-files)

```
$ docker pull quay.io/ssro/znc-docker
```

Configure ZNC

```
$ docker run -it --rm -v $(pwd)/conf:/var/lib/znc quay.io/ssro/znc-docker sh -c "znc --makeconf --datadir=/var/lib/znc"
```

The output of the above command will configure your bouncer:

```
[ .. ] Checking for list of available modules...
[ >> ] ok
[ ** ]
[ ** ] -- Global settings --
[ ** ]
[ ?? ] Listen on port (1025 to 65534): 65000
[ ?? ] Listen using SSL (yes/no) [no]: yes
[ ?? ] Listen using both IPv4 and IPv6 (yes/no) [yes]:
[ .. ] Verifying the listener...
[ >> ] ok
[ ** ] Unable to locate pem file: [/var/lib/znc/znc.pem], creating it
[ .. ] Writing Pem file [/var/lib/znc/znc.pem]...
[ >> ] ok
[ ** ] Enabled global modules [webadmin]
[ ** ]
[ ** ] -- Admin user settings --
[ ** ]
[ ?? ] Username (alphanumeric): znc-user
[ ?? ] Enter password:
[ ?? ] Confirm password:
[ ?? ] Nick [znc-user]:
[ ?? ] Alternate nick [znc-user_]:
[ ?? ] Ident [znc-user]:
[ ?? ] Real name [Got ZNC?]:
[ ?? ] Bind host (optional):
[ ** ] Enabled user modules [chansaver, controlpanel]
[ ** ]
[ ?? ] Set up a network? (yes/no) [yes]: yes
[ ** ]
[ ** ] -- Network settings --
[ ** ]
[ ?? ] Name [freenode]:
[ ?? ] Server host [chat.freenode.net]:
[ ?? ] Server uses SSL? (yes/no) [yes]:
[ ?? ] Server port (1 to 65535) [6697]:
[ ?? ] Server password (probably empty):
[ ?? ] Initial channels:
[ ** ] Enabled network modules [simple_away]
[ ** ]
[ .. ] Writing config [/var/lib/znc/configs/znc.conf]...
[ >> ] ok
[ ** ]
[ ** ] To connect to this ZNC you need to connect to it as your IRC server
[ ** ] using the port that you supplied.  You have to supply your login info
[ ** ] as the IRC server password like this: user/network:pass.
[ ** ]
[ ** ] Try something like this in your IRC client...
[ ** ] /server <znc_server_ip> +65000 znc-user:<pass>
[ ** ]
[ ** ] To manage settings, users and networks, point your web browser to
[ ** ] https://<znc_server_ip>:65000/
[ ** ]
[ ?? ] Launch ZNC now? (yes/no) [yes]: no
```

Answer `no` to the last step of configuration, `Launch ZNC now?`. The container will generate the config and exit.

N.B: adjust your configuration based on your preferences

Make sure that the config files exist on the host's folder

```
$ ls -la conf/
...
drwx------ 2    100    101   21 Jun 17 06:55 configs
-rw------- 1    100    101 3234 Jun 17 06:54 znc.pem
```

Start ZNC
```
$ docker run -d -p <host_port>:<port_defined_in_znc_config> --name znc-docker -v $(pwd)/conf:/var/lib/znc quay.io/ssro/znc-docker
```

Replace `host_port` and `port_defined_in_znc_config` accordingly. For example:

```
$ docker run -d -p 65500:65500 --name znc-docker -v $(pwd)/conf:/var/lib/znc quay.io/ssro/znc-docker
```


#### I have the configuration files

Place you configuration files in the `$(pwd)/conf` folder (create the folder if you don't have it) and  start ZNC
