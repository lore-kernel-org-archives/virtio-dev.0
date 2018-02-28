Return-Path: virtio-return-2933-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 00:01:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180301000046-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <55eb7e9c-97ee-f7d7-10db-190dd844160d@linux.vnet.ibm.com>
 <20180226224109-mutt-send-email-mst@kernel.org>
 <20180227102306.umrmvreh23bydsrl@dhcp-192-241.str.redhat.com>
 <19c6b2bd-b8ec-9365-a820-2974ee591e7a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <19c6b2bd-b8ec-9365-a820-2974ee591e7a@linux.vnet.ibm.com>
Subject: Re: [virtio] Re: [virtio-dev] Re: [PATCH v8 08/16] packed
 virtqueues: more efficient virtqueue layout
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Jens Freimann <jfreimann@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 27, 2018 at 12:29:11PM +0100, Halil Pasic wrote:
>=20
>=20
> On 02/27/2018 11:23 AM, Jens Freimann wrote:
> > On Mon, Feb 26, 2018 at 11:05:14PM +0200, Michael S. Tsirkin wrote:
> >> On Mon, Feb 26, 2018 at 06:19:21PM +0100, Halil Pasic wrote:
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->driver_event.fla=
gs =3D 0x1;
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 memory_barrier();
> >>> > +
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flags =3D d->flags;
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool avail =3D flags=
 & (1 << VIRTQ_DESC_F_AVAIL);
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool used =3D flags =
& (1 << VIRTQ_DESC_F_USED);
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (avail !=3D used)=
 {
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 break;
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >>> > +
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->driver_event.fla=
gs =3D 0x2;
> >>> > +=A0=A0=A0=A0=A0=A0=A0 }
> >>> > +
> >>> > +=A0=A0=A0 read_memory_barrier();
> >>>
> >>> Now with the condition avail !=3D used a freshly (that is zero initia=
lized)
> >>> ring would appear all used. And we would do process_buffer(d) for the
> >>> whole ring if this code happens to get executed. Do we have to make
> >>> sure that this does not happen?
> >>
> >> I'll have to think about this.
> >=20
> > With the wrap counter initialized to 1 descriptors would not be seen
> > as used.
>=20
> Looking at the code... In vhost:
>=20
> +static bool desc_is_avail(struct vhost_virtqueue *vq,
> +			  struct vring_desc_packed *desc)
> +{
> +	if (vq->used_wrap_counter)
> +		if ((desc->flags & DESC_AVAIL) && !(desc->flags & DESC_USED))
> +			return true;
> +	if (vq->used_wrap_counter =3D=3D false)
> +		if (!(desc->flags & DESC_AVAIL) && (desc->flags & DESC_USED))
> +			return true;
> +
> +	return false;
> +}
>=20
> Here the bit pattern corresponding to available depends on the
> value of the wrap counter. I kind of anticipated this, but I could not
> find it defined in this spec.
>=20
> OTOH in guest:
>=20
> +static inline bool more_used_packed(const struct vring_virtqueue *vq)
> +{
> +	u16 last_used, flags;
> +	bool avail, used;
> +
> +	if (vq->vq.num_free =3D=3D vq->vring.num)
> +		return false;
> +
> +	last_used =3D vq->last_used_idx;
> +	flags =3D virtio16_to_cpu(vq->vq.vdev,
> +				vq->vring_packed.desc[last_used].flags);
> +	avail =3D flags & VRING_DESC_F_AVAIL(1);
> +	used =3D flags & VRING_DESC_F_USED(1);
> +
> +	return avail =3D=3D used;
> +}
>=20
> if the next to be used descriptor is actually used does not depend on
> any wrap counter, but has vq->vq.num_free =3D=3D vq->vring.num as an extra
> condition. This extra condition is basically 'there are outstanding
> descriptors' and those are obviously either 'available' or yet to be obse=
rved
> 'used' descriptors. Right after initialization is covered by this extra
> condition. And obviously if the descriptor in question is still available
> flags & VRING_DESC_F_AVAIL(1) !=3D flags & VRING_DESC_F_USED(1) holds, so
> with the extra condition we are right there where we want to be.
>=20
> But I could not find the extra condition in the spec.
>=20
> With that said, I also want to point out that I don't understand
> your statement Jens. I don't see a way to express the condition correspon=
ding
> to more_used_packed() using the driver wrap counter (avail_wrap_count).
> Of course a wrap counter that wraps when last_used wraps could be used
> to (but no such counter is mentioned here AFAIU).

I added such a counter in the pseudo-code.


> >>
> >>
> >>> I was under the impression that this whole wrap counter exercise is
> >>> to be able to distinguish these cases.
> >>>
> >>> BTW tools/virtio/ringtest/ring.c has a single flag bit to indicate
> >>> available/used and does not have these wrap counters AFAIR.
> >>
> >> A single flag is fine if there's not s/g support and all descriptors a=
re
> >> written out.=A0 Wrap counters are needed if we are to support skipping
> >> descriptors because of s/g or in order.
> >>
> >>
> >>> Also for split virtqueues=A0 a descriptor has three possible states:
> >>> * available
> >>> * used
> >>> * free
> >>>
> >>> I wonder if it's the same for packed, and if, how do I recognize
> >>> free descriptors (that is descriptors that are neither available
> >>> nor used.
> >>
> >> I'll think about this.
> >>
> >>> I'm pretty much confused on how this scheme with the available
> >>> and used wrap counters (or device and driver wrap counters is
> >>> supposed to work). A working implementation in C would really help
> >>> me to understand this.
> >>
> >> DPDK based implementation has been posted.
> >=20
> > vhost and guest drivers have also been posted.
> > guest: https://lkml.org/lkml/2018/2/23/242
> > vhost: https://lkml.org/lkml/2018/2/13/1102
> >=20
>=20
> Thanks a lot. I've already found vhost myself but you saved me
> some searching with the other one ;).
>=20
> > regards,
> > Jens
> >>
> >>> > +=A0=A0=A0=A0=A0=A0=A0 process_buffer(d);
> >>> > +=A0=A0=A0=A0=A0=A0=A0 vq->next_used++;
> >>> > +=A0=A0=A0=A0=A0=A0=A0 if (vq->next_used >=3D vq->size) {
> >>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vq->next_used =3D 0;
> >>> > +=A0=A0=A0=A0=A0=A0=A0 }
> >>> > +}
> >>> > +\end{lstlisting}
> >>> >
> >>
> >> ---------------------------------------------------------------------
> >> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >>
> >=20
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

