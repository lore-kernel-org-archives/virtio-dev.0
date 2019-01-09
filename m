Return-Path: virtio-dev-return-5300-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AFF12985CEF
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 Jan 2019 13:39:43 +0000 (UTC)
Date: Wed, 9 Jan 2019 08:39:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190109083137-mutt-send-email-mst@kernel.org>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
 <20190107182604-mutt-send-email-mst@kernel.org>
 <7f230258-0950-9155-ec9c-6c6102ed2c2b@oracle.com>
 <20190107212122-mutt-send-email-mst@kernel.org>
 <96c1a360-3c21-a4ed-83ea-f094eeaf3b7c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <96c1a360-3c21-a4ed-83ea-f094eeaf3b7c@oracle.com>
Subject: Re: [virtio-dev] Re: [PATCH v3 0/5] Support for datapath switching
 during live migration
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, Liran Alon <liran.alon@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 08, 2019 at 08:55:35PM -0800, si-wei liu wrote:
>=20
>=20
> On 1/7/2019 6:25 PM, Michael S. Tsirkin wrote:
>=20
>     On Mon, Jan 07, 2019 at 05:45:22PM -0800, si-wei liu wrote:
>=20
>         On 01/07/2019 03:32 PM, Michael S. Tsirkin wrote:
>=20
>             On Mon, Jan 07, 2019 at 05:29:39PM -0500, Venu Busireddy wrot=
e:
>=20
>                 Implement the infrastructure to support datapath switchin=
g during live
>                 migration involving SR-IOV devices.
>=20
>                 1. This patch is based off on the current VIRTIO_NET_F_ST=
ANDBY feature
>                     bit and MAC address device pairing.
>=20
>                 2. This set of events will be consumed by userspace manag=
ement software
>                     to orchestrate all the hot plug and datapath switchin=
g activities.
>                     This scheme has the least QEMU modifications while al=
lowing userspace
>                     software to build its own intelligence to control the=
 whole process
>                     of SR-IOV live migration.
>=20
>                 3. While the hidden device model (viz. coupled device mod=
el) is still
>                     being explored for automatic hot plugging (QEMU) and =
automatic datapath
>                     switching (host-kernel), this series provides a suppl=
emental set
>                     of interfaces if management software wants to drive t=
he SR-IOV live
>                     migration on its own. It should not conflict with the=
 hidden device
>                     model but just offers simplicity of implementation.
>=20
>=20
>                 Si-Wei Liu (2):
>                    vfio-pci: Add FAILOVER_PRIMARY_CHANGED event to shorte=
n downtime during failover
>                    pci: query command extension to check the bus master e=
nabling status of the failover-primary device
>=20
>                 Sridhar Samudrala (1):
>                    virtio_net: Add VIRTIO_NET_F_STANDBY feature bit.
>=20
>                 Venu Busireddy (2):
>                    virtio_net: Add support for "Data Path Switching" duri=
ng Live Migration.
>                    virtio_net: Add a query command for FAILOVER_STANDBY_C=
HANGED event.
>=20
>                 ---
>                 Changes in v3:
>                    Fix issues with coding style in patch 3/5.
>=20
>                 Changes in v2:
>                    Added a query command for FAILOVER_STANDBY_CHANGED eve=
nt.
>                    Added a query command for FAILOVER_PRIMARY_CHANGED eve=
nt.
>=20
>             Hmm it looks like all feedback I sent e.g. here:
>             https://patchwork.kernel.org/patch/10721571/
>             got ignored.
>=20
>             To summarize I suggest reworking the series adding a new comm=
and along
>             the lines of (naming is up to you):
>=20
>             query-pci-master - this returns status for a device
>                                and enables a *single* event after
>                                it changes
>=20
>             and then removing all status data from the event,
>             just notify about the change and *only once*.
>=20
>         Why removing all status data from the event?
>=20
>     To make sure users do not forget to call query-pci-master to
>     re-enable more events.
>=20
> IMO the FAILOVER_PRIMARY_CHANGED event is on the performance path, it's an
> overkill to enforce round trip query for each event in normal situations.
>=20
>         It does not hurt to keep them
>         as the FAILOVER_PRIMARY_CHANGED event in general is of pretty low=
-frequency.
>=20
>     A malicious guest can make it as frequent as it wants to.
>     OTOH there is no way to limit.
>=20
> Will throttle the event rate (say, limiting to no more than 1 event per s=
econd)

And if guest *does* need the switch because e.g. attaching xdp wants to
resent the card?

> a way to limit (as opposed to control guest behavior) ? The other similar
> events that apply rate limiting don't suppress event emission until the n=
ext
> query at all.

We have some problematic interfaces already, that's true.

> Doing so would just cause more events missing. As stated in the
> earlier example, we should give guest NIC a chance to flush queued packet=
s even
> if ending state is same between two events.

I haven't seen that requirement. I guess a reset just stops processing
buffers rather than flush. Care to repeat?

>=20
>         As can be seen other similar low-frequent QMP events do have data=
 carried
>         over.
>=20
>         As this event relates to datapath switching, there's implication =
to coalesce
>         events as packets might not get a chance to send out as nothing w=
ould ever
>         happen when=A0 going through quick transitions like
>         disabled->enabled->disabled. I would allow at least few packets t=
o be sent
>         over wire rather than nothing. Who knows how fast management can =
react and
>         consume these events?
>=20
>         Thanks,
>         -Siwei
>=20
>     OK if it's so important for latency let's include data in the event.
>     Please add comments explaining that you must always re-run query
>     afterwards to make sure it's stable and re-enable more events.
>=20
> I can add comments describing why we need to carry data in the event, and=
 apply
> rate limiting to events. But I don't follow why it must suppress event un=
til
> next query.

Rate limiting is fundamentally broken.
Try a stress of resets and there goes your promise of low downtime.

Let me try to re-state: state query is fundamentally required
because otherwise e.g. management restarts do not work.
And it is much better to force management to run query every event
and every restart than just hope it handles racy corner cases correctly.

If we do include data in the event then there is no real latency cost to
that, since management can take action in response to the event then do
the query asynchronously at leasure.
So let me turn it around and say I don't follow why you have objections
to blocking following events until query.


>=20
> Thanks,
> -Siwei
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>             upon event management does query-pci-master
>             and acts accordingly.
>=20
>=20
>=20
>=20
>=20
>                   hmp.c                          |   5 +++
>                   hw/acpi/pcihp.c                |  27 +++++++++++
>                   hw/net/virtio-net.c            |  42 +++++++++++++++++
>                   hw/pci/pci.c                   |   5 +++
>                   hw/vfio/pci.c                  |  60 ++++++++++++++++++=
+++++++
>                   hw/vfio/pci.h                  |   1 +
>                   include/hw/pci/pci.h           |   1 +
>                   include/hw/virtio/virtio-net.h |   1 +
>                   include/net/net.h              |   2 +
>                   net/net.c                      |  61 ++++++++++++++++++=
+++++++
>                   qapi/misc.json                 |   5 ++-
>                   qapi/net.json                  | 100 ++++++++++++++++++=
+++++++++++++++++++++++
>                   12 files changed, 309 insertions(+), 1 deletion(-)
>=20
>             -------------------------------------------------------------=
--------
>             To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-op=
en.org
>             For additional commands, e-mail: virtio-dev-help@lists.oasis-=
open.org
>=20
>=20
>     ---------------------------------------------------------------------
>     To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>     For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20
>=20
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

