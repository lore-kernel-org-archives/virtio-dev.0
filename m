Return-Path: virtio-dev-return-5013-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C05A985CB2
	for <virtio-dev@lists.oasis-open.org>; Thu, 22 Nov 2018 18:27:15 +0000 (UTC)
Date: Thu, 22 Nov 2018 13:27:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181122132626-mutt-send-email-mst@kernel.org>
References: <20180927121739-mutt-send-email-mst@kernel.org>
 <CADGSJ22JC9asjQ3nVV5e-ajxB-pggJ6ToMGqG072Q5TvFVCKBQ@mail.gmail.com>
 <20181002083928-mutt-send-email-mst@kernel.org>
 <CADGSJ23NaaPXrgoL1-ySs=SWytE65SORatOFMSapzFsKZUH4yA@mail.gmail.com>
 <20181005101419-mutt-send-email-mst@kernel.org>
 <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
 <20181018233115-mutt-send-email-mst@kernel.org>
 <CAKPgXcH4mokJd7MeTUNjoGzo6Lbyx72cOQPLfKccQLwVHSMArg@mail.gmail.com>
 <20181121124246-mutt-send-email-mst@kernel.org>
 <CAKPgXcH2D4XcUNoS6tvDfLxPAv05u7Yu77OYxRnuFFfgN34A_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPgXcH2D4XcUNoS6tvDfLxPAv05u7Yu77OYxRnuFFfgN34A_w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Sameeh Jubran <sameeh@daynix.com>
Cc: Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, sridhar.samudrala@intel.com, virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 21, 2018 at 10:04:53PM +0200, Sameeh Jubran wrote:
> On Wed, Nov 21, 2018 at 8:41 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Great to see you making progress on this!
> > Some comments below:
> >
> > On Wed, Nov 21, 2018 at 05:39:38PM +0200, Sameeh Jubran wrote:
> > > I have created a setup which has two hosts (host A and host B) with X710 10G
> > > cards connected back to back. On one host (I'll refer to this host as host A) I
> > > have configured a bridge with the PF interface as well as vitio-net's interface
> > > (standby) both attached to it.
> >
> > ...
> >
> > > The command line I used:
> > >
> > > /root/qemu/x86_64-softmmu/qemu-system-x86_64 \
> > > -netdev tap,id=hostnet0,script=world_bridge_standalone.sh,downscript=no,ifname=
> > > cc17 \
> > > -device e1000,netdev=hostnet0,mac=56:cc:c1:01:cc:21,id=cc17 \
> >
> > What's e1000 doing here?
> > Can this be reason you can not talk to host?
> I don't think so, the e1000 is for enabling WAN connection on the
> guest for downloading packages and ssh connection. It is connected to
> a separate bridge which is connected to the external interface of the
> host.
> >
> > > -netdev tap,vhost=on,id=hostnet1,script=test_bridge_standalone.sh,downscript=
> > > no,ifname=cc1_72,queues=4 \
> > > -device virtio-net,host_mtu=1500,netdev=hostnet1,mac=8a:f7:20:29:3b:cb,id=
> > > cc1_72,vectors=10,mq=on,primary=cc1_71 \
> > > -device vfio-pci,host=65:02.1,id=cc1_71,standby=cc1_72 \
> > > -enable-kvm \
> > > -name netkvm \
> > > -m 3000M \
> > > -drive file=/dev/shm/fedora_29.qcow2,if=ide,id=drivex \
> > > -smp 4 \
> > > -vga qxl \
> > > -spice port=6110,disable-ticketing \
> > > -device virtio-serial-pci,id=virtio-serial0,max_ports=16,bus=pci.0,addr=0x7 \
> > > -chardev spicevmc,name=vdagent,id=vdagent \
> > > -device virtserialport,nr=1,bus=virtio-serial0.0,chardev=vdagent,name=
> > > com.redhat.spice.0 \
> > > -chardev socket,path=/tmp/qga.sock,server,nowait,id=qga0 \
> > > -device virtio-serial \
> > > -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0 \
> > > -monitor stdio
> >
> >
> > ...
> >
> > > Since I couldn't ping from VM to host B, I did an iperf test between the VM and
> > > host A with the feature enabled and during the test I have unplugged the sriov
> > > device, the device was unplugged successfully and no drops where observed as
> > > you can see in the results below:
> > >
> > > [root@dhcp156-44 ~]# ifconfig
> >
> > Well I suspect this won't tell you anything, this shows packet drops at
> > the hardware level. When e.g. link is down linux won't send any packets
> > out. The simplest test is to monitor latency and throughput and see that
> > while it is lower for the duration of migration, there are no huge
> > spikes around the switch.
> Oh, okay will do that.
> 
> I have noticed some nasty lag when I tried to ssh to the VM using the
> failover interface while I didn't experience that with the e1000.
> Sridhar Any idea what might be the cause?

Try tcpdump?

> >
> > --
> > MST
> 
> 
> 
> -- 
> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

