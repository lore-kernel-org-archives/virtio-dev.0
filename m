Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <YZZm9TVW2YiNWHdv@stefanha-x1.localdomain>
 <CAJaqyWfZGCZGD+AtT4gL_S-t4+p9H8M8KSk97hBSVw8mZTU5AQ@mail.gmail.com>
 <YZzRgc+LrLJaERlI@stefanha-x1.localdomain> <CAJaqyWdNfH1tg60UvKnEkuO-fS5cWUjkWZ4nBJ_o+J2xZtBaag@mail.gmail.com>
 <YZ5ZlLKMNJmCjHbb@stefanha-x1.localdomain>
In-Reply-To: <YZ5ZlLKMNJmCjHbb@stefanha-x1.localdomain>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 24 Nov 2021 17:58:02 +0100
Message-ID: <CAJaqyWe=aOPLC_S0_5OnMH8o4-bvKyOfm-tCikxzBf3uoDwxPA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 24, 2021 at 4:26 PM Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>
> On Tue, Nov 23, 2021 at 05:19:23PM +0100, Eugenio Perez Martin wrote:
> > On Tue, Nov 23, 2021 at 12:33 PM Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
> > >
> > > On Thu, Nov 18, 2021 at 05:49:11PM +0100, Eugenio Perez Martin wrote:
> > > > On Thu, Nov 18, 2021 at 3:45 PM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
> > > > >
> > > > > On Thu, Nov 11, 2021 at 07:58:10PM +0100, Eugenio P=C3=A9rez wrot=
e:
> > > > > > This patch introduces a new status bit STOP. This can be used b=
y the
> > > > > > driver to stop the device in order to safely fetch used descrip=
tors
> > > > > > status, making sure the device will not fetch new available one=
s.
> > > > > >
> > > > > > Its main use case is live migration, although it has other orth=
ogonal
> > > > > > use cases. It can be used to safely discard requests that have =
not been
> > > > > > used: in other words, to rewind available descriptors.
> > > > >
> > > > > This sounds non-trivial and would require more explanation.
> > > > >
> > > >
> > > > You are right and it's not well explained here, I will try to devel=
op
> > > > it better for the next version. It's in the cover letter explaining
> > > > one use case proposed by MST [1] and the answer by Jason [2].
> > > >
> > > > When the VQ is stopped, it is forced to flush all the descriptors (=
in
> > > > this version) and the used index in the case of split. With that
> > > > information, the driver can modify any available descriptor that ha=
s
> > > > not been used by the device, and to rewind the virtqueue available
> > > > index to an extent.
> > > >
> > > > If we add Jason's virtqueue state (first patch of previous version)=
,
> > > > which I need to recover in later versions, the driver can move free=
ly
> > > > available and used index prior to queue resetting.
> > > >
> > > > The (in comments) proposed solution for the device that cannot flus=
h
> > > > its descriptor timely is to provide it with a way to report in-flig=
ht
> > > > descriptors. As a reference, vhost-user has done it before, but wit=
h a
> > > > memory region shared by a file descriptor [3]. If we add something
> > > > similar, the driver still knows what file descriptors is able to
> > > > rewind.
> > > >
> > > > Does that explanation make the driver rewind use case more clear?
> > >
> > > I understand the use case but it's not clear how the mechanism is
> > > supposed to work. Let's continue discussing in the sub-thread where I
> > > posted details.
> > >
> >
> > Ok!
> >
> > > >
> > > > > > Stopping the device in the live migration context is done by pe=
r-device
> > > > > > operations in vhost backends, but the introduction of STOP as a=
 basic
> > > > > > virtio facility comes with advantages:
> > > > > > * All the device virtio-specific state is summarized in a singl=
e entity,
> > > > > >   making easier to reason about it.
> > > > >
> > > > > This point isn't clear to me. I think it's saying that using STOP
> > > > > somehow unifies things compared to the way that vhost devices are
> > > > > stopped today. Given that vhost already syncs state back to the V=
MM's
> > > > > emulated VIRTIO device, I'm not sure how STOP is different.
> > > > >
> > > >
> > > > It also achieves that, but it's more related to the fact that the
> > > > current way of getting the index through vhost net, user, ... is no=
t
> > > > reusable by others methods to expose the device to VMM.
> > >
> > > ->vhost_get_vring_base() is a common interface across vhost-kernel,
> > > vhost-user, etc and all VIRTIO Device Types. Is there a problem with =
it
> > > that I'm missing?
> > >
> >
> > It is usable by all VIRTIO Device types *exposed through vhost*, so it
> > fails to address the case when we cannot use vhost to expose the
> > device. It can happen with the cases you explained better than me in
> > [1], or when exposing a vdpa device as a pure virtio device using
> > virtio_vdpa.
>
> I see. Maybe you can describe that motivation in the cover letter, I
> didn't get it until much later in our discussion.
>

Good point. I will clarify it.

> >
> > > "vhost net, user" is confusing. Do you mean vhost-kernel and vhost-us=
er
> > > or do you mean vhost-net and vhost-user-net?
> > >
> >
> > I meant vhost-kernel and vhost-user, sorry.
> >
> > > > Avoiding
> > > > developing a different way to stop and get the status of each kind =
of
> > > > device helps others devices implementations out of VMM.
> > >
> > > What does "kind of device" mean? I think you mean vhost device types
> > > like net, scsi, blk, vsock, etc (a subset of VIRTIO Device Types that
> > > have been defined for vhost). As you say, they have different stop
> > > operations, but it's not true that getting the status of a vring is
> > > different for each one (they all use ->vhost_get_vring_base()).
> > >
> >
> > Reading that way I meant all VIRTIO Device Types, since this proposal
> > also addresses them even if they don't use vhost-*.
> >
> > I said "stop and get the status" as a the operation, but now I see
> > it's confusing, and I meant mostly stop as you say.
> >
> > > >
> > > > What you mention has more to do with the next bullet point.
> > > >
> > > > > > * VMM does not need to implement device specific operations in =
the
> > > > > >   driver part.
> > > > >
> > > > > What is the "driver part"?
> > > > >
> > > >
> > > > The part of qemu that talks to devices using virtio through (for
> > > > example) vhost messages. This set features, get features, etc.
> > > >
> > > > Each vhost device has its own method to stop the device. In network=
ing
> > > > is setting a backend file descriptor -1, and others have their own
> > > > way.
> > > >
> > > > Using the status field allows out of VMM to unify that part too.
> > > >
> > > > Maybe this one and the above would be clearer if I use vhost as
> > > > examples. I will rewrite them anyhow, thanks!
> > >
> > > Thanks. Something like "The VMM does not need to implement a differen=
t
> > > stop operation like VHOST_NET_SET_BACKEND -1 for each device type" wo=
uld
> > > be clearer.
> > >
> >
> > I will change, thanks!
> >
> > > > > > * Work out of the box for devices that use pure virtio backends=
 in some
> > > > > >   part of the device emulation chain (virtio_pci_vdpa or virtio=
_vdpa),
> > > > > >   in any transport the device can use.
> > > > >
> > > > > ?
> > > >
> > > > vp_vdpa makes a standard virtio device exposed as a vdpa one. This
> > > > implies that each of the vhost commands sent to vhost-vdpa needs to=
 be
> > > > converted to standard virtio request if it needs to reach the actua=
l
> > > > device. But there is currently no way to stop the device or retriev=
e
> > > > its state using just virtio.
> > > >
> > > > Because of that, it's also usable by a pure virtio device, like in =
the
> > > > case of vdpa devices using virtio_vdpa or other devices that simply
> > > > exposes itself as a virtio one with no further facilities.
> > > >
> > > > It is also not restricted by the transport you use to expose the
> > > > virtio: PCI, MMIO, etc, since you need to perform operations alread=
y
> > > > defined by any usable device (set and get the status).
> > >
> >
> > [1]
> > > I see. This says STOP needs to be an in-band VIRTIO operation so that
> > > vDPA/vhost can be stacked on top of VIRTIO devices. If STOP was only =
a
> > > vhost operation then it wouldn't be possible to forward it to underly=
ing
> > > VIRTIO devices.
> > >
> >
> > I will use that to clarify the point, thanks!
> >
> > I think that all the points overlap too much, so I will try to rewrite
> > differently for the next version. Thank you very much for the
> > feedback!
>
> Sorry that I've been insisting on all these details. I was worried that
> I'm missing the motivation for this feature or misunderstanding it.
>

On the contrary: although the proposed features and changes are
relatively small, it's hard to place them in the big picture and
introduce them balancing everything.

These questions and comments help a lot to focus and clear the
proposal, so thank you very much for them!

> Stefan

