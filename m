Return-Path: virtio-dev-return-5012-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63D28985CB2
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Nov 2018 13:55:44 +0000 (UTC)
MIME-Version: 1.0
References: <20180920220951-mutt-send-email-mst@kernel.org>
 <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org> <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org> <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org> <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
 <20181018233115-mutt-send-email-mst@kernel.org> <CAKPgXcH4mokJd7MeTUNjoGzo6Lbyx72cOQPLfKccQLwVHSMArg@mail.gmail.com>
 <20181121124246-mutt-send-email-mst@kernel.org> <CAKPgXcH2D4XcUNoS6tvDfLxPAv05u7Yu77OYxRnuFFfgN34A_w@mail.gmail.com>
 <9caffae7-dce0-e70f-2821-5210d38d2e73@intel.com>
In-Reply-To: <9caffae7-dce0-e70f-2821-5210d38d2e73@intel.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 22 Nov 2018 15:55:30 +0200
Message-ID: <CAKPgXcHNN-sg+AnSxCJjmGrdcvPRkL3ZaL04HkBq1pEi=mcvVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: sridhar.samudrala@intel.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 22, 2018 at 1:51 AM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
> On 11/21/2018 12:04 PM, Sameeh Jubran wrote:
> > On Wed, Nov 21, 2018 at 8:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >> Great to see you making progress on this!
> >> Some comments below:
> >>
> >> On Wed, Nov 21, 2018 at 05:39:38PM +0200, Sameeh Jubran wrote:
> >>> I have created a setup which has two hosts (host A and host B) with X710 10G
> >>> cards connected back to back. On one host (I'll refer to this host as host A) I
> >>> have configured a bridge with the PF interface as well as vitio-net's interface
> >>> (standby) both attached to it.
> >> ...
> >>
> >>> The command line I used:
> >>>
> >>> /root/qemu/x86_64-softmmu/qemu-system-x86_64 \
> >>> -netdev tap,id=hostnet0,script=world_bridge_standalone.sh,downscript=no,ifname=
> >>> cc17 \
> >>> -device e1000,netdev=hostnet0,mac=56:cc:c1:01:cc:21,id=cc17 \
> >> What's e1000 doing here?
> >> Can this be reason you can not talk to host?
> > I don't think so, the e1000 is for enabling WAN connection on the
> > guest for downloading packages and ssh connection. It is connected to
> > a separate bridge which is connected to the external interface of the
> > host.
> >>> -netdev tap,vhost=on,id=hostnet1,script=test_bridge_standalone.sh,downscript=
> >>> no,ifname=cc1_72,queues=4 \
> >>> -device virtio-net,host_mtu=1500,netdev=hostnet1,mac=8a:f7:20:29:3b:cb,id=
> >>> cc1_72,vectors=10,mq=on,primary=cc1_71 \
> >>> -device vfio-pci,host=65:02.1,id=cc1_71,standby=cc1_72 \
> >>> -enable-kvm \
> >>> -name netkvm \
> >>> -m 3000M \
> >>> -drive file=/dev/shm/fedora_29.qcow2,if=ide,id=drivex \
> >>> -smp 4 \
> >>> -vga qxl \
> >>> -spice port=6110,disable-ticketing \
> >>> -device virtio-serial-pci,id=virtio-serial0,max_ports=16,bus=pci.0,addr=0x7 \
> >>> -chardev spicevmc,name=vdagent,id=vdagent \
> >>> -device virtserialport,nr=1,bus=virtio-serial0.0,chardev=vdagent,name=
> >>> com.redhat.spice.0 \
> >>> -chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
> >>> -device virtio-serial \
> >>> -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
> >>> -monitor stdio
> >>
> >> ...
> >>
> >>> Since I couldn't ping from VM to host B, I did an iperf test between the VM and
> >>> host A with the feature enabled and during the test I have unplugged the sriov
> >>> device, the device was unplugged successfully and no drops where observed as
> >>> you can see in the results below:
> >>>
> >>> [root@dhcp156-44 ~]# ifconfig
> >> Well I suspect this won't tell you anything, this shows packet drops at
> >> the hardware level. When e.g. link is down linux won't send any packets
> >> out. The simplest test is to monitor latency and throughput and see that
> >> while it is lower for the duration of migration, there are no huge
> >> spikes around the switch.
> > Oh, okay will do that.
> >
> > I have noticed some nasty lag when I tried to ssh to the VM using the
> > failover interface while I didn't experience that with the e1000.
> > Sridhar Any idea what might be the cause?
> >
> When using failover interface, i guess you have the VF interface plugged in and UP.
> So you should be using the primary interface.
>
> Do you see the VFs MAC configured correctly at the host PF?
> You can do
>      ip link show dev <pf>
> and it should show the MACs of all the VFs associated with that PF.
You are correct, the vf mac was zet to all zeroes, it can be set by
using "ip link set ens2f0 vf 1 mac 8a:f7:20:29:3b:cb" for example
[root@virtlab517 netkvm_dev]#  ip link show dev ens2f0
2: ens2f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq master
test_br0 state UP mode DEFAULT group default qlen 1000
    link/ether f8:f2:1e:33:43:30 brd ff:ff:ff:ff:ff:ff
    vf 0 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
    vf 1 MAC 8a:f7:20:29:3b:cb, spoof checking on, link-state auto, trust off
    vf 2 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
    vf 3 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
    vf 4 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
    vf 5 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
    vf 6 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off
    vf 7 MAC 00:00:00:00:00:00, spoof checking on, link-state auto, trust off

I have tried the same test above now but with Iperf test and ping from
the VM to Host B and during the test I eject the primary device using
device_del command. This is the same mechanism which my implementation
does during migration, however, the traffic is lost now as you can see
below. Did you test the failover interface with such scenarios ?

[root@dhcp156-44 ~]# ifconfig
ens3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.19.156.44  netmask 255.255.248.0  broadcast 10.19.159.255
        inet6 2620:52:0:1398:9699:325b:25f9:e7bb  prefixlen 64
scopeid 0x0<global>
        inet6 fe80::d306:561f:9f43:ff77  prefixlen 64  scopeid 0x20<link>
        ether 56:cc:c1:01:cc:21  txqueuelen 1000  (Ethernet)
        RX packets 55201  bytes 3496532 (3.3 MiB)
        RX errors 72  dropped 0  overruns 0  frame 72
        TX packets 738  bytes 70323 (68.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.17  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::bc87:86b8:bc86:be4e  prefixlen 64  scopeid 0x20<link>
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 41260  bytes 3067573 (2.9 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1156043  bytes 1749160131 (1.6 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens6: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 40183  bytes 2848249 (2.7 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1156043  bytes 1749160131 (1.6 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4nsby: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 1077  bytes 219324 (214.1 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 3  bytes 264 (264.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3  bytes 264 (264.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

_____________________________________________________________________________________________________________________________________

[root@dhcp156-44 ~]# iperf -c 192.168.1.118 -t 100 -i 1
------------------------------------------------------------
Client connecting to 192.168.1.118, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.17 port 42210 connected with 192.168.1.118 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3]  1.0- 2.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3]  2.0- 3.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3]  3.0- 4.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3]  4.0- 5.0 sec  1.09 GBytes  9.40 Gbits/sec
[  3]  5.0- 6.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3]  6.0- 7.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3]  7.0- 8.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3]  8.0- 9.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3]  9.0-10.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 10.0-11.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 11.0-12.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 12.0-13.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 13.0-14.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 14.0-15.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 15.0-16.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 16.0-17.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 17.0-18.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 18.0-19.0 sec  1.09 GBytes  9.40 Gbits/sec
[  3] 19.0-20.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 20.0-21.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 21.0-22.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 22.0-23.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 23.0-24.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 24.0-25.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 25.0-26.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 26.0-27.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 27.0-28.0 sec  1.10 GBytes  9.42 Gbits/sec
[  3] 28.0-29.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 29.0-30.0 sec  1.10 GBytes  9.41 Gbits/sec
[  3] 30.0-31.0 sec   318 MBytes  2.66 Gbits/sec
[  3] 31.0-32.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 32.0-33.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 33.0-34.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 34.0-35.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 35.0-36.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 36.0-37.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 37.0-38.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 38.0-39.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 39.0-40.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 40.0-41.0 sec  0.00 Bytes  0.00 bits/sec
[  3] 41.0-42.0 sec  0.00 Bytes  0.00 bits/sec
^C[  3] 42.0-43.0 sec  0.00 Bytes  0.00 bits/sec
[  3]  0.0-43.4 sec  33.2 GBytes  6.57 Gbits/sec
_____________________________________________________________________________________________________________________________________
[root@dhcp156-44 ~]# ping 192.168.1.118
PING 192.168.1.118 (192.168.1.118) 56(84) bytes of data.
64 bytes from 192.168.1.118: icmp_seq=1 ttl=64 time=0.264 ms
64 bytes from 192.168.1.118: icmp_seq=2 ttl=64 time=0.167 ms
64 bytes from 192.168.1.118: icmp_seq=3 ttl=64 time=0.168 ms
64 bytes from 192.168.1.118: icmp_seq=4 ttl=64 time=0.174 ms
64 bytes from 192.168.1.118: icmp_seq=5 ttl=64 time=0.168 ms
64 bytes from 192.168.1.118: icmp_seq=6 ttl=64 time=0.282 ms
64 bytes from 192.168.1.118: icmp_seq=7 ttl=64 time=0.179 ms
64 bytes from 192.168.1.118: icmp_seq=8 ttl=64 time=0.141 ms
64 bytes from 192.168.1.118: icmp_seq=9 ttl=64 time=0.165 ms
64 bytes from 192.168.1.118: icmp_seq=10 ttl=64 time=0.168 ms
64 bytes from 192.168.1.118: icmp_seq=11 ttl=64 time=0.153 ms
64 bytes from 192.168.1.118: icmp_seq=12 ttl=64 time=0.296 ms
64 bytes from 192.168.1.118: icmp_seq=13 ttl=64 time=0.258 ms
64 bytes from 192.168.1.118: icmp_seq=14 ttl=64 time=0.236 ms
64 bytes from 192.168.1.118: icmp_seq=15 ttl=64 time=0.190 ms
64 bytes from 192.168.1.118: icmp_seq=16 ttl=64 time=0.245 ms
64 bytes from 192.168.1.118: icmp_seq=17 ttl=64 time=0.187 ms
64 bytes from 192.168.1.118: icmp_seq=18 ttl=64 time=0.222 ms
64 bytes from 192.168.1.118: icmp_seq=19 ttl=64 time=0.231 ms
64 bytes from 192.168.1.118: icmp_seq=20 ttl=64 time=0.279 ms
64 bytes from 192.168.1.118: icmp_seq=21 ttl=64 time=0.271 ms
64 bytes from 192.168.1.118: icmp_seq=22 ttl=64 time=0.319 ms
64 bytes from 192.168.1.118: icmp_seq=23 ttl=64 time=0.350 ms
64 bytes from 192.168.1.118: icmp_seq=24 ttl=64 time=0.311 ms
64 bytes from 192.168.1.118: icmp_seq=25 ttl=64 time=0.249 ms
64 bytes from 192.168.1.118: icmp_seq=26 ttl=64 time=0.258 ms
64 bytes from 192.168.1.118: icmp_seq=27 ttl=64 time=0.220 ms
64 bytes from 192.168.1.118: icmp_seq=28 ttl=64 time=0.299 ms
64 bytes from 192.168.1.118: icmp_seq=29 ttl=64 time=0.281 ms
64 bytes from 192.168.1.118: icmp_seq=30 ttl=64 time=0.271 ms
64 bytes from 192.168.1.118: icmp_seq=31 ttl=64 time=0.241 ms
64 bytes from 192.168.1.118: icmp_seq=32 ttl=64 time=0.245 ms
64 bytes from 192.168.1.118: icmp_seq=33 ttl=64 time=0.245 ms
64 bytes from 192.168.1.118: icmp_seq=34 ttl=64 time=0.287 ms
64 bytes from 192.168.1.118: icmp_seq=35 ttl=64 time=0.322 ms
64 bytes from 192.168.1.118: icmp_seq=36 ttl=64 time=0.247 ms
64 bytes from 192.168.1.118: icmp_seq=37 ttl=64 time=0.316 ms
64 bytes from 192.168.1.118: icmp_seq=38 ttl=64 time=0.255 ms
64 bytes from 192.168.1.118: icmp_seq=39 ttl=64 time=0.308 ms
64 bytes from 192.168.1.118: icmp_seq=40 ttl=64 time=0.250 ms
64 bytes from 192.168.1.118: icmp_seq=41 ttl=64 time=0.260 ms


^C
--- 192.168.1.118 ping statistics ---
63 packets transmitted, 41 received, 34.9206% packet loss, time 568ms
rtt min/avg/max/mdev = 0.141/0.243/0.350/0.054 ms



>
>
>


-- 
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

