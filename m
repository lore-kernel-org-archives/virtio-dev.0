Return-Path: virtio-dev-return-2565-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 608E2581926C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2017 06:36:46 -0700 (PDT)
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Thu, 21 Sep 2017 13:36:37 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34E1A62C8@SHSMSX152.ccr.corp.intel.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
In-Reply-To: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [virtio-dev] packed ring layout proposal v3
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open=
.org] On
> Behalf Of Michael S. Tsirkin
> Sent: Sunday, September 10, 2017 1:06 PM
> To: virtio-dev@lists.oasis-open.org
> Cc: virtualization@lists.linux-foundation.org
> Subject: [virtio-dev] packed ring layout proposal v3
>=20
[...]
> * Batching descriptors:
>=20
> virtio 1.0 allows passing a batch of descriptors in both directions, by i=
ncrementing
> the used/avail index by values > 1.
> At the moment only batching of used descriptors is used.
>=20
> We can support this by chaining a list of device descriptors through
> VRING_DESC_F_MORE flag. Device sets this bit to signal driver that this i=
s part of
> a batch of used descriptors which are all part of a single transaction.

It supposes each s/g chain represents for a packet, while each descriptor a=
mong batching chain represents for a packet. There're a few thoughts of bat=
ching chain(by VRING_DESC_F_MORE) and s/g chain(by VRING_DESC_F_NEXT).

- batching chain: It's up to device to coalesce the write-out of a batched =
used descriptors. As the batching size is variable, driver has to detect va=
lidity of each descriptor unless the number of incoming valid descriptor is=
 predictable, being curious on the benefits of driver from VRING_DESC_F_MOR=
E to take  batching descriptors as a single transaction. On device perspect=
ive, it's great to write out one descriptor for the whole chain. However, i=
t assumes no other useful fields in each descriptor of chain needs to write=
. TX buffer reclaiming can be the candidate, while RX side has to update 'l=
en' at least. Even for this purpose, instead of writing out VRING_DESC_F_MO=
RE on a few descriptors to suppress device writing back, it's cheaper to se=
t flag (e.g. VRING_DESC_F_WB) on single descriptor of chain to hint the exp=
ected position for device to write back.

- s/g chain: It makes sense to indicate the packet boundary. Considering in=
-order descriptor ring without VRING_DESC_F_INDIRECT, the next descriptor a=
lways belongs to the same s/g chain until end of packet indicators occur. S=
o one alternative approach is only to set a flag (e.g. VRING_DESC_F_EOP) on=
 the last descriptor of the chain.=20

>=20
> Driver might detect a partial descriptor chain (VRING_DESC_F_MORE set but=
 next
> descriptor not valid). In that case it must not use any parts of the chai=
n - it will
> later be completed by device, but driver is allowed to store the valid pa=
rts of the
> chain as device is not allowed to change them anymore.
As each descriptor represent for a whole packet(otherwise it's s/g chain), =
wondering why it must not use any parts of the chain.=20

>=20
> Descriptor should not have both VRING_DESC_F_MORE and
> VRING_DESC_F_NEXT set.
>=20
[...]
>=20
> * Selective use of descriptors
>=20
> As described above, descriptors with NEXT bit set are part of a scatter/g=
ather
> chain and so do not have to cause device to write a used descriptor out.
>=20
> Similarly, driver can set a flag VRING_DESC_F_MORE in the descriptor to s=
ignal to
> device that it does not have to write out the used descriptor as it is pa=
rt of a batch
> of descriptors. Device has two options (similar to VRING_DESC_F_NEXT):
>=20
> Device can write out the same number of descriptors for the batch, settin=
g
> VRING_DESC_F_MORE for all but the last descriptor.
> Driver will ignore all used descriptors with VRING_DESC_F_MORE bit set.
It will write out last descriptor without VRING_DESC_F_MORE anyway, so the =
following statement seems not like another option.

>=20
> Device only writes out a single descriptor for the whole batch.
> However, to keep device and driver in sync, it then skips a number of des=
criptors
> corresponding to the length of the batch before writing out the next used
> descriptor.
> After detecting a used descriptor driver must find out the length of the =
batch that
> it built in order to know where to look for the next device descriptor.
It would be good to keep it simple on device side, and to have the driver c=
ontrol the expectation.

>=20
>=20
> TODO (blocker): skipping descriptors for selective and scatter/gather see=
m to be
> only requested with in-order right now. Let's require in-order for this s=
kipping?
> This will simplify the accounting by driver.
>=20
>=20

Thanks,
Steve

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

