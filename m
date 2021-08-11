Return-Path: <virtio-dev-return-8514-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 044BB9863F8
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Aug 2021 15:26:54 +0000 (UTC)
Date: Wed, 11 Aug 2021 16:26:41 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20210811152641.GX6592@e120937-lin>
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <YROY6YntswWxfaub@google.com>
MIME-Version: 1.0
In-Reply-To: <YROY6YntswWxfaub@google.com>
Subject: [virtio-dev] Re: [PATCH v6 00/17] Introduce SCMI transport based on VirtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Floris Westermann <westermann@google.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, sudeep.holla@arm.com, james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com, f.fainelli@gmail.com, etienne.carriere@linaro.org, vincent.guittot@linaro.org, souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com, alex.bennee@linaro.org, jean-philippe@linaro.org, mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com, Vasyl.Vavrychuk@opensynergy.com, Andriy.Tryshnivskyy@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Aug 11, 2021 at 09:31:21AM +0000, Floris Westermann wrote:
> Hi Cristian,
> 

Hi Floris,

> I am currently working on an interface for VMs to communicate their
> performance requirements to the hosts by passing through cpu frequency
> adjustments.
> 

So something like looking up SCMI requests from VMs in the hypervisor
and act on VM underlying hw accordingly ? Where the SCMI server is meant
to live ?

> Your patch looks very interesting but I have some questions:
> 

Happy to hear that, a new V7 (with minor cleanups) which is (hopefully)
being pulled these days is at:

https://lore.kernel.org/linux-arm-kernel/20210803131024.40280-1-cristian.marussi@arm.com/
> 
> On Mon, Jul 12, 2021 at 03:18:16PM +0100, Cristian Marussi wrote:
> >
> > The series has been tested using an emulated fake SCMI device and also a
> > proper SCP-fw stack running through QEMU vhost-users, with the SCMI stack
> > compiled, in both cases, as builtin and as a loadable module, running tests
> > against mocked SCMI Sensors using HWMON and IIO interfaces to check the
> > functionality of notifications and sync/async commands.
> >
> > Virtio-scmi support has been exercised in the following testing scenario
> > on a JUNO board:
> >
> >  - normal sync/async command transfers
> >  - notifications
> >  - concurrent delivery of correlated response and delayed responses
> >  - out-of-order delivery of delayed responses before related responses
> >  - unexpected delayed response delivery for sync commands
> >  - late delivery of timed-out responses and delayed responses
> >
> > Some basic regression testing against mailbox transport has been performed
> > for commands and notifications too.
> >
> > No sensible overhead in total handling time of commands and notifications
> > has been observed, even though this series do indeed add a considerable
> > amount of code to execute on TX path.
> > More test and measurements could be needed in these regards.
> >
> 
> Can you share any data and benchmarks using you fake SCMI device.
> Also, could you provide the emulated device code so that the results can
> be reproduced.
> 

Not really, because the testing based on the fake SCMI VirtIO device was
purely functional, just to exercise some rare limit conditions not
easily reproducible with a regular SCMI stack, I've made no benchmark
using the fake emulated SCMI virtio device because it mimics VirtIO
transfers but there's not even an host/guest in my fake emulation.
Moreover is a hacked driver+userspace blob not really in a state to be
shared :P

While developing this series I needed somehow to be able to let the Kernel
SCMI-agent in the guest "speak" some basic SCMI commands and notifs to
some SCMI server platform sitting somewhere across the new VirtIO SCMI
transport, which basically means that it's not enough to create an SCMI
VirtIO device reachable from the VirtIO layer, the SCMI stack itself
(or part of it) must live behind such device somehow/somewhere to be
able to receive meaningful replies.

One proper way to do that is to use some QEMU/SCP-fw vhost-users support
cooked by Linaro (not in the upstream for now) so as to basically run a
full proper SCP SCMI-platform fw stack in host userspace and let it speak
to a guest through the new scmi virtio transport and the vhost-users magic:
the drawback of this kind of approach is that it made hard to test limit
conditions like stale or out-of-order SCMI replies because to do so you
have to patch the official SCP/SCMI stack to behave badly and out-of specs,
which is not something is designed to do. (and also the fact that the
vhost-users QEMU/SCP-fw solution was only available later during devel).
Hence the emulation hack for testing rare limit conditions.

Now, the emulation hack, beside really ugly, is clearly a totally fake
VirtIO environment (there's not even a guest really...) and, as said, it
just served the need to exercise the SCMI virtio transport code enough to
test anomalous and bad-behaving SCMI commands flows and notifications and
as such made really no sense to be used as a performance testbed.

In fact, what I was really meaning (poorly) while saying:

> > No sensible overhead in total handling time of commands and notifications
> > has been observed, even though this series do indeed add a considerable
> > amount of code to execute on TX path.

is that I have NOT seen any sensible overhead/slowdown in the context of
OTHER real SCMI transports (like mailboxes), because the virtio series
contains a number of preliminary SCMI common core changes unrelated to
virtio (monotonic tokens/handle concurrent and out-of-order replies) that,
even though easing the devel of SCMI virtio, are really needed and used
by any other existent SCMI transport, so my fear was to introduce some
common slowdown in the core: in those regards only, I said that I have
not seen (looking at cmd traces) any slowdown with such additional core
changes even though more code is clearly now run in the TX path.
(contention can indeed only happen under very rare limit conditions)

Having said that (sorry for the flood of words) what I can give you are
a few traces (non statistically significant probably) showing the typical
round-trip time for some plain SCMI command sensor requests on an idle
system (JUNO)

In both cases the sensors being read are mocked, so the time is purely
related to SCMI core stack and virtio exchanges (i.e. there's no delay
introduced by reading real hw sensors)


-> Using a proper SCP-fw/QEMU vhost-users stack:

root@deb-guest:~# cat /sys/class/hwmon/hwmon0/temp1_input 
             cat-195     [000] ....  7044.614295: scmi_xfer_begin: transfer_id=27 msg_id=6 protocol_id=21 seq=27 poll=0
25000
          <idle>-0       [000] d.h3  7044.615342: scmi_rx_done: transfer_id=27 msg_id=6 protocol_id=21 seq=27 msg_type=0
             cat-195     [000] ....  7044.615420: scmi_xfer_end: transfer_id=27 msg_id=6 protocol_id=21 seq=27 status=0

root@deb-guest:~# cat /sys/class/hwmon/hwmon0/temp1_input 
             cat-196     [000] ....  7049.200349: scmi_xfer_begin: transfer_id=28 msg_id=6 protocol_id=21 seq=28 poll=0
          <idle>-0       [000] d.h3  7049.202053: scmi_rx_done: transfer_id=28 msg_id=6 protocol_id=21 seq=28 msg_type=0
             cat-196     [000] ....  7049.202152: scmi_xfer_end: transfer_id=28 msg_id=6 protocol_id=21 seq=28 status=0
25000

root@deb-guest:~# cat /sys/class/hwmon/hwmon0/temp1_input 
             cat-197     [000] ....  7053.699713: scmi_xfer_begin: transfer_id=29 msg_id=6 protocol_id=21 seq=29 poll=0
25000
          <idle>-0       [000] d.H3  7053.700366: scmi_rx_done: transfer_id=29 msg_id=6 protocol_id=21 seq=29 msg_type=0
             cat-197     [000] ....  7053.700468: scmi_xfer_end: transfer_id=29 msg_id=6 protocol_id=21 seq=29 status=0

root@deb-guest:~# cat /sys/class/hwmon/hwmon0/temp1_input 
             cat-198     [001] ....  7058.944442: scmi_xfer_begin: transfer_id=30 msg_id=6 protocol_id=21 seq=30 poll=0
             cat-173     [000] d.h2  7058.944959: scmi_rx_done: transfer_id=30 msg_id=6 protocol_id=21 seq=30 msg_type=0
             cat-198     [001] ....  7058.945500: scmi_xfer_end: transfer_id=30 msg_id=6 protocol_id=21 seq=30 status=0
25000

root@deb-guest:~# cat /sys/class/hwmon/hwmon0/temp1_input 
             cat-199     [000] ....  7064.598797: scmi_xfer_begin: transfer_id=31 msg_id=6 protocol_id=21 seq=31 poll=0
25000
          <idle>-0       [000] d.h3  7064.599710: scmi_rx_done: transfer_id=31 msg_id=6 protocol_id=21 seq=31 msg_type=0
             cat-199     [000] ....  7064.599787: scmi_xfer_end: transfer_id=31 msg_id=6 protocol_id=21 seq=31 status=0



-> Using the fake hack SCMI device that relays packets to userspace:

             cat-1306    [000] ....  7614.373161: scmi_xfer_begin: transfer_id=78 msg_id=6 protocol_id=21 seq=78 poll=0
 scmi_sniffer_ng-342     [000] d.h2  7614.373699: scmi_rx_done: transfer_id=78 msg_id=6 protocol_id=21 seq=78 msg_type=0
             cat-1306    [000] ....  7614.377653: scmi_xfer_end: transfer_id=78 msg_id=6 protocol_id=21 seq=78 status=0


             cat-1308    [004] ....  7626.677176: scmi_xfer_begin: transfer_id=79 msg_id=6 protocol_id=21 seq=79 poll=0
 scmi_sniffer_ng-342     [000] d.h2  7626.677653: scmi_rx_done: transfer_id=79 msg_id=6 protocol_id=21 seq=79 msg_type=0
             cat-1308    [004] ....  7626.677705: scmi_xfer_end: transfer_id=79 msg_id=6 protocol_id=21 seq=79 status=0


             cat-1309    [004] ....  7631.249412: scmi_xfer_begin: transfer_id=80 msg_id=6 protocol_id=21 seq=80 poll=0
 scmi_sniffer_ng-342     [000] d.h2  7631.250182: scmi_rx_done: transfer_id=80 msg_id=6 protocol_id=21 seq=80 msg_type=0
             cat-1309    [004] ....  7631.250237: scmi_xfer_end: transfer_id=80 msg_id=6 protocol_id=21 seq=80 status=0

             cat-1312    [004] ....  7642.210034: scmi_xfer_begin: transfer_id=81 msg_id=6 protocol_id=21 seq=81 poll=0
 scmi_sniffer_ng-342     [000] d.h2  7642.210514: scmi_rx_done: transfer_id=81 msg_id=6 protocol_id=21 seq=81 msg_type=0
             cat-1312    [004] ....  7642.210567: scmi_xfer_end: transfer_id=81 msg_id=6 protocol_id=21 seq=81 status=0

             cat-1314    [003] ....  7645.810775: scmi_xfer_begin: transfer_id=82 msg_id=6 protocol_id=21 seq=82 poll=0
 scmi_sniffer_ng-342     [000] d.h2  7645.811255: scmi_rx_done: transfer_id=82 msg_id=6 protocol_id=21 seq=82 msg_type=0
             cat-1314    [003] ....  7645.811307: scmi_xfer_end: transfer_id=82 msg_id=6 protocol_id=21 seq=82 status=0


In both cases SCMI requests are effectively relayed to userspace so
that's probably the reason timings are similar. (despite the hackish
internals of latter solution)

Not sure if all the above madness helped you at all :D

Thanks,
Cristian


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

