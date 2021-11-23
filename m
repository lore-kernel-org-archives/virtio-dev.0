Return-Path: <stefanha@redhat.com>
Date: Tue, 23 Nov 2021 11:33:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3 0/2] virtio: introduce STOP status bit
Message-ID: <YZzRgc+LrLJaERlI@stefanha-x1.localdomain>
References: <20211111185812.2326093-1-eperezma@redhat.com>
 <YZZm9TVW2YiNWHdv@stefanha-x1.localdomain>
 <CAJaqyWfZGCZGD+AtT4gL_S-t4+p9H8M8KSk97hBSVw8mZTU5AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TGFSltMfgNCTCz8o"
Content-Disposition: inline
In-Reply-To: <CAJaqyWfZGCZGD+AtT4gL_S-t4+p9H8M8KSk97hBSVw8mZTU5AQ@mail.gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


--TGFSltMfgNCTCz8o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 05:49:11PM +0100, Eugenio Perez Martin wrote:
> On Thu, Nov 18, 2021 at 3:45 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Thu, Nov 11, 2021 at 07:58:10PM +0100, Eugenio P=E9rez wrote:
> > > This patch introduces a new status bit STOP. This can be used by the
> > > driver to stop the device in order to safely fetch used descriptors
> > > status, making sure the device will not fetch new available ones.
> > >
> > > Its main use case is live migration, although it has other orthogonal
> > > use cases. It can be used to safely discard requests that have not be=
en
> > > used: in other words, to rewind available descriptors.
> >
> > This sounds non-trivial and would require more explanation.
> >
>=20
> You are right and it's not well explained here, I will try to develop
> it better for the next version. It's in the cover letter explaining
> one use case proposed by MST [1] and the answer by Jason [2].
>=20
> When the VQ is stopped, it is forced to flush all the descriptors (in
> this version) and the used index in the case of split. With that
> information, the driver can modify any available descriptor that has
> not been used by the device, and to rewind the virtqueue available
> index to an extent.
>=20
> If we add Jason's virtqueue state (first patch of previous version),
> which I need to recover in later versions, the driver can move freely
> available and used index prior to queue resetting.
>=20
> The (in comments) proposed solution for the device that cannot flush
> its descriptor timely is to provide it with a way to report in-flight
> descriptors. As a reference, vhost-user has done it before, but with a
> memory region shared by a file descriptor [3]. If we add something
> similar, the driver still knows what file descriptors is able to
> rewind.
>=20
> Does that explanation make the driver rewind use case more clear?

I understand the use case but it's not clear how the mechanism is
supposed to work. Let's continue discussing in the sub-thread where I
posted details.

>=20
> > > Stopping the device in the live migration context is done by per-devi=
ce
> > > operations in vhost backends, but the introduction of STOP as a basic
> > > virtio facility comes with advantages:
> > > * All the device virtio-specific state is summarized in a single enti=
ty,
> > >   making easier to reason about it.
> >
> > This point isn't clear to me. I think it's saying that using STOP
> > somehow unifies things compared to the way that vhost devices are
> > stopped today. Given that vhost already syncs state back to the VMM's
> > emulated VIRTIO device, I'm not sure how STOP is different.
> >
>=20
> It also achieves that, but it's more related to the fact that the
> current way of getting the index through vhost net, user, ... is not
> reusable by others methods to expose the device to VMM.

->vhost_get_vring_base() is a common interface across vhost-kernel,
vhost-user, etc and all VIRTIO Device Types. Is there a problem with it
that I'm missing?

"vhost net, user" is confusing. Do you mean vhost-kernel and vhost-user
or do you mean vhost-net and vhost-user-net?

> Avoiding
> developing a different way to stop and get the status of each kind of
> device helps others devices implementations out of VMM.

What does "kind of device" mean? I think you mean vhost device types
like net, scsi, blk, vsock, etc (a subset of VIRTIO Device Types that
have been defined for vhost). As you say, they have different stop
operations, but it's not true that getting the status of a vring is
different for each one (they all use ->vhost_get_vring_base()).

>=20
> What you mention has more to do with the next bullet point.
>=20
> > > * VMM does not need to implement device specific operations in the
> > >   driver part.
> >
> > What is the "driver part"?
> >
>=20
> The part of qemu that talks to devices using virtio through (for
> example) vhost messages. This set features, get features, etc.
>=20
> Each vhost device has its own method to stop the device. In networking
> is setting a backend file descriptor -1, and others have their own
> way.
>=20
> Using the status field allows out of VMM to unify that part too.
>=20
> Maybe this one and the above would be clearer if I use vhost as
> examples. I will rewrite them anyhow, thanks!

Thanks. Something like "The VMM does not need to implement a different
stop operation like VHOST_NET_SET_BACKEND -1 for each device type" would
be clearer.

> > > * Work out of the box for devices that use pure virtio backends in so=
me
> > >   part of the device emulation chain (virtio_pci_vdpa or virtio_vdpa),
> > >   in any transport the device can use.
> >
> > ?
>=20
> vp_vdpa makes a standard virtio device exposed as a vdpa one. This
> implies that each of the vhost commands sent to vhost-vdpa needs to be
> converted to standard virtio request if it needs to reach the actual
> device. But there is currently no way to stop the device or retrieve
> its state using just virtio.
>=20
> Because of that, it's also usable by a pure virtio device, like in the
> case of vdpa devices using virtio_vdpa or other devices that simply
> exposes itself as a virtio one with no further facilities.
>=20
> It is also not restricted by the transport you use to expose the
> virtio: PCI, MMIO, etc, since you need to perform operations already
> defined by any usable device (set and get the status).

I see. This says STOP needs to be an in-band VIRTIO operation so that
vDPA/vhost can be stacked on top of VIRTIO devices. If STOP was only a
vhost operation then it wouldn't be possible to forward it to underlying
VIRTIO devices.

Stefan

--TGFSltMfgNCTCz8o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmGc0X8ACgkQnKSrs4Gr
c8gRMwf/VEdH+8n9FuBIh+Aos6d/bwCIAq/Xoi/+WWP3dog5iFLfFyNx/JeRvpZ3
2gdBOfbCV6H1NzRoPqgBmQt+5N/6Or8ZVRlaUZJaGXzeHhHbVs0NYkIwu4b8miMi
sbKTSnf+dMHEl+ERUswQnvxDbeQF270BvtaBTqNaKRZx6bFqskMc2mijL4Sge1z0
Lm9x6IQntfSk36svaapjyfPnnWf2FNIeC7+v+pPXn7U0QG0KJxWHa9hNqW8+2iKf
Sshhw/zGZ/vPf2QjXATQyRa25CCGqJPtmKLc1A0wLuWqGcC6TvwdEBigpLM2gj3N
edrVscSJyfcZvXfIP9pe8ZnsIvqpaw==
=bR2O
-----END PGP SIGNATURE-----

--TGFSltMfgNCTCz8o--

