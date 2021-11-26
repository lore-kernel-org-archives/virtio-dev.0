Return-Path: <eperezma@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <YZZm9TVW2YiNWHdv@stefanha-x1.localdomain>
 <CAJaqyWfZGCZGD+AtT4gL_S-t4+p9H8M8KSk97hBSVw8mZTU5AQ@mail.gmail.com>
 <YZzRgc+LrLJaERlI@stefanha-x1.localdomain> <CAJaqyWdNfH1tg60UvKnEkuO-fS5cWUjkWZ4nBJ_o+J2xZtBaag@mail.gmail.com>
 <06316318-1d6c-c083-86f5-0ca13e9dd2bd@redhat.com> <CAJaqyWe2Ps-jLpmpCA8C4gqjUQ4idYYqE0rdxhoa4sVkB0X08A@mail.gmail.com>
 <CACGkMEsBV2MoaX8U8_aNY4zGm6DdXMpqFa86tG5q4kGgcNzS=A@mail.gmail.com>
 <CAJaqyWf02FpMeCsGuuR4JDZmKFdSZ-iW8SFW-j=WgXkaj2XobA@mail.gmail.com> <CACGkMEvD+Z7cYszhMzBsnEaC0K0kfnHxzFDEfjT_qLOFiMR-XA@mail.gmail.com>
In-Reply-To: <CACGkMEvD+Z7cYszhMzBsnEaC0K0kfnHxzFDEfjT_qLOFiMR-XA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Nov 2021 09:26:41 +0100
Message-ID: <CAJaqyWf9cdZ87ANUZwqzCgRKo76asGrW+iP7g6wrbSowqZ18FQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, Michael Tsirkin <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 26, 2021 at 4:07 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Thu, Nov 25, 2021 at 5:01 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 8:38 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Nov 25, 2021 at 3:25 PM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Nov 25, 2021 at 4:05 AM Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > >
> > > > >
> > > > > =E5=9C=A8 2021/11/24 =E4=B8=8A=E5=8D=8812:19, Eugenio Perez Marti=
n =E5=86=99=E9=81=93:
> > > > > > On Tue, Nov 23, 2021 at 12:33 PM Stefan Hajnoczi <stefanha@redh=
at.com> wrote:
> > > > > >> On Thu, Nov 18, 2021 at 05:49:11PM +0100, Eugenio Perez Martin=
 wrote:
> > > > > >>> On Thu, Nov 18, 2021 at 3:45 PM Stefan Hajnoczi <stefanha@red=
hat.com> wrote:
> > > > > >>>> On Thu, Nov 11, 2021 at 07:58:10PM +0100, Eugenio P=C3=A9rez=
 wrote:
> > > > > >>>>> This patch introduces a new status bit STOP. This can be us=
ed by the
> > > > > >>>>> driver to stop the device in order to safely fetch used des=
criptors
> > > > > >>>>> status, making sure the device will not fetch new available=
 ones.
> > > > > >>>>>
> > > > > >>>>> Its main use case is live migration, although it has other =
orthogonal
> > > > > >>>>> use cases. It can be used to safely discard requests that h=
ave not been
> > > > > >>>>> used: in other words, to rewind available descriptors.
> > > > > >>>> This sounds non-trivial and would require more explanation.
> > > > > >>>>
> > > > > >>> You are right and it's not well explained here, I will try to=
 develop
> > > > > >>> it better for the next version. It's in the cover letter expl=
aining
> > > > > >>> one use case proposed by MST [1] and the answer by Jason [2].
> > > > > >>>
> > > > > >>> When the VQ is stopped, it is forced to flush all the descrip=
tors (in
> > > > > >>> this version) and the used index in the case of split. With t=
hat
> > > > > >>> information, the driver can modify any available descriptor t=
hat has
> > > > > >>> not been used by the device, and to rewind the virtqueue avai=
lable
> > > > > >>> index to an extent.
> > > > > >>>
> > > > > >>> If we add Jason's virtqueue state (first patch of previous ve=
rsion),
> > > > > >>> which I need to recover in later versions, the driver can mov=
e freely
> > > > > >>> available and used index prior to queue resetting.
> > > > > >>>
> > > > > >>> The (in comments) proposed solution for the device that canno=
t flush
> > > > > >>> its descriptor timely is to provide it with a way to report i=
n-flight
> > > > > >>> descriptors. As a reference, vhost-user has done it before, b=
ut with a
> > > > > >>> memory region shared by a file descriptor [3]. If we add some=
thing
> > > > > >>> similar, the driver still knows what file descriptors is able=
 to
> > > > > >>> rewind.
> > > > > >>>
> > > > > >>> Does that explanation make the driver rewind use case more cl=
ear?
> > > > > >> I understand the use case but it's not clear how the mechanism=
 is
> > > > > >> supposed to work. Let's continue discussing in the sub-thread =
where I
> > > > > >> posted details.
> > > > > >>
> > > > > > Ok!
> > > > > >
> > > > > >>>>> Stopping the device in the live migration context is done b=
y per-device
> > > > > >>>>> operations in vhost backends, but the introduction of STOP =
as a basic
> > > > > >>>>> virtio facility comes with advantages:
> > > > > >>>>> * All the device virtio-specific state is summarized in a s=
ingle entity,
> > > > > >>>>>    making easier to reason about it.
> > > > > >>>> This point isn't clear to me. I think it's saying that using=
 STOP
> > > > > >>>> somehow unifies things compared to the way that vhost device=
s are
> > > > > >>>> stopped today. Given that vhost already syncs state back to =
the VMM's
> > > > > >>>> emulated VIRTIO device, I'm not sure how STOP is different.
> > > > > >>>>
> > > > > >>> It also achieves that, but it's more related to the fact that=
 the
> > > > > >>> current way of getting the index through vhost net, user, ...=
 is not
> > > > > >>> reusable by others methods to expose the device to VMM.
> > > > > >> ->vhost_get_vring_base() is a common interface across vhost-ke=
rnel,
> > > > > >> vhost-user, etc and all VIRTIO Device Types. Is there a proble=
m with it
> > > > > >> that I'm missing?
> > > > > >>
> > > > > > It is usable by all VIRTIO Device types *exposed through vhost*=
, so it
> > > > > > fails to address the case when we cannot use vhost to expose th=
e
> > > > > > device. It can happen with the cases you explained better than =
me in
> > > > > > [1], or when exposing a vdpa device as a pure virtio device usi=
ng
> > > > > > virtio_vdpa.
> > > > >
> > > > >
> > > > > I don't get this and may miss something. The stop is a basic faci=
lity
> > > > > that is required for the building block of live migration. We nee=
d that
> > > > > regardless what kind of software technology or framework is used.
> > > > >
> > > >
> > > > Yes, those are just examples using vdpa, to expose the actual
> > > > limitation that vhost protocol has. But there can be other examples
> > > > with other frameworks for sure.
> > > >
> > > > And they are valid for both getting vq index and stop.
> > > >
> > > > > For the case of virtio_vdpa, it's not because it can't use STOP b=
ut
> > > > > because we don't have a valid use case for that.
> > > > >
> > > >
> > > > I had rewinding descriptors in mind actually.
> > >
> > > Yes, STOP could be one of the building blocks for this. But it
> > > actually requires more. e.g the ability to let the driver to change
> > > the last_avail_idx in the device.
> >
> > I think it can be done without changing last_avail_idx for the guest
> > to be able to stop and rewind.
>
> At least the driver needs to know the exact value of last_avail_idx in
> this case.
>

In this proposal the device must dump it to the used ring. For the
next one the virtqueue state basic facility will be recovered.

> >
> > The guest must already know what buffers are available for its normal
> > operation. In case of stop & reset, the driver knows that the next
> > last_avail_idx will be 0, so it just needs to set the available
> > descriptors it does *not* want to rewind in the virtqueue and change
> > avail_idx accordingly.
>
> I may miss something, but in this case the device may start processing
> [0, avail_idx), is it safe?
>

The guest should also set the proper avail_idx and the descriptors
before the DRIVER_OK, so I'd say yes.

Something like:
* Driver set STOP, so it knows it has (at least) [used_idx =3D=3D
last_avail_idx, avail_idx) descriptors for rewinding.
* Driver adds the ones it wants to [0, new_avail_idx <=3D avail_idx). It
releases the resources of the descriptors that want to rewind.
* Driver set DRIVER_OK.

> >
> > Then we have the opposite problem of the live migration: What do "in
> > flight" descriptors mean here? For example, for block, is it valid to
> > rewind a write descriptor that is in-flight?
>
> I think if we don't care about rewind it would be much easier. (Anyhow
> we know we will support setting/getting index states from driver).
>

It may be, yes.

Thanks!

> Thanks
>
> >
> > > And it depends on if we had other
> > > requirements during the rewind, e.g can we afford to stop the whole
> > > device or just a specific virtqueue. If it's the latter, we had
> > > another special example (rewind to 0), Ali is proposing per virtqueue
> > > reset which could be used to death unused buffers safely from a
> > > specific queue (then it's something unrelated to STOP itself).
> > >
> > > So I think STOP + virtqueue index state should be sufficient for
> > > rewind if we can afford to stop the whole device (which might not be
> > > the case for Ali's proposal).
> > >
> >
> > Totally agree on this part.
> >
> > Thanks!
> >
> > > Thanks
> > >
> > > >
> > > > Thanks!
> > > >
> > > > > Thanks
> > > > >
> > > >
> > >
> >
>

