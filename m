Return-Path: virtio-return-3410-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Nov 2019 08:02:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191127080139-mutt-send-email-mst@kernel.org>
References: <20191028161240.24806-1-mst@redhat.com>
 <aacb3a7b-9930-275c-3c80-73370e587e85@siemens.com>
 <20191125032108-mutt-send-email-mst@kernel.org>
 <20191125111420.4a905d7d.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191125111420.4a905d7d.cohuck@redhat.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH] pci: strengthen requirement of
 the correct subsystem id
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 25, 2019 at 11:14:20AM +0100, Cornelia Huck wrote:
> On Mon, 25 Nov 2019 03:22:13 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Mon, Nov 25, 2019 at 07:41:09AM +0100, Jan Kiszka wrote:
> > > On 28.10.19 17:12, Michael S. Tsirkin wrote: =20
> > > > If a hardware implementation of virtio does not have
> > > > the correct subsystem id, then drivers can't report
> > > > ir properly, or detect and work around bugs. =20
> > >=20
> > > s/ir/it.
> > >=20
> > > Jan
> > >  =20
> > > > Change the requirement from MAY to SHOULD.
> > > >=20
> > > > We can't make it a MUST since we did not require this
> > > > historically.
> > > >=20
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com> =20
> >=20
> >=20
> > One thing I noticed is that for transitional devices, windows drivers
> > bind to a specific vendor id. I guess we need to make this
> > SHOULD for non-transitional only?
>=20
> So, they have different binding behaviour for transitional vs
> non-transitional devices? Or transitional vs non-transitional drivers?

Transitional vs non-transitional have different IDs, sure.
That's in the spec.

> >=20
> >=20
> > > > ---
> > > >   content.tex | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/content.tex b/content.tex
> > > > index 4bcb728..8f1518c 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -562,7 +562,7 @@ \subsection{PCI Device Discovery}\label{sec:Vir=
tio Transport Options / Virtio Ov
> > > >   For example, the network card device with the Virtio Device ID 1
> > > >   has the PCI Device ID 0x1041 or the Transitional PCI Device ID 0x=
1000.
> > > > -The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY re=
flect
> > > > +The PCI Subsystem Vendor ID and the PCI Subsystem Device ID SHOULD=
 reflect
> > > >   the PCI Vendor and Device ID of the environment (for informationa=
l purposes by the driver).
> > > >   Non-transitional devices SHOULD have a PCI Device ID in the range
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

