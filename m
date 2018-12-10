Return-Path: virtio-dev-return-5154-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C42F0985B26
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Dec 2018 15:35:06 +0000 (UTC)
MIME-Version: 1.0
References: <20181128123424-mutt-send-email-mst@kernel.org>
 <0a81c110-610e-2183-3483-95faf53c3fce@intel.com> <20181128135154-mutt-send-email-mst@kernel.org>
 <1aeab969-f47f-42c3-31a0-b4c5df647d58@oracle.com> <20181128195226-mutt-send-email-mst@kernel.org>
 <cca54913-42c0-55bf-986e-8670c49fb8fe@oracle.com> <20181129160950-mutt-send-email-mst@kernel.org>
 <2f44fe5e-ee7d-96cd-dd85-f663fa04c7d0@oracle.com> <20181130004530-mutt-send-email-mst@kernel.org>
 <3035130f-ad02-39d7-a897-aec3a3f2fee5@oracle.com> <20181203224508-mutt-send-email-mst@kernel.org>
 <CAKPgXcF-GXoi99pk5VeLe=vN2QZZutedrLqCRMJpdZrowyj7jw@mail.gmail.com>
 <04533475-3f34-8c49-9758-0c261c20a2eb@oracle.com> <CAKPgXcG660qgcEsGCNXzbvM8nH_QtzYGwZV07Qny=XQ--LA8Rg@mail.gmail.com>
In-Reply-To: <CAKPgXcG660qgcEsGCNXzbvM8nH_QtzYGwZV07Qny=XQ--LA8Rg@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 10 Dec 2018 17:34:53 +0200
Message-ID: <CAKPgXcFB1qFibgZDSQNNiKFfrGtwnYKbb38vCpVujyxX8mMiYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY feature
To: si-wei.liu@oracle.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, sridhar.samudrala@intel.com, carolyn.wyborny@intel.com, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>, jesse.brandeburg@intel.com, boris.ostrovsky@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 10, 2018 at 5:13 PM Sameeh Jubran <sameeh@daynix.com> wrote:
>
> On Sat, Dec 8, 2018 at 3:54 AM si-wei liu <si-wei.liu@oracle.com> wrote:
> >
> >
> >
> > On 12/05/2018 08:18 AM, Sameeh Jubran wrote:
> > > Hi all,
> > >
> > > This is a followup on the discussion in the DPDK and Virtio monthly meeting.
> > >
> > > Michael suggested that layer 2 tests should be created in order to
> > > test the PF/VF behavior in different scenarios without using VMs at
> > > all which should speed up the testing process.
> > >
> > > The following "mausezahn" tool - which is part of netsniff-ng package
> > > - can be used in order to generate layer 2 packets as follows:
> > >
> > > mausezahn enp59s0 -c 0 -a rand -b 20:71:c6:2a:68:38 "08 00 aa bb cc dd"
> > >
> > > The packets can be sniffed using tcpdump or netsniff-ng.
> > Does tcpdump or netsniff-ng enable NIC's promiscuous mode by default?
> > Try disable it when you monitor/capture the L2 packets.
> netsniff-ng enables promiscuous mode by default, however the -M flag
> can disable this.
>
> >
> > >
> > > I am not completely sure how the setup should look like on the host,
> > > but here is a script which assigns macvlan to the PF and sets it's mac
> > > address to be the same as the VF mac address. The scripts assumes that
> > > the sriov is already configured and the vf are present.
> > >
> > > [root@wsfd-advnetlab10 ~]# cat go_macvlan.sh
> > > MACVLAN_NAME=macvlan0
> > > PF_NAME=enp59s0
> > > VF_NUMBER=1
> > > MAC_ADDR=20:71:c6:2a:68:38
> > >
> > > echo "$PF_NAME vf status before setting mac"
> > > ip link show dev $PF_NAME
> > > ip link set $PF_NAME vf $VF_NUMBER mac $MAC_ADDR
> > > ip li add link $PF_NAME $MACVLAN_NAME address $MAC_ADDR type macvlan
> > > ip link set $PF_NAME up
> > > echo "$PF_NAME vf status after setting mac"
> > > ip link show dev $PF_NAME
> > >
> > > Please share your thoughts on how the different test scenarios should
> > > go, I can customize the scripts further more and host them somewhere.
> > You can do something like below:
> >
> > FAKE_VLAN=123
> > ip link set $MACVLAN_NAME up
> > ip link set $PF_NAME vf $VF_NUMBER vlan $FAKE_VLAN
> >
> > Datapath now switched to macvlan0, which should get the L2 packets from
> > over the wire.
> >
> > ip link set $PF_NAME vf $VF_NUMBER vlan 0
> > ip link set $MACVLAN_NAME down
> >
> > Datapath now switched back to VF. VF#1 should get packets.
> >
> > For a more accurate downtime test, replace 'ip link set vf .. vlan ...'
> > to unbind VF from the original driver and bind it to vfio-pci.
> Yup.

The only issue that I'm not sure on how to deal with, is how to listen
to the packets on the vf. How can I make sure that they are arriving
there?

> >
> >
> > Regards,
> > -Siwei
> >
> > >
> > > On Tue, Dec 4, 2018 at 5:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >> On Mon, Dec 03, 2018 at 06:09:19PM -0800, si-wei liu wrote:
> > >>>> I agree. But a single flag is not much of an extension. We don't even
> > >>>> need it in netlink, can be anywhere in e.g. sysfs.
> > >>> I think sysfs attribute is for exposing the capability, while you still need
> > >>> to set up macvtap with some special mode via netlink. That way it doesn't
> > >>> break current behavior, and when VF's MAC filter is added macvtap would need
> > >>> to react to remove the filter from NIC. And add the one back when VF's MAC
> > >>> is removed.
> > >> All this will be up to the developers actually working on it. My
> > >> understanding is that intel is going to just change the behaviour
> > >> unconditionally, and it's already the case for Mellanox.
> > >> That creates a critical mass large enough that maybe others
> > >> just need to confirm.
> > >>
> > >> ...
> > >>
> > >>
> > >>>> Meanwhile what's missing and was missing all along for the change you
> > >>>> seem to be advocating for to get off the ground is people who
> > >>>> are ready to actually send e.g. spec, guest driver, test patches.
> > >>> Partly because it hadn't been converged to the best way to do it (even the
> > >>> group ID mechanism with PCI bridge can address our need you don't seem to
> > >>> think it is valuable). The in-kernel approach is fine at its appearance, but
> > >>> I personally don't believe changing every legacy driver is the way to go.
> > >>> It's the choice of implementation and what has been implemented in those
> > >>> drivers today IMHO is nothing wrong.
> > >> It's not a question of being wrong as such.
> > >> A standard behaviour is clearly better than each driver doing its
> > >> own thing which is the case now. As long as we ar standardizing,
> > >> let's standardize on something that matches our needs?
> > >> But I really see no problem with also supporting other options,
> > >> as long as someone is prepared to actually put in the work.
> > >>
> > >>
> > >>>>>>     Still this assumes just creating a VF
> > >>>>>> doesn't yet program the on-card filter to cause packet drops.
> > >>>>> Suppose this behavior is fixable in legacy Intel NIC, you would still need
> > >>>>> to evacuate the filter programmed by macvtap previously when VF's filter
> > >>>>> gets activated (typically when VF's netdev is netif_running() in a Linux
> > >>>>> guest). That's what we and NetVSC call as "datapath switching", and where
> > >>>>> this could be handled (driver, net core, or userspace) is the core for the
> > >>>>> architectural design that I spent much time on.
> > >>>>>
> > >>>>> Having said it, I don't expect or would desperately wait on one vendor to
> > >>>>> fix a legacy driver which wasn't quite motivated, then no work would be done
> > >>>>> on that.
> > >>>> Then that device can't be used with the mechanism in question.
> > >>>> Or if there are lots of drivers like this maybe someone will be
> > >>>> motivated enough to post a better implementation with a new
> > >>>> feature bit. It's not that I'm arguing against that.
> > >>>>
> > >>>> But given the options of teaching management to play with
> > >>>> netlink API in response to guest actions, and with VCPU stopped,
> > >>>> and doing it all in host kernel drivers, I know I'll prefer host kernel
> > >>>> changes.
> > >>> We have some internal patches that leverage management to respond to various
> > >>> guest actions. If you're interested we can post them. The thing is no one
> > >>> would like to work on the libvirt changes, while internally we have our own
> > >>> orchestration software which is not libvirt. But if you think it's fine we
> > >>> can definitely share our QEMU patches while leaving out libvirt.
> > >>>
> > >>> Thanks,
> > >>> -Siwei
> > >> Sure, why not.
> > >>
> > >> The following is generally necessary for any virtio project to happen:
> > >> - guest patches
> > >> - qemu patches
> > >> - spec documentation
> > >>
> > >> Some extras are sometimes a dependency, e.g. host kernel patches.
> > >>
> > >>
> > >> Typically at least two of these are enough for people to
> > >> be able to figure out how things work.
> > >>
> > >>
> > >>
> > >>
> > >>>>> If you'd go the way, please make sure Intel could change their
> > >>>>> driver first.
> > >>>> We'll see what happens with that. It's Sridhar from intel that implemented
> > >>>> the guest changes after all, so I expect he's motivated to make them
> > >>>> work well.
> > >>>>
> > >>>>
> > >>>>>>     Let's
> > >>>>>> assume drivers are fixed to do that. How does userspace know
> > >>>>>> that's the case? We might need some kind of attribute so
> > >>>>>> userspace can detect it.
> > >>>>> Where do you envision the new attribute could be at? Supposedly it'd be
> > >>>>> exposed by the kernel, which constitutes a new API or API changes.
> > >>>>>
> > >>>>>
> > >>>>> Thanks,
> > >>>>> -Siwei
> > >>>> People add e.g. new attributes in sysfs left and right.  It's unlikely
> > >>>> to be a matter of serious contention.
> > >>>>
> > >>>>>>>> Question is how does userspace know driver isn't broken in this respect?
> > >>>>>>>> Let's add a "vf failover" flag somewhere so this can be probed?
> > >>>>>>>>
> > >>>> ---------------------------------------------------------------------
> > >>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > >>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >>>>
> > >
> > >
> >
>
>
> --
> Respectfully,
> Sameeh Jubran
> Linkedin
> Software Engineer @ Daynix.



-- 
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

