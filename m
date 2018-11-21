Return-Path: virtio-dev-return-5007-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF3A9985C96
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Nov 2018 15:39:54 +0000 (UTC)
MIME-Version: 1.0
References: <20180919230502-mutt-send-email-mst@kernel.org>
 <CADGSJ22OybVCOsBmqdAHLPBU0PKF13xWz3YtHT=Pw5bT_a71BA@mail.gmail.com>
 <20180920220951-mutt-send-email-mst@kernel.org> <CADGSJ23GRrt25k1G9wD3JhA6en4MuXLE9WA24Ep8PLgkyk_4=A@mail.gmail.com>
 <20180927121739-mutt-send-email-mst@kernel.org> <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org> <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org> <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
 <20181018233115-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181018233115-mutt-send-email-mst@kernel.org>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 21 Nov 2018 17:39:38 +0200
Message-ID: <CAKPgXcH4mokJd7MeTUNjoGzo6Lbyx72cOQPLfKccQLwVHSMArg@mail.gmail.com>
Content-Type: multipart/alternative; boundary="00000000000095e64e057b2e8f4f"
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, sridhar.samudrala@intel.com, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--00000000000095e64e057b2e8f4f
Content-Type: text/plain; charset="UTF-8"

Hi all,

It's been a while since the last discussion here. I have been working on
implementing the standby feature in Qemu. I have tried multiple approaches
for implementation and in the end decided to implement using the
hotplug/unplug infrastructure for multiple reasons which I'll go over when
I send the patches. For now you can find the implementation here:
https://github.com/sameehj/qemu/tree/failover_hidden_opts (the full command
line I used can be found at the end of the email)

I have tested my implementation in Qemu with Fedora 29 guest, I can see the
failover interface successfully and assign an ip to it. The feature is
acked and the primary device is plugged in with no issues.

I have created a setup which has two hosts (host A and host B) with X710
10G cards connected back to back. On one host (I'll refer to this host as
host A) I have configured a bridge with the PF interface as well as
vitio-net's interface (standby) both attached to it. I ran the guest with
the patched Qemu on host A and pinged the bridge successfully, I also have
a ping between host A and Host B, however, I can't ping host B from the VM
and vice versa, this only happens when the feature is enabled for some
reason I have yet to figure out.

I haven't tested migration yet, but on my way to do so.

Since I couldn't ping from VM to host B, I did an iperf test between the VM
and host A with the feature enabled and during the test I have unplugged
the sriov device, the device was unplugged successfully and no drops where
observed as you can see in the results below:

[root@dhcp156-44 ~]# ifconfig
ens3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.19.156.44  netmask 255.255.248.0  broadcast 10.19.159.255
        inet6 fe80::d306:561f:9f43:ff77  prefixlen 64  scopeid 0x20<link>
        inet6 2620:52:0:1398:9699:325b:25f9:e7bb  prefixlen 64  scopeid
0x0<global>
        ether 56:cc:c1:01:cc:21  txqueuelen 1000  (Ethernet)
        RX packets 12258  bytes 870822 (850.4 KiB)
        RX errors 11  dropped 0  overruns 0  frame 11
        TX packets 294  bytes 32432 (31.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.17  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::bc87:86b8:bc86:be4e  prefixlen 64  scopeid 0x20<link>
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 41052  bytes 2775833 (2.6 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 47468  bytes 15629 (15.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens6: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 214  bytes 14966 (14.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 163  bytes 26498 (25.8 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4nsby: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 41052  bytes 2775833 (2.6 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 47468  bytes 2889827541 (2.6 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 176  bytes 19712 (19.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 176  bytes 19712 (19.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[root@dhcp156-44 ~]# iperf -c 192.168.1.117 -t 100 -i 1
------------------------------------------------------------
Client connecting to 192.168.1.117, TCP port 5001
TCP window size: 85.0 KByte (default)
------------------------------------------------------------
[  3] local 192.168.1.17 port 40368 connected with 192.168.1.117 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0- 1.0 sec  3.47 GBytes  29.8 Gbits/sec
[  3]  1.0- 2.0 sec  4.35 GBytes  37.4 Gbits/sec
[  3]  2.0- 3.0 sec  4.10 GBytes  35.2 Gbits/sec
[  3]  3.0- 4.0 sec  4.20 GBytes  36.1 Gbits/sec
[  3]  4.0- 5.0 sec  4.20 GBytes  36.1 Gbits/sec
[  3]  5.0- 6.0 sec  4.07 GBytes  34.9 Gbits/sec
[  3]  6.0- 7.0 sec  4.53 GBytes  38.9 Gbits/sec
[  3]  7.0- 8.0 sec  4.38 GBytes  37.6 Gbits/sec
[  3]  8.0- 9.0 sec  4.60 GBytes  39.5 Gbits/sec
[  3]  9.0-10.0 sec  4.60 GBytes  39.5 Gbits/sec
[  3] 10.0-11.0 sec  4.56 GBytes  39.2 Gbits/sec
[  3] 11.0-12.0 sec  4.70 GBytes  40.4 Gbits/sec
[  3] 12.0-13.0 sec  4.65 GBytes  39.9 Gbits/sec
[  3] 13.0-14.0 sec  4.51 GBytes  38.7 Gbits/sec
[  3] 14.0-15.0 sec  4.48 GBytes  38.5 Gbits/sec
[  3] 15.0-16.0 sec  4.67 GBytes  40.2 Gbits/sec
[  3] 16.0-17.0 sec  4.37 GBytes  37.5 Gbits/sec
[  3] 17.0-18.0 sec  4.68 GBytes  40.2 Gbits/sec
[  3] 18.0-19.0 sec  4.99 GBytes  42.9 Gbits/sec
[  3] 19.0-20.0 sec  5.00 GBytes  42.9 Gbits/sec
[  3] 20.0-21.0 sec  4.90 GBytes  42.1 Gbits/sec
[  3] 21.0-22.0 sec  4.72 GBytes  40.5 Gbits/sec
[  3] 22.0-23.0 sec  4.60 GBytes  39.5 Gbits/sec
[  3] 23.0-24.0 sec  4.72 GBytes  40.6 Gbits/sec
[  3] 24.0-25.0 sec  4.42 GBytes  38.0 Gbits/sec
[  3] 25.0-26.0 sec  4.44 GBytes  38.2 Gbits/sec
[  3] 26.0-27.0 sec  4.18 GBytes  35.9 Gbits/sec
[  3] 27.0-28.0 sec  4.20 GBytes  36.1 Gbits/sec
[  3] 28.0-29.0 sec  4.27 GBytes  36.7 Gbits/sec
[  3] 29.0-30.0 sec  4.16 GBytes  35.7 Gbits/sec
[  3] 30.0-31.0 sec  4.14 GBytes  35.6 Gbits/sec
[  3] 31.0-32.0 sec  4.13 GBytes  35.4 Gbits/sec
[  3] 32.0-33.0 sec  4.16 GBytes  35.7 Gbits/sec
[  3] 33.0-34.0 sec  4.33 GBytes  37.2 Gbits/sec
[  3] 34.0-35.0 sec  4.31 GBytes  37.0 Gbits/sec
[  3] 35.0-36.0 sec  4.26 GBytes  36.6 Gbits/sec
[  3] 36.0-37.0 sec  4.36 GBytes  37.5 Gbits/sec
[  3] 37.0-38.0 sec  4.11 GBytes  35.3 Gbits/sec
[  3] 38.0-39.0 sec  4.00 GBytes  34.4 Gbits/sec
[  3] 39.0-40.0 sec  4.53 GBytes  38.9 Gbits/sec
[  3] 40.0-41.0 sec  4.06 GBytes  34.9 Gbits/sec
[  3] 41.0-42.0 sec  4.17 GBytes  35.8 Gbits/sec
[  3] 42.0-43.0 sec  4.14 GBytes  35.6 Gbits/sec
[  3] 43.0-44.0 sec  4.07 GBytes  34.9 Gbits/sec
^C[  3]  0.0-44.5 sec   195 GBytes  37.5 Gbits/sec
[root@dhcp156-44 ~]# ifconfig
ens3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.19.156.44  netmask 255.255.248.0  broadcast 10.19.159.255
        inet6 fe80::d306:561f:9f43:ff77  prefixlen 64  scopeid 0x20<link>
        inet6 2620:52:0:1398:9699:325b:25f9:e7bb  prefixlen 64  scopeid
0x0<global>
        ether 56:cc:c1:01:cc:21  txqueuelen 1000  (Ethernet)
        RX packets 12547  bytes 889713 (868.8 KiB)
        RX errors 11  dropped 0  overruns 0  frame 11
        TX packets 373  bytes 45723 (44.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.17  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::bc87:86b8:bc86:be4e  prefixlen 64  scopeid 0x20<link>
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 2862498  bytes 192898865 (183.9 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3414905  bytes 209192841687 (194.8 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4nsby: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 8a:f7:20:29:3b:cb  txqueuelen 1000  (Ethernet)
        RX packets 2862498  bytes 192898865 (183.9 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3414905  bytes 212082653599 (197.5 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 176  bytes 19712 (19.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 176  bytes 19712 (19.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

__________________________________________________________________________________________________________________

The command line I used:

/root/qemu/x86_64-softmmu/qemu-system-x86_64 \
-netdev
tap,id=hostnet0,script=world_bridge_standalone.sh,downscript=no,ifname=cc17
\
-device e1000,netdev=hostnet0,mac=56:cc:c1:01:cc:21,id=cc17 \
-netdev
tap,vhost=on,id=hostnet1,script=test_bridge_standalone.sh,downscript=no,ifname=cc1_72,queues=4
\
-device
virtio-net,host_mtu=1500,netdev=hostnet1,mac=8a:f7:20:29:3b:cb,id=cc1_72,vectors=10,mq=on,primary=cc1_71
\
-device vfio-pci,host=65:02.1,id=cc1_71,standby=cc1_72 \
-enable-kvm \
-name netkvm \
-m 3000M \
-drive file=/dev/shm/fedora_29.qcow2,if=ide,id=drivex \
-smp 4 \
-vga qxl \
-spice port=6110,disable-ticketing \
-device virtio-serial-pci,id=virtio-serial0,max_ports=16,bus=pci.0,addr=0x7
\
-chardev spicevmc,name=vdagent,id=vdagent \
-device
virtserialport,nr=1,bus=virtio-serial0.0,chardev=vdagent,name=com.redhat.spice.0
\
-chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
-device virtio-serial \
-device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
-monitor stdio


On Fri, Oct 19, 2018 at 6:45 AM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Oct 10, 2018 at 06:26:50PM -0700, Siwei Liu wrote:
> > On Fri, Oct 5, 2018 at 12:18 PM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > >
> > > On Thu, Oct 04, 2018 at 05:03:14PM -0700, Siwei Liu wrote:
> > > > On Tue, Oct 2, 2018 at 5:43 AM Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > > > >
> > > > > On Tue, Oct 02, 2018 at 01:42:09AM -0700, Siwei Liu wrote:
> > > > > > The VF's MAC can be updated by PF/host on the fly at any time.
> One can
> > > > > > start with a random MAC but use group ID to pair device instead.
> And
> > > > > > only update MAC address to the real one when moving MAC filter
> around
> > > > > > after PV says OK to switch datapath.
> > > > > >
> > > > > > Do you see any problem with this design?
> > > > >
> > > > > Isn't this what I proposed:
> > > > >         Maybe we can
> > > > >         start VF with a temporary MAC, then change it to a final
> one when guest
> > > > >         tries to use it. It will work but we run into fact that
> MACs are
> > > > >         currently programmed by mgmnt - in many setups qemu does
> not have the
> > > > >         rights to do it.
> > > > >
> > > > > ?
> > > > >
> > > > > If yes I don't see a problem with the interface design, even though
> > > > > implementation wise it's more work as it will have to include
> management
> > > > > changes.
> > > >
> > > > I thought we discussed this design a while back:
> > > > https://www.spinics.net/lists/netdev/msg512232.html
> > > >
> > > > ... plug in a VF with a random MAC filter programmed in prior, and
> > > > initially use that random MAC within guest. This would require:
> > > > a) not relying on permanent MAC address to do pairing during the
> > > > initial discovery, e.g. use the failover group ID as in this
> > > > discussion
> > > > b) host to toggle the MAC address filter: which includes taking down
> > > > the tap device to return the MAC back to PF, followed by assigning
> > > > that MAC to VF using "ip link ... set vf ..."
> > > > c) notify guest to reload/reset VF driver for the change of hardware
> MAC address
> > > > d) until VF reloads the driver it won't be able to use the datapath,
> > > > so very short period of network outage is (still) expected
> > > >
> > > > though I still don't think this design can elimnate downtime.
> > >
> > >
> > > No, my idea is somewhat different. As you say there is a problem
> > > of delay at point (c).
> > That's true, I never say the downtime can be avoided because of this
> > delay in the guest side. But with this the downtime gets to the bare
> > minimum and in most situations packets won't be lost on reception as
> > long as the PF sets up the filter in timely manner.
>
> It's not really the bare minimum IMHO. E.g. fixing the PF to
> defer filter update will give you less downtime.
>
> > > Further, the need to poke at PF filters
> > > with set vf does not match the current security model where
> > > any security related configuration such as MAC filtering is done
> upfront.
> >
> > The security model belongs to the VM policy not the VF, right? I think
> > same MAC address will always be used on the VM as it starts with
> > virtio. Why it is a security issue that VF starts with an unused MAC
> > before it's able to be used in the guest?
>
> Basically if guest is able to trigger MAC changes,
> it might be able to exploit some bug to escalate that to
> full network access. Completely blocking configuration
> changes after setup feels safer.
>
> Case in point, with QEMU a typical selinux policy will block
> attempts to change MACs, that task will have to be
> delegated to a suitably priveledged tool.
>
>
> >
> > >
> > >
> > > So I have two suggestions:
> > >
> > > 1. Teach pf driver not to program the filter until vf driver actually
> goes up.
> > >
> > >    How do we know it went up? For example, it is highly likely
> > >    that driver will send some kind of command on init.
> > >    E.g. linux seems to always try to set the mac address during init.
> > >    We can have any kind of command received by the PF enable
> > >    the filter, until reset.
> >
> > I'm not sure it's a valid assumption for any guest, say Windows. The
> > VF can start with the MAC address advertised from PF in the first
> > reset, and the MAC filter generally will be activated at that point.
> > Some other PF/VF variants enable the filter after that until the VF is
> > brought up in guest, while some others enable the filter even before
> > the VF gets assigned to guest. Trying to assume the behaviour on
> > specific guest or specific NIC device is a slippery slope.
>
>
> Is all this just theoretical or do you observe any problems in practice?
>
> > The only
> > thing that's reliable is the semantics of ndo_vf_xxx interface for the
> > PF.
>
> ndo_vf_xxx is an internal Linux interface. That's not guaranteed to be
> stable at all. I think you mean the netlink interface that triggers
> that. That should be stable but if what you say above is true isn't
> fully defined.
>
> > You seem to overly assume too much on the specific PF behaviour
> > which is not defined in the interface itself.
>
> So IMHO it's something that we should fix in Linux,
> making all devices behave consistently.
>
> > >
> > >    In absence of an appropriate command, QEMU can detect bus master
> > >    enable and do that.
> > >
> > > 2. Create a variant of trusted VF where it starts out without a valid
> > >    MAC, guest can set a softmac MAC but only can set it to the specific
> > >    value that matches virtio.
> > >    Alternatively - if it's preferred for some reason - allow
> > >    guest to program just two MACs, the original one and the virtio one.
> > >    Any other value is denied.
> >
> > I am getting confused, I don't know why that's even needed. The
> > management tool can set any predefined MAC that is deemed safe for VF
> > to start with. Why it needs to be that complicated? What is the
> > purpose of another model for trusted VF and softmac? It's the PF that
> > changes the MAC not the VF.
>
> This will give us a simple solution without guest driver changes for
> when VF is trusted. In particular it will work e.g. for PFs as well.
>
> > >
> > >
> > >
> > > > However,
> > > > it looks like as of today the MAC matching still haven't addressed
> the
> > > > datapath switching and error handling in a clean way. As said, for
> > > > SR-IOV live migration on iSCSI root disk there will be a lot of
> > > > dancing parts going along the way, reliable network connectity and
> > > > dedicated handshakes are critical to this kind of setup.
> > > >
> > > > -Siwei
> > >
> > > I think MAC matching removes downtime when device is removed but not
> > > when it's re-added, yes. It has the advantage of an already present
> > > linux driver support, but if you are prepared to work on
> > > adding e.g. bridge based matching, that will go away.
> >
> > The removal order and consequence will be the same between MAC
> > matching and group ID based matching. It's just the initial discovery
> > that's slightly different. Why do you think the downtime will be
> > different for the removal scenario? And why do you think it's needed
> > to alter the current PF driver behavior to support bridge based
> > matching? Sorry I'm really confused about your suggestion. Those PF
> > driver model changes are not needed acutally. The fact is that the
> > bridge based matching is supposed to work quite well for any PF driver
> > implementation no matter when the MAC address filters gets added or
> > enabled.
> >
> > Thanks,
> > -Siwei
>
> It seems that it requires a bunch of changes for all VF drivers
> though.
>
> >
> > >
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > > > >
> ---------------------------------------------------------------------
> > > > > To unsubscribe, e-mail:
> virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > For additional commands, e-mail:
> virtio-dev-help@lists.oasis-open.org
> > > > >
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>

-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*

--00000000000095e64e057b2e8f4f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi all,<br><br>It&#39;s been a while sinc=
e the last discussion here. I have been working on implementing the standby=
 feature in Qemu. I have tried multiple approaches for implementation and i=
n the end decided to implement using the hotplug/unplug infrastructure for =
multiple reasons which I&#39;ll go over when I send the patches. For now yo=
u can find the implementation here:<div><div><a href=3D"https://github.com/=
sameehj/qemu/tree/failover_hidden_opts">https://github.com/sameehj/qemu/tre=
e/failover_hidden_opts</a>=C2=A0(the full command line I used can be found =
at the end of the email)</div><div><br></div><div>I have tested my implemen=
tation in Qemu with Fedora 29 guest, I can see the failover interface succe=
ssfully and assign an ip to it. The feature is acked and the primary device=
 is plugged in with no issues.</div><div><br></div><div>I have created a se=
tup which has two hosts (host A and host B) with X710 10G cards=C2=A0connec=
ted back to back. On one host (I&#39;ll refer to this host as host A) I hav=
e configured a bridge with the PF interface as well as vitio-net&#39;s inte=
rface (standby) both attached to it. I ran the guest with the patched Qemu =
on host A and pinged the bridge successfully, I also have a ping between ho=
st A and Host B, however, I can&#39;t ping host B from the VM and vice vers=
a, this only happens when the feature is enabled for some reason I have yet=
 to figure out.</div><div><br></div><div>I haven&#39;t tested migration yet=
, but on my way to do so.</div><div><br></div><div>Since I couldn&#39;t pin=
g from VM to host B, I did an iperf test between the VM and host A with the=
 feature enabled and during the test I have unplugged the sriov device, the=
 device was unplugged successfully and no drops where observed as you can s=
ee in the results below:</div><div><br>[root@dhcp156-44 ~]# ifconfig<br>ens=
3: flags=3D4163&lt;UP,BROADCAST,RUNNING,MULTICAST&gt; =C2=A0mtu 1500<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 inet 10.19.156.44 =C2=A0netmask 255.255.248.0 =C2=
=A0broadcast 10.19.159.255<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fe80::d306:=
561f:9f43:ff77 =C2=A0prefixlen 64 =C2=A0scopeid 0x20&lt;link&gt;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 inet6 2620:52:0:1398:9699:325b:25f9:e7bb =C2=A0prefixl=
en 64 =C2=A0scopeid 0x0&lt;global&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether =
56:cc:c1:01:cc:21 =C2=A0txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 RX packets 12258 =C2=A0bytes 870822 (850.4 KiB)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 RX errors 11 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame=
 11<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 294 =C2=A0bytes 32432 (31.6 K=
iB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =
=C2=A0carrier 0 =C2=A0collisions 0<br><br>ens4: flags=3D4163&lt;UP,BROADCAS=
T,RUNNING,MULTICAST&gt; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet =
192.168.1.17 =C2=A0netmask 255.255.255.0 =C2=A0broadcast 192.168.1.255<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fe80::bc87:86b8:bc86:be4e =C2=A0prefixlen=
 64 =C2=A0scopeid 0x20&lt;link&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether 8a:=
f7:20:29:3b:cb =C2=A0txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RX packets 41052 =C2=A0bytes 2775833 (2.6 MiB)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 47468 =C2=A0bytes 15629 (15.2 KiB)<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=
=A0carrier 0 =C2=A0collisions 0<br><br>ens6: flags=3D4163&lt;UP,BROADCAST,R=
UNNING,MULTICAST&gt; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether 8a=
:f7:20:29:3b:cb =C2=A0txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RX packets 214 =C2=A0bytes 14966 (14.6 KiB)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 163 =C2=A0bytes 26498 (25.8 KiB)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=A0ca=
rrier 0 =C2=A0collisions 0<br><br>ens4nsby: flags=3D4163&lt;UP,BROADCAST,RU=
NNING,MULTICAST&gt; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether 8a:=
f7:20:29:3b:cb =C2=A0txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RX packets 41052 =C2=A0bytes 2775833 (2.6 MiB)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 47468 =C2=A0bytes 2889827541 (2.6 G=
iB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =
=C2=A0carrier 0 =C2=A0collisions 0<br><br>lo: flags=3D73&lt;UP,LOOPBACK,RUN=
NING&gt; =C2=A0mtu 65536<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet 127.0.0.1 =C2=
=A0netmask 255.0.0.0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 ::1 =C2=A0prefixl=
en 128 =C2=A0scopeid 0x10&lt;host&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 loop =
=C2=A0txqueuelen 1000 =C2=A0(Local Loopback)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 RX packets 176 =C2=A0bytes 19712 (19.2 KiB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TX packets 176 =C2=A0bytes 19712 (19.2 KiB)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=A0carrier 0 =
=C2=A0collisions 0<br><br>[root@dhcp156-44 ~]# iperf -c 192.168.1.117 -t 10=
0 -i 1<br>------------------------------------------------------------<br>C=
lient connecting to 192.168.1.117, TCP port 5001<br>TCP window size: 85.0 K=
Byte (default)<br>---------------------------------------------------------=
---<br>[ =C2=A03] local 192.168.1.17 port 40368 connected with 192.168.1.11=
7 port 5001<br>[ ID] Interval =C2=A0 =C2=A0 =C2=A0 Transfer =C2=A0 =C2=A0 B=
andwidth<br>[ =C2=A03] =C2=A00.0- 1.0 sec =C2=A03.47 GBytes =C2=A029.8 Gbit=
s/sec<br>[ =C2=A03] =C2=A01.0- 2.0 sec =C2=A04.35 GBytes =C2=A037.4 Gbits/s=
ec<br>[ =C2=A03] =C2=A02.0- 3.0 sec =C2=A04.10 GBytes =C2=A035.2 Gbits/sec<=
br>[ =C2=A03] =C2=A03.0- 4.0 sec =C2=A04.20 GBytes =C2=A036.1 Gbits/sec<br>=
[ =C2=A03] =C2=A04.0- 5.0 sec =C2=A04.20 GBytes =C2=A036.1 Gbits/sec<br>[ =
=C2=A03] =C2=A05.0- 6.0 sec =C2=A04.07 GBytes =C2=A034.9 Gbits/sec<br>[ =C2=
=A03] =C2=A06.0- 7.0 sec =C2=A04.53 GBytes =C2=A038.9 Gbits/sec<br>[ =C2=A0=
3] =C2=A07.0- 8.0 sec =C2=A04.38 GBytes =C2=A037.6 Gbits/sec<br>[ =C2=A03] =
=C2=A08.0- 9.0 sec =C2=A04.60 GBytes =C2=A039.5 Gbits/sec<br>[ =C2=A03] =C2=
=A09.0-10.0 sec =C2=A04.60 GBytes =C2=A039.5 Gbits/sec<br>[ =C2=A03] 10.0-1=
1.0 sec =C2=A04.56 GBytes =C2=A039.2 Gbits/sec<br>[ =C2=A03] 11.0-12.0 sec =
=C2=A04.70 GBytes =C2=A040.4 Gbits/sec<br>[ =C2=A03] 12.0-13.0 sec =C2=A04.=
65 GBytes =C2=A039.9 Gbits/sec<br>[ =C2=A03] 13.0-14.0 sec =C2=A04.51 GByte=
s =C2=A038.7 Gbits/sec<br>[ =C2=A03] 14.0-15.0 sec =C2=A04.48 GBytes =C2=A0=
38.5 Gbits/sec<br>[ =C2=A03] 15.0-16.0 sec =C2=A04.67 GBytes =C2=A040.2 Gbi=
ts/sec<br>[ =C2=A03] 16.0-17.0 sec =C2=A04.37 GBytes =C2=A037.5 Gbits/sec<b=
r>[ =C2=A03] 17.0-18.0 sec =C2=A04.68 GBytes =C2=A040.2 Gbits/sec<br>[ =C2=
=A03] 18.0-19.0 sec =C2=A04.99 GBytes =C2=A042.9 Gbits/sec<br>[ =C2=A03] 19=
.0-20.0 sec =C2=A05.00 GBytes =C2=A042.9 Gbits/sec<br>[ =C2=A03] 20.0-21.0 =
sec =C2=A04.90 GBytes =C2=A042.1 Gbits/sec<br>[ =C2=A03] 21.0-22.0 sec =C2=
=A04.72 GBytes =C2=A040.5 Gbits/sec<br>[ =C2=A03] 22.0-23.0 sec =C2=A04.60 =
GBytes =C2=A039.5 Gbits/sec<br>[ =C2=A03] 23.0-24.0 sec =C2=A04.72 GBytes =
=C2=A040.6 Gbits/sec<br>[ =C2=A03] 24.0-25.0 sec =C2=A04.42 GBytes =C2=A038=
.0 Gbits/sec<br>[ =C2=A03] 25.0-26.0 sec =C2=A04.44 GBytes =C2=A038.2 Gbits=
/sec<br>[ =C2=A03] 26.0-27.0 sec =C2=A04.18 GBytes =C2=A035.9 Gbits/sec<br>=
[ =C2=A03] 27.0-28.0 sec =C2=A04.20 GBytes =C2=A036.1 Gbits/sec<br>[ =C2=A0=
3] 28.0-29.0 sec =C2=A04.27 GBytes =C2=A036.7 Gbits/sec<br>[ =C2=A03] 29.0-=
30.0 sec =C2=A04.16 GBytes =C2=A035.7 Gbits/sec<br>[ =C2=A03] 30.0-31.0 sec=
 =C2=A04.14 GBytes =C2=A035.6 Gbits/sec<br>[ =C2=A03] 31.0-32.0 sec =C2=A04=
.13 GBytes =C2=A035.4 Gbits/sec<br>[ =C2=A03] 32.0-33.0 sec =C2=A04.16 GByt=
es =C2=A035.7 Gbits/sec<br>[ =C2=A03] 33.0-34.0 sec =C2=A04.33 GBytes =C2=
=A037.2 Gbits/sec<br>[ =C2=A03] 34.0-35.0 sec =C2=A04.31 GBytes =C2=A037.0 =
Gbits/sec<br>[ =C2=A03] 35.0-36.0 sec =C2=A04.26 GBytes =C2=A036.6 Gbits/se=
c<br>[ =C2=A03] 36.0-37.0 sec =C2=A04.36 GBytes =C2=A037.5 Gbits/sec<br>[ =
=C2=A03] 37.0-38.0 sec =C2=A04.11 GBytes =C2=A035.3 Gbits/sec<br>[ =C2=A03]=
 38.0-39.0 sec =C2=A04.00 GBytes =C2=A034.4 Gbits/sec<br>[ =C2=A03] 39.0-40=
.0 sec =C2=A04.53 GBytes =C2=A038.9 Gbits/sec<br>[ =C2=A03] 40.0-41.0 sec =
=C2=A04.06 GBytes =C2=A034.9 Gbits/sec<br>[ =C2=A03] 41.0-42.0 sec =C2=A04.=
17 GBytes =C2=A035.8 Gbits/sec<br>[ =C2=A03] 42.0-43.0 sec =C2=A04.14 GByte=
s =C2=A035.6 Gbits/sec<br>[ =C2=A03] 43.0-44.0 sec =C2=A04.07 GBytes =C2=A0=
34.9 Gbits/sec<br>^C[ =C2=A03] =C2=A00.0-44.5 sec =C2=A0 195 GBytes =C2=A03=
7.5 Gbits/sec<br>[root@dhcp156-44 ~]# ifconfig<br>ens3: flags=3D4163&lt;UP,=
BROADCAST,RUNNING,MULTICAST&gt; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 inet 10.19.156.44 =C2=A0netmask 255.255.248.0 =C2=A0broadcast 10.19.159=
.255<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fe80::d306:561f:9f43:ff77 =C2=A0p=
refixlen 64 =C2=A0scopeid 0x20&lt;link&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 i=
net6 2620:52:0:1398:9699:325b:25f9:e7bb =C2=A0prefixlen 64 =C2=A0scopeid 0x=
0&lt;global&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether 56:cc:c1:01:cc:21 =C2=
=A0txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX packe=
ts 12547 =C2=A0bytes 889713 (868.8 KiB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX e=
rrors 11 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 11<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TX packets 373 =C2=A0bytes 45723 (44.6 KiB)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=A0carrier 0 =C2=A0=
collisions 0<br><br>ens4: flags=3D4163&lt;UP,BROADCAST,RUNNING,MULTICAST&gt=
; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet 192.168.1.17 =C2=A0net=
mask 255.255.255.0 =C2=A0broadcast 192.168.1.255<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 inet6 fe80::bc87:86b8:bc86:be4e =C2=A0prefixlen 64 =C2=A0scopeid 0x2=
0&lt;link&gt;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether 8a:f7:20:29:3b:cb =C2=A0=
txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX packets =
2862498 =C2=A0bytes 192898865 (183.9 MiB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 RX=
 errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TX packets 3414905 =C2=A0bytes 209192841687 (194.8 GiB)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=A0ca=
rrier 0 =C2=A0collisions 0<br><br>ens4nsby: flags=3D4163&lt;UP,BROADCAST,RU=
NNING,MULTICAST&gt; =C2=A0mtu 1500<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 ether 8a:=
f7:20:29:3b:cb =C2=A0txqueuelen 1000 =C2=A0(Ethernet)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 RX packets 2862498 =C2=A0bytes 192898865 (183.9 MiB)<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0fra=
me 0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 3414905 =C2=A0bytes 21208265=
3599 (197.5 GiB)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0=
 overruns 0 =C2=A0carrier 0 =C2=A0collisions 0<br><br>lo: flags=3D73&lt;UP,=
LOOPBACK,RUNNING&gt; =C2=A0mtu 65536<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet 12=
7.0.0.1 =C2=A0netmask 255.0.0.0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 ::1 =
=C2=A0prefixlen 128 =C2=A0scopeid 0x10&lt;host&gt;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 loop =C2=A0txqueuelen 1000 =C2=A0(Local Loopback)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 RX packets 176 =C2=A0bytes 19712 (19.2 KiB)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0 =C2=A0frame 0<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 176 =C2=A0bytes 19712 (19.2 KiB)<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=A0c=
arrier 0 =C2=A0collisions 0</div></div><div><br></div><div>________________=
___________________________________________________________________________=
_______________________</div><div><div><br class=3D"gmail-Apple-interchange=
-newline">The command line I used:</div><div><br></div><div><div>/root/qemu=
/x86_64-softmmu/qemu-system-x86_64 \</div><div>-netdev tap,id=3Dhostnet0,sc=
ript=3Dworld_bridge_standalone.sh,downscript=3Dno,ifname=3Dcc17 \</div><div=
>-device e1000,netdev=3Dhostnet0,mac=3D56:cc:c1:01:cc:21,id=3Dcc17 \</div><=
div>-netdev tap,vhost=3Don,id=3Dhostnet1,script=3Dtest_bridge_standalone.sh=
,downscript=3Dno,ifname=3Dcc1_72,queues=3D4 \</div><div>-device virtio-net,=
host_mtu=3D1500,netdev=3Dhostnet1,mac=3D8a:f7:20:29:3b:cb,id=3Dcc1_72,vecto=
rs=3D10,mq=3Don,primary=3Dcc1_71 \</div><div>-device vfio-pci,host=3D65:02.=
1,id=3Dcc1_71,standby=3Dcc1_72 \</div><div>-enable-kvm \</div><div>-name ne=
tkvm \</div><div>-m 3000M \</div><div>-drive file=3D/dev/shm/fedora_29.qcow=
2,if=3Dide,id=3Ddrivex \</div><div>-smp 4 \</div><div>-vga qxl \</div><div>=
-spice port=3D6110,disable-ticketing \</div><div>-device virtio-serial-pci,=
id=3Dvirtio-serial0,max_ports=3D16,bus=3Dpci.0,addr=3D0x7 \</div><div>-char=
dev spicevmc,name=3Dvdagent,id=3Dvdagent \</div><div>-device virtserialport=
,nr=3D1,bus=3Dvirtio-serial0.0,chardev=3Dvdagent,name=3Dcom.redhat.spice.0 =
\</div><div>-chardev socket,path=3D/tmp/qga.sock,server,nowait,id=3Dqga0 \<=
/div><div>-device virtio-serial \</div><div>-device virtserialport,chardev=
=3Dqga0,name=3Dorg.qemu.guest_agent.0 \</div><div>-monitor stdio</div></div=
></div></div></div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On F=
ri, Oct 19, 2018 at 6:45 AM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@re=
dhat.com">mst@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">On Wed, Oct 10, 2018 at 06:26:50PM -0700, Siwei Liu wrote:<br>
&gt; On Fri, Oct 5, 2018 at 12:18 PM Michael S. Tsirkin &lt;<a href=3D"mail=
to:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Thu, Oct 04, 2018 at 05:03:14PM -0700, Siwei Liu wrote:<br>
&gt; &gt; &gt; On Tue, Oct 2, 2018 at 5:43 AM Michael S. Tsirkin &lt;<a hre=
f=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:=
<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Tue, Oct 02, 2018 at 01:42:09AM -0700, Siwei Liu wro=
te:<br>
&gt; &gt; &gt; &gt; &gt; The VF&#39;s MAC can be updated by PF/host on the =
fly at any time. One can<br>
&gt; &gt; &gt; &gt; &gt; start with a random MAC but use group ID to pair d=
evice instead. And<br>
&gt; &gt; &gt; &gt; &gt; only update MAC address to the real one when movin=
g MAC filter around<br>
&gt; &gt; &gt; &gt; &gt; after PV says OK to switch datapath.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Do you see any problem with this design?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Isn&#39;t this what I proposed:<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Maybe we can<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start VF with a tempor=
ary MAC, then change it to a final one when guest<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tries to use it. It wi=
ll work but we run into fact that MACs are<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0currently programmed b=
y mgmnt - in many setups qemu does not have the<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rights to do it.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; ?<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; If yes I don&#39;t see a problem with the interface des=
ign, even though<br>
&gt; &gt; &gt; &gt; implementation wise it&#39;s more work as it will have =
to include management<br>
&gt; &gt; &gt; &gt; changes.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I thought we discussed this design a while back:<br>
&gt; &gt; &gt; <a href=3D"https://www.spinics.net/lists/netdev/msg512232.ht=
ml" rel=3D"noreferrer" target=3D"_blank">https://www.spinics.net/lists/netd=
ev/msg512232.html</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ... plug in a VF with a random MAC filter programmed in prio=
r, and<br>
&gt; &gt; &gt; initially use that random MAC within guest. This would requi=
re:<br>
&gt; &gt; &gt; a) not relying on permanent MAC address to do pairing during=
 the<br>
&gt; &gt; &gt; initial discovery, e.g. use the failover group ID as in this=
<br>
&gt; &gt; &gt; discussion<br>
&gt; &gt; &gt; b) host to toggle the MAC address filter: which includes tak=
ing down<br>
&gt; &gt; &gt; the tap device to return the MAC back to PF, followed by ass=
igning<br>
&gt; &gt; &gt; that MAC to VF using &quot;ip link ... set vf ...&quot;<br>
&gt; &gt; &gt; c) notify guest to reload/reset VF driver for the change of =
hardware MAC address<br>
&gt; &gt; &gt; d) until VF reloads the driver it won&#39;t be able to use t=
he datapath,<br>
&gt; &gt; &gt; so very short period of network outage is (still) expected<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; though I still don&#39;t think this design can elimnate down=
time.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; No, my idea is somewhat different. As you say there is a problem<=
br>
&gt; &gt; of delay at point (c).<br>
&gt; That&#39;s true, I never say the downtime can be avoided because of th=
is<br>
&gt; delay in the guest side. But with this the downtime gets to the bare<b=
r>
&gt; minimum and in most situations packets won&#39;t be lost on reception =
as<br>
&gt; long as the PF sets up the filter in timely manner.<br>
<br>
It&#39;s not really the bare minimum IMHO. E.g. fixing the PF to<br>
defer filter update will give you less downtime.<br>
<br>
&gt; &gt; Further, the need to poke at PF filters<br>
&gt; &gt; with set vf does not match the current security model where<br>
&gt; &gt; any security related configuration such as MAC filtering is done =
upfront.<br>
&gt; <br>
&gt; The security model belongs to the VM policy not the VF, right? I think=
<br>
&gt; same MAC address will always be used on the VM as it starts with<br>
&gt; virtio. Why it is a security issue that VF starts with an unused MAC<b=
r>
&gt; before it&#39;s able to be used in the guest?<br>
<br>
Basically if guest is able to trigger MAC changes,<br>
it might be able to exploit some bug to escalate that to<br>
full network access. Completely blocking configuration<br>
changes after setup feels safer.<br>
<br>
Case in point, with QEMU a typical selinux policy will block<br>
attempts to change MACs, that task will have to be<br>
delegated to a suitably priveledged tool.<br>
<br>
<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; So I have two suggestions:<br>
&gt; &gt;<br>
&gt; &gt; 1. Teach pf driver not to program the filter until vf driver actu=
ally goes up.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 How do we know it went up? For example, it is highly=
 likely<br>
&gt; &gt;=C2=A0 =C2=A0 that driver will send some kind of command on init.<=
br>
&gt; &gt;=C2=A0 =C2=A0 E.g. linux seems to always try to set the mac addres=
s during init.<br>
&gt; &gt;=C2=A0 =C2=A0 We can have any kind of command received by the PF e=
nable<br>
&gt; &gt;=C2=A0 =C2=A0 the filter, until reset.<br>
&gt; <br>
&gt; I&#39;m not sure it&#39;s a valid assumption for any guest, say Window=
s. The<br>
&gt; VF can start with the MAC address advertised from PF in the first<br>
&gt; reset, and the MAC filter generally will be activated at that point.<b=
r>
&gt; Some other PF/VF variants enable the filter after that until the VF is=
<br>
&gt; brought up in guest, while some others enable the filter even before<b=
r>
&gt; the VF gets assigned to guest. Trying to assume the behaviour on<br>
&gt; specific guest or specific NIC device is a slippery slope.<br>
<br>
<br>
Is all this just theoretical or do you observe any problems in practice?<br=
>
<br>
&gt; The only<br>
&gt; thing that&#39;s reliable is the semantics of ndo_vf_xxx interface for=
 the<br>
&gt; PF.<br>
<br>
ndo_vf_xxx is an internal Linux interface. That&#39;s not guaranteed to be<=
br>
stable at all. I think you mean the netlink interface that triggers<br>
that. That should be stable but if what you say above is true isn&#39;t<br>
fully defined.<br>
<br>
&gt; You seem to overly assume too much on the specific PF behaviour<br>
&gt; which is not defined in the interface itself.<br>
<br>
So IMHO it&#39;s something that we should fix in Linux,<br>
making all devices behave consistently.<br>
<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 In absence of an appropriate command, QEMU can detec=
t bus master<br>
&gt; &gt;=C2=A0 =C2=A0 enable and do that.<br>
&gt; &gt;<br>
&gt; &gt; 2. Create a variant of trusted VF where it starts out without a v=
alid<br>
&gt; &gt;=C2=A0 =C2=A0 MAC, guest can set a softmac MAC but only can set it=
 to the specific<br>
&gt; &gt;=C2=A0 =C2=A0 value that matches virtio.<br>
&gt; &gt;=C2=A0 =C2=A0 Alternatively - if it&#39;s preferred for some reaso=
n - allow<br>
&gt; &gt;=C2=A0 =C2=A0 guest to program just two MACs, the original one and=
 the virtio one.<br>
&gt; &gt;=C2=A0 =C2=A0 Any other value is denied.<br>
&gt; <br>
&gt; I am getting confused, I don&#39;t know why that&#39;s even needed. Th=
e<br>
&gt; management tool can set any predefined MAC that is deemed safe for VF<=
br>
&gt; to start with. Why it needs to be that complicated? What is the<br>
&gt; purpose of another model for trusted VF and softmac? It&#39;s the PF t=
hat<br>
&gt; changes the MAC not the VF.<br>
<br>
This will give us a simple solution without guest driver changes for<br>
when VF is trusted. In particular it will work e.g. for PFs as well.<br>
<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; However,<br>
&gt; &gt; &gt; it looks like as of today the MAC matching still haven&#39;t=
 addressed the<br>
&gt; &gt; &gt; datapath switching and error handling in a clean way. As sai=
d, for<br>
&gt; &gt; &gt; SR-IOV live migration on iSCSI root disk there will be a lot=
 of<br>
&gt; &gt; &gt; dancing parts going along the way, reliable network connecti=
ty and<br>
&gt; &gt; &gt; dedicated handshakes are critical to this kind of setup.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -Siwei<br>
&gt; &gt;<br>
&gt; &gt; I think MAC matching removes downtime when device is removed but =
not<br>
&gt; &gt; when it&#39;s re-added, yes. It has the advantage of an already p=
resent<br>
&gt; &gt; linux driver support, but if you are prepared to work on<br>
&gt; &gt; adding e.g. bridge based matching, that will go away.<br>
&gt; <br>
&gt; The removal order and consequence will be the same between MAC<br>
&gt; matching and group ID based matching. It&#39;s just the initial discov=
ery<br>
&gt; that&#39;s slightly different. Why do you think the downtime will be<b=
r>
&gt; different for the removal scenario? And why do you think it&#39;s need=
ed<br>
&gt; to alter the current PF driver behavior to support bridge based<br>
&gt; matching? Sorry I&#39;m really confused about your suggestion. Those P=
F<br>
&gt; driver model changes are not needed acutally. The fact is that the<br>
&gt; bridge based matching is supposed to work quite well for any PF driver=
<br>
&gt; implementation no matter when the MAC address filters gets added or<br=
>
&gt; enabled.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; -Siwei<br>
<br>
It seems that it requires a bunch of changes for all VF drivers<br>
though.<br>
<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; MST<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -------------------------------------------------------=
--------------<br>
&gt; &gt; &gt; &gt; To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-un=
subscribe@lists.oasis-open.org" target=3D"_blank">virtio-dev-unsubscribe@li=
sts.oasis-open.org</a><br>
&gt; &gt; &gt; &gt; For additional commands, e-mail: <a href=3D"mailto:virt=
io-dev-help@lists.oasis-open.org" target=3D"_blank">virtio-dev-help@lists.o=
asis-open.org</a><br>
&gt; &gt; &gt; &gt;<br>
<br>
---------------------------------------------------------------------<br>
To unsubscribe, e-mail: <a href=3D"mailto:virtio-dev-unsubscribe@lists.oasi=
s-open.org" target=3D"_blank">virtio-dev-unsubscribe@lists.oasis-open.org</=
a><br>
For additional commands, e-mail: <a href=3D"mailto:virtio-dev-help@lists.oa=
sis-open.org" target=3D"_blank">virtio-dev-help@lists.oasis-open.org</a><br=
>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><font=
 size=3D"4" color=3D"#0b5394" face=3D"times new roman, serif">Respectfully,=
<br></font><div style=3D"font-size:12.8px;color:rgb(136,136,136)"><font siz=
e=3D"4" color=3D"#0b5394" face=3D"times new roman, serif"><b><i>Sameeh Jubr=
an</i></b></font></div><div style=3D"font-size:12.8px;color:rgb(136,136,136=
)"><i style=3D"color:rgb(7,55,99);font-family:&quot;times new roman&quot;,s=
erif;font-size:large"><span style=3D"line-height:15px"><a href=3D"https://i=
l.linkedin.com/pub/sameeh-jubran/87/747/a8a" title=3D"View public profile" =
name=3D"SignatureSanitizer_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_I=
D_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_UNIQUE_ID_SafeHtmlFilter_14e2c1de=
96f8c195_UNIQUE_ID_SafeHtmlFilter_SafeHtmlFilter_SafeHtmlFilter_webProfileU=
RL" style=3D"color:rgb(17,85,204);margin:0px;padding:0px;border-width:0px;o=
utline:none;vertical-align:baseline;text-decoration:none" target=3D"_blank"=
>Linkedin</a></span></i><br></div><div style=3D"font-size:12.8px;color:rgb(=
136,136,136)"><font size=3D"4" face=3D"times new roman, serif" color=3D"#07=
3763"><i>Software Engineer @ <a href=3D"http://www.daynix.com" target=3D"_b=
lank">Daynix</a>.</i></font></div></div></div></div></div></div></div></div=
></div>

--00000000000095e64e057b2e8f4f--

