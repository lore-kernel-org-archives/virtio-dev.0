Return-Path: virtio-return-2934-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 00:03:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180301000215-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <55eb7e9c-97ee-f7d7-10db-190dd844160d@linux.vnet.ibm.com>
 <20180226224109-mutt-send-email-mst@kernel.org>
 <20180227102306.umrmvreh23bydsrl@dhcp-192-241.str.redhat.com>
 <19c6b2bd-b8ec-9365-a820-2974ee591e7a@linux.vnet.ibm.com>
 <20180228134215.nqumft7ztkvcoqvu@dhcp-192-241.str.redhat.com>
 <10e1d92f-2b97-d975-5b2b-f78d93989ad2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <10e1d92f-2b97-d975-5b2b-f78d93989ad2@linux.vnet.ibm.com>
Subject: Re: [virtio] Re: [virtio-dev] Re: [PATCH v8 08/16] packed
 virtqueues: more efficient virtqueue layout
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Jens Freimann <jfreimann@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 28, 2018 at 02:59:51PM +0100, Halil Pasic wrote:
>=20
>=20
> On 02/28/2018 02:42 PM, Jens Freimann wrote:
> > On Tue, Feb 27, 2018 at 12:29:11PM +0100, Halil Pasic wrote:
> >>
> >>
> >> On 02/27/2018 11:23 AM, Jens Freimann wrote:
> >>> On Mon, Feb 26, 2018 at 11:05:14PM +0200, Michael S. Tsirkin wrote:
> >>>> On Mon, Feb 26, 2018 at 06:19:21PM +0100, Halil Pasic wrote:
> >>>>> > +?????????????????????????????? vq->driver_event.flags =3D 0x1;
> >>>>> > +?????????????????????????????? memory_barrier();
> >>>>> > +
> >>>>> > +?????????????????????????????? flags =3D d->flags;
> >>>>> > +?????????????????????????????? bool avail =3D flags & (1 << VIRT=
Q_DESC_F_AVAIL);
> >>>>> > +?????????????????????????????? bool used =3D flags & (1 << VIRTQ=
_DESC_F_USED);
> >>>>> > +?????????????????????????????? if (avail !=3D used) {
> >>>>> > +?????????????????????????????????????????????? break;
> >>>>> > +?????????????????????????????? }
> >>>>> > +
> >>>>> > +?????????????????????????????? vq->driver_event.flags =3D 0x2;
> >>>>> > +?????????????? }
> >>>>> > +
> >>>>> > +?????? read_memory_barrier();
> >>>>>
> >>>>> Now with the condition avail !=3D used a freshly (that is zero init=
ialized)
> >>>>> ring would appear all used. And we would do process_buffer(d) for t=
he
> >>>>> whole ring if this code happens to get executed. Do we have to make
> >>>>> sure that this does not happen?
> >>>>
> >>>> I'll have to think about this.
> >>>
> >>> With the wrap counter initialized to 1 descriptors would not be seen
> >>> as used.
> >>
> >> Looking at the code... In vhost:
> >>
> >> +static bool desc_is_avail(struct vhost_virtqueue *vq,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct vring_desc_packed *des=
c)
> >> +{
> >> +=A0=A0=A0 if (vq->used_wrap_counter)
> >> +=A0=A0=A0=A0=A0=A0=A0 if ((desc->flags & DESC_AVAIL) && !(desc->flags=
 & DESC_USED))
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return true;
> >> +=A0=A0=A0 if (vq->used_wrap_counter =3D=3D false)
> >> +=A0=A0=A0=A0=A0=A0=A0 if (!(desc->flags & DESC_AVAIL) && (desc->flags=
 & DESC_USED))
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return true;
> >> +
> >> +=A0=A0=A0 return false;
> >> +}
> >>
> >> Here the bit pattern corresponding to available depends on the
> >> value of the wrap counter. I kind of anticipated this, but I could not
> >> find it defined in this spec.
> >>
> >> OTOH in guest:
> >>
> >> +static inline bool more_used_packed(const struct vring_virtqueue *vq)
> >> +{
> >> +=A0=A0=A0 u16 last_used, flags;
> >> +=A0=A0=A0 bool avail, used;
> >> +
> >> +=A0=A0=A0 if (vq->vq.num_free =3D=3D vq->vring.num)
> >> +=A0=A0=A0=A0=A0=A0=A0 return false;
> >> +
> >> +=A0=A0=A0 last_used =3D vq->last_used_idx;
> >> +=A0=A0=A0 flags =3D virtio16_to_cpu(vq->vq.vdev,
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->vring_packed.desc[l=
ast_used].flags);
> >> +=A0=A0=A0 avail =3D flags & VRING_DESC_F_AVAIL(1);
> >> +=A0=A0=A0 used =3D flags & VRING_DESC_F_USED(1);
> >> +
> >> +=A0=A0=A0 return avail =3D=3D used;
> >> +}
> >>
> >> if the next to be used descriptor is actually used does not depend on
> >> any wrap counter, but has vq->vq.num_free =3D=3D vq->vring.num as an e=
xtra
> >> condition. This extra condition is basically 'there are outstanding
> >> descriptors' and those are obviously either 'available' or yet to be o=
bserved
> >> 'used' descriptors. Right after initialization is covered by this extra
> >> condition. And obviously if the descriptor in question is still availa=
ble
> >> flags & VRING_DESC_F_AVAIL(1) !=3D flags & VRING_DESC_F_USED(1) holds,=
 so
> >> with the extra condition we are right there where we want to be.
> >>
> >> But I could not find the extra condition in the spec.
> >>
> >> With that said, I also want to point out that I don't understand
> >> your statement Jens. I don't see a way to express the condition corres=
ponding
> >> to more_used_packed() using the driver wrap counter (avail_wrap_count).
> >> Of course a wrap counter that wraps when last_used wraps could be used
> >> to (but no such counter is mentioned here AFAIU).
> >=20
> > Not sure I get this.
> > I was merely saying that when descriptor flags are initialized to 0
> > and the wrap counters to 1, then it is not the case that the driver
> > would see all descriptors as used because it takes the wrap counter
> > into account.
> >=20
>=20
> Please point me to the paragraph where it's written  how is the wrap
> counter to be taken into account when trying to determine if the
> desc_ring[last_used] (the descriptor we are polling) is used or not.
>=20
> Nothing like that being specified (or at least I could not find it)
> was actually what I got hooked on.
>=20
> Regards,
> Halil

So the spec just says this: if you see avail flag change,
descriptor is available. If you see used flag change, it
is used.

As value of the flag is also known (equals the wrap bit)
that is one way to detect change.


>=20
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe from this mail list, you must leave the OASIS TC that=20
> generates this mail.  Follow this link to all your TCs in OASIS at:
> https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

