Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <YZZm9TVW2YiNWHdv@stefanha-x1.localdomain>
 <CAJaqyWfZGCZGD+AtT4gL_S-t4+p9H8M8KSk97hBSVw8mZTU5AQ@mail.gmail.com>
 <YZzRgc+LrLJaERlI@stefanha-x1.localdomain> <CAJaqyWdNfH1tg60UvKnEkuO-fS5cWUjkWZ4nBJ_o+J2xZtBaag@mail.gmail.com>
 <06316318-1d6c-c083-86f5-0ca13e9dd2bd@redhat.com>
In-Reply-To: <06316318-1d6c-c083-86f5-0ca13e9dd2bd@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 25 Nov 2021 08:24:49 +0100
Message-ID: <CAJaqyWe2Ps-jLpmpCA8C4gqjUQ4idYYqE0rdxhoa4sVkB0X08A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 25, 2021 at 4:05 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/11/24 =E4=B8=8A=E5=8D=8812:19, Eugenio Perez Martin =E5=86=
=99=E9=81=93:
> > On Tue, Nov 23, 2021 at 12:33 PM Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
> >> On Thu, Nov 18, 2021 at 05:49:11PM +0100, Eugenio Perez Martin wrote:
> >>> On Thu, Nov 18, 2021 at 3:45 PM Stefan Hajnoczi <stefanha@redhat.com>=
 wrote:
> >>>> On Thu, Nov 11, 2021 at 07:58:10PM +0100, Eugenio P=C3=A9rez wrote:
> >>>>> This patch introduces a new status bit STOP. This can be used by th=
e
> >>>>> driver to stop the device in order to safely fetch used descriptors
> >>>>> status, making sure the device will not fetch new available ones.
> >>>>>
> >>>>> Its main use case is live migration, although it has other orthogon=
al
> >>>>> use cases. It can be used to safely discard requests that have not =
been
> >>>>> used: in other words, to rewind available descriptors.
> >>>> This sounds non-trivial and would require more explanation.
> >>>>
> >>> You are right and it's not well explained here, I will try to develop
> >>> it better for the next version. It's in the cover letter explaining
> >>> one use case proposed by MST [1] and the answer by Jason [2].
> >>>
> >>> When the VQ is stopped, it is forced to flush all the descriptors (in
> >>> this version) and the used index in the case of split. With that
> >>> information, the driver can modify any available descriptor that has
> >>> not been used by the device, and to rewind the virtqueue available
> >>> index to an extent.
> >>>
> >>> If we add Jason's virtqueue state (first patch of previous version),
> >>> which I need to recover in later versions, the driver can move freely
> >>> available and used index prior to queue resetting.
> >>>
> >>> The (in comments) proposed solution for the device that cannot flush
> >>> its descriptor timely is to provide it with a way to report in-flight
> >>> descriptors. As a reference, vhost-user has done it before, but with =
a
> >>> memory region shared by a file descriptor [3]. If we add something
> >>> similar, the driver still knows what file descriptors is able to
> >>> rewind.
> >>>
> >>> Does that explanation make the driver rewind use case more clear?
> >> I understand the use case but it's not clear how the mechanism is
> >> supposed to work. Let's continue discussing in the sub-thread where I
> >> posted details.
> >>
> > Ok!
> >
> >>>>> Stopping the device in the live migration context is done by per-de=
vice
> >>>>> operations in vhost backends, but the introduction of STOP as a bas=
ic
> >>>>> virtio facility comes with advantages:
> >>>>> * All the device virtio-specific state is summarized in a single en=
tity,
> >>>>>    making easier to reason about it.
> >>>> This point isn't clear to me. I think it's saying that using STOP
> >>>> somehow unifies things compared to the way that vhost devices are
> >>>> stopped today. Given that vhost already syncs state back to the VMM'=
s
> >>>> emulated VIRTIO device, I'm not sure how STOP is different.
> >>>>
> >>> It also achieves that, but it's more related to the fact that the
> >>> current way of getting the index through vhost net, user, ... is not
> >>> reusable by others methods to expose the device to VMM.
> >> ->vhost_get_vring_base() is a common interface across vhost-kernel,
> >> vhost-user, etc and all VIRTIO Device Types. Is there a problem with i=
t
> >> that I'm missing?
> >>
> > It is usable by all VIRTIO Device types *exposed through vhost*, so it
> > fails to address the case when we cannot use vhost to expose the
> > device. It can happen with the cases you explained better than me in
> > [1], or when exposing a vdpa device as a pure virtio device using
> > virtio_vdpa.
>
>
> I don't get this and may miss something. The stop is a basic facility
> that is required for the building block of live migration. We need that
> regardless what kind of software technology or framework is used.
>

Yes, those are just examples using vdpa, to expose the actual
limitation that vhost protocol has. But there can be other examples
with other frameworks for sure.

And they are valid for both getting vq index and stop.

> For the case of virtio_vdpa, it's not because it can't use STOP but
> because we don't have a valid use case for that.
>

I had rewinding descriptors in mind actually.

Thanks!

> Thanks
>

