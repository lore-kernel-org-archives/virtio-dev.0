Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <YZZm9TVW2YiNWHdv@stefanha-x1.localdomain>
In-Reply-To: <YZZm9TVW2YiNWHdv@stefanha-x1.localdomain>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 18 Nov 2021 17:49:11 +0100
Message-ID: <CAJaqyWfZGCZGD+AtT4gL_S-t4+p9H8M8KSk97hBSVw8mZTU5AQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 18, 2021 at 3:45 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> On Thu, Nov 11, 2021 at 07:58:10PM +0100, Eugenio P=C3=A9rez wrote:
> > This patch introduces a new status bit STOP. This can be used by the
> > driver to stop the device in order to safely fetch used descriptors
> > status, making sure the device will not fetch new available ones.
> >
> > Its main use case is live migration, although it has other orthogonal
> > use cases. It can be used to safely discard requests that have not been
> > used: in other words, to rewind available descriptors.
>
> This sounds non-trivial and would require more explanation.
>

You are right and it's not well explained here, I will try to develop
it better for the next version. It's in the cover letter explaining
one use case proposed by MST [1] and the answer by Jason [2].

When the VQ is stopped, it is forced to flush all the descriptors (in
this version) and the used index in the case of split. With that
information, the driver can modify any available descriptor that has
not been used by the device, and to rewind the virtqueue available
index to an extent.

If we add Jason's virtqueue state (first patch of previous version),
which I need to recover in later versions, the driver can move freely
available and used index prior to queue resetting.

The (in comments) proposed solution for the device that cannot flush
its descriptor timely is to provide it with a way to report in-flight
descriptors. As a reference, vhost-user has done it before, but with a
memory region shared by a file descriptor [3]. If we add something
similar, the driver still knows what file descriptors is able to
rewind.

Does that explanation make the driver rewind use case more clear?

> > Stopping the device in the live migration context is done by per-device
> > operations in vhost backends, but the introduction of STOP as a basic
> > virtio facility comes with advantages:
> > * All the device virtio-specific state is summarized in a single entity=
,
> >   making easier to reason about it.
>
> This point isn't clear to me. I think it's saying that using STOP
> somehow unifies things compared to the way that vhost devices are
> stopped today. Given that vhost already syncs state back to the VMM's
> emulated VIRTIO device, I'm not sure how STOP is different.
>

It also achieves that, but it's more related to the fact that the
current way of getting the index through vhost net, user, ... is not
reusable by others methods to expose the device to VMM. Avoiding
developing a different way to stop and get the status of each kind of
device helps others devices implementations out of VMM.

What you mention has more to do with the next bullet point.

> > * VMM does not need to implement device specific operations in the
> >   driver part.
>
> What is the "driver part"?
>

The part of qemu that talks to devices using virtio through (for
example) vhost messages. This set features, get features, etc.

Each vhost device has its own method to stop the device. In networking
is setting a backend file descriptor -1, and others have their own
way.

Using the status field allows out of VMM to unify that part too.

Maybe this one and the above would be clearer if I use vhost as
examples. I will rewrite them anyhow, thanks!

> > * Work out of the box for devices that use pure virtio backends in some
> >   part of the device emulation chain (virtio_pci_vdpa or virtio_vdpa),
> >   in any transport the device can use.
>
> ?

vp_vdpa makes a standard virtio device exposed as a vdpa one. This
implies that each of the vhost commands sent to vhost-vdpa needs to be
converted to standard virtio request if it needs to reach the actual
device. But there is currently no way to stop the device or retrieve
its state using just virtio.

Because of that, it's also usable by a pure virtio device, like in the
case of vdpa devices using virtio_vdpa or other devices that simply
exposes itself as a virtio one with no further facilities.

It is also not restricted by the transport you use to expose the
virtio: PCI, MMIO, etc, since you need to perform operations already
defined by any usable device (set and get the status).

>
> > * It's totally self-contained, solving the nested virtualization case
> >   straightforwardly.
>
> Make sense.
>
> > To fully understand its position in the live migration case, it's neede=
d
> > to note that the VMM acts as a part (or the whole) of the virtio device
> > from the guest point of view, and it can act as a part of the driver
> > from an external virtio device point of view. This is already the case
> > when using vhost-net, for example, where VMM exposes a combination of
> > backend and VMM features, and can mask them if needed.
> >
> > To migrate an external device the VMM needs to retrieve its (guest
> > visible) status and make sure the device does not modify it or
>
> "status" means device state here, not VIRTIO Status Register? (There
> even a third use of "status" in the first paragraph related to used
> descriptors. I found this confusing.)
>

Yes, this one should be "state", as used in previous series.

Status in the first paragraph is totally redundant, I will delete it
for the next revision.

> > communicate with the guest anymore. The STOP status bit achieves the
> > last part, and even the first one in case of a pure stateless device
> > using the split vring.
> >
> > In its simpler way of working, the VMM masks the VIRTIO_F_STOP feature
> > to the guest, and also masks the STOP and STOP_FAILED status bit. This
> > way the VMM can stop and resume operation unilaterally, totally
> > transparent for the latter.
>
> "latter" means the guest here?

Yes. I will rephrase that too.

Thanks!

[1] https://lists.oasis-open.org/archives/virtio-comment/202107/msg00043.ht=
ml
[2] https://lists.oasis-open.org/archives/virtio-comment/202107/msg00047.ht=
ml
[3] https://qemu.readthedocs.io/en/latest/interop/vhost-user.html#inflight-=
i-o-tracking

