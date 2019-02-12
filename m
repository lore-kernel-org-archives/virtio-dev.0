Return-Path: virtio-dev-return-5411-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5DE45985D18
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 17:35:13 +0000 (UTC)
Date: Tue, 12 Feb 2019 12:35:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190212122619-mutt-send-email-mst@kernel.org>
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
 <20190211021124-mutt-send-email-mst@kernel.org>
 <d5d3b7f6-95a3-0d1c-4890-6e72f2e4bfc5@solarflare.com>
 <20190211080432-mutt-send-email-mst@kernel.org>
 <97e870fd-dbd5-2fed-b62c-67d24407e5cf@solarflare.com>
 <20190211233612-mutt-send-email-mst@kernel.org>
 <02809024-c99c-caf5-5ec4-98ee96ca6cd5@solarflare.com>
 <20190212085415-mutt-send-email-mst@kernel.org>
 <15b8c0b7-643d-d9c2-f05c-0f5d8c8169c3@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <15b8c0b7-643d-d9c2-f05c-0f5d8c8169c3@solarflare.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 12, 2019 at 04:47:08PM +0000, David Riddoch wrote:
>=20
> > > > > I would prefer to have the write barrier before writing the idx.
> > > > Well that's driver overhead for something device might never utilis=
e in
> > > > a given workload. If we are optimizing let's optimize for speed.
> > > I think doing the barrier before writing idx is best for speed (see b=
elow).
> > I don't see it below :(
>=20
> Sorry, I'm not being clear.=A0 If the write barrier is before the idx, th=
en a
> PV device can read the idx, do a single rmb and read a whole bunch of
> descriptors.=A0 As things stand today a PV device has to do an rmb for ea=
ch
> descriptor that it reads.
>=20
> I'm not sure, but this may be what Jason meant when he said "prefetch".

Oh. Right. So for PV it's easy to convert an rmb to a data dependency
instead.  It remains to be seen whether an extra cache miss per
batch is cheaper or more expensive than such a dependency
per descriptor.

I hope Jason can experiment and let us know.


> > > But it is really desirable for complexity: Cases like this are easy to
> > > handle in software, but much much harder in pipelined hardware
> > > implementations.
> > Maybe we should use a flag in event suppression structure.
> > This way device can switch between being notification driven
> > and being driven by index reads.
>=20
> On first thought it seems hard to avoid races: On receiving a doorbell the
> device wishes to transition from doorbells to polling, so driver->avail_i=
dx
> currently has an old value; device writes device->flags; a little later
> device reads driver->avail_idx.=A0 It might have a new value written by t=
he
> driver, or an old value...the device can't tell.=A0 Needs more thought.


I would say device writes flags and then reads the descriptor
ring. This is exactly the same sequence that needs to happen
when enabling driver notifications.


> > > > I am also wondering: what would the analog of this feature be for s=
plit
> > > > rings? We are burning a feature bit, might as well find a good
> > > > use for it.
> > > I don't have any suggestions.=A0 I worry that associating the same bi=
t with a
> > > split-ring feature would create an undesirable coupling: A device off=
ering X
> > > for packed-ring would also necessarily have to implement Y for split-=
ring
> > > and vice versa (if both ring types are supported).
> > BTW we really need to look more at how can devices support subsets
> > of features. Right now devices can fail FEATURES_OK but drivers do
> > not recover. Some dependencies are defined by spec and drivers
> > can force them but devices can't.
>=20
> Completely agree.=A0 In order to limit complexity in hardware implementat=
ions
> it would be nice to be able to express "I support X, and X+Y, but not Y by
> itself" and similar.=A0 There is no way to do that today.
>=20
>=20
> --=20
> David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

