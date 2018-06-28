Return-Path: virtio-dev-return-4598-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EC7151CB807B
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Jun 2018 03:08:01 -0700 (PDT)
Date: Thu, 28 Jun 2018 12:07:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180628120756.40f3d036.cohuck@redhat.com>
In-Reply-To: <20180628082532.GB17326@redhat.com>
References: <20180627034935.20276-1-venu.busireddy@oracle.com>
	<20180627034935.20276-4-venu.busireddy@oracle.com>
	<20180627065943-mutt-send-email-mst@kernel.org>
	<20180628082532.GB17326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Retrieving configuration metadata from hypervisor (was: Re:
 [Qemu-devel] [PATCH v2 3/4] Add "Group Identifier" support to Red Hat PCI
 bridge.)
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, Venu Busireddy <venu.busireddy@oracle.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 28 Jun 2018 09:25:32 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Jun 27, 2018 at 07:02:36AM +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 26, 2018 at 10:49:33PM -0500, Venu Busireddy wrote: =20
> > > Add the "Vendor-Specific" capability to the Red Hat PCI bridge device
> > > "pci-bridge", to contain the "Group Identifier" (UUID) that will be
> > > used to pair a virtio device with the passthrough device attached to
> > > that bridge.
> > >=20
> > > This capability is added to the bridge iff the "uuid" option is speci=
fied
> > > for the bridge. =20

As an aside, I don't think that will work for s390, see
https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg07785.html.

> >=20
> > I think the name should be more explicit. How about "failover-group-id"?
> >  =20
> > >=20
> > > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com> =20
> >=20
> > I'd like to also tweak the device id in this case,
> > to make it easier for guests to know it's a grouping bridge. =20
>=20
> I tend to think this proposal is rather too narrow. The need to tell
> the guest OS about the intended usage of devices is a pretty common use
> case, of which setting up bonding NIC pair is just one example.

FWIW, there was also discussion of making "pair those devices" a more
general virtio mechanism (see
https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg06339.html
and around).

>=20
> OpenStack already has this problem & took the approach of providing some
> structured JSON metadata to the guest that lists all devices  (well NICs
> and disks at least) with identifying metadata (eg PCI address, MAC addr,
> disk serial and anything else relevant), and also assigns freeform string
> "tags" against each.  eg the host admin could specify tags "lanA" and "la=
nB"
> for two NICs, so the guest knows which NIC to use for which purpose. This
> kind of tagging could easily cover setting up bonded pairs. Or for a disk
> they could tag it  "oracledata" or "apachecache" to indicate what kind of
> data to use on the disk, etc
>=20
>   https://specs.openstack.org/openstack/nova-specs/specs/mitaka/approved/=
virt-device-role-tagging.html
>=20
> I'm not suggesting the impl used in OpenStack is perfect - there's a numb=
er
> of pain points in it, but I think it shows the need for a general solution
> to the problem of the host admin informing the guest OS about the intended
> usage of devices being provided. I think freeform string tags do this
> pretty well. The key problem is how to expose such tags - openstack took
> approach of an out of band JSON doc exposed from its metadata service and
> or cloud init config drive, because that was its only viable option.

As another example, s390 has a mechanism for providing configuration
information to a guest as well (see drivers/s390/char/sclp_sd.c in
Linux; for a guest user space exploiter, see
https://github.com/ibm-s390-tools/s390-tools/commit/7d355b0fec964ad84ecaf88=
eb946121d39486070
and follow-ons; the hypervisor implementation is proprietary AFAIK).

>=20
> Perhaps there is a way to expose tags at a low level though if we can
> integrate with QEMU somehow ?

I'd really like to see a data format that is flexible enough to cover
existing needs (which can be used with different hypervisor<->guest
interfaces.) We'd probably need to standardize it somehow if we want to
tie in with the virtio OASIS spec.

That said, for the net device standby functionality, it might be easier
to just go with the VIRTIO_NET_F_STANDBY_UUID proposal while we discuss
a more generic mechanism.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

