Return-Path: virtio-return-3409-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Nov 2019 05:59:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191127055432-mutt-send-email-mst@kernel.org>
References: <20191028105508.31769-1-mst@redhat.com>
 <e4cc37c2-ac51-6260-b615-67222bbad1a5@siemens.com>
 <20191125025608-mutt-send-email-mst@kernel.org>
 <20191127085956.6dc635a1.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191127085956.6dc635a1.cohuck@redhat.com>
Subject: Re: [virtio] Re: [virtio-dev] [PATCH] content: add vendor specific
 cfg type
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 27, 2019 at 08:59:56AM +0100, Cornelia Huck wrote:
> On Mon, 25 Nov 2019 03:11:43 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Mon, Nov 25, 2019 at 08:45:52AM +0100, Jan Kiszka wrote:
> > > On 28.10.19 11:55, Michael S. Tsirkin wrote: =20
> > > > Vendors might want to add their own capability
> > > > in the PCI capability list. However, Virtio already
> > > > uses the vendor specific capability ID (0x09)
> > > > for its own purposes. =20
> > >=20
> > > Did some vendor express that need, or do we only assume it so far? IO=
W: Do
> > > we know at least once concrete use case? =20
> >=20
> > Good point, I should have added this in the log.
> >=20
> > I know of a device that implements virtio and has a bug.
> >=20
> > Device is a transitional one so can not have vendor specific
> > subsystem IDs (that violates the SHOULD below. Do we want to qualify
> > that this recommendation is for non-transitional devices?). While that
>=20
> What about adding some notes on top that vendor specific subsystem IDs
> are not for transitional devices? That would also catch the case in the
> other update.

I'm still trying to figure out a good wording though.
A full description would need to describe the legacy
tricks with subsystem device ID etc. That's a lot of
text. Certainly doable but
maybe I'll just drop the subsystem vendor ID part
for now, treat that as a different subject?

> > specific device can't be fixed like this on bare metal, it creates a co=
nsistent way
> > for future devices to trigger vendor/device specific quirks,
> > and it creates an option for the hypervisor to add the capability.
> >=20
> > > >=20
> > > > Provide a structure for vendor specific extensions.
> > > >=20
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >   content.tex | 80 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
> > > >   1 file changed, 80 insertions(+)
>=20
> > > > +\devicenormative{\subsection}{Vendor data capability}{Virtio
> > > > +Transport Options / Virtio Over PCI Bus / PCI Device Layout /
> > > > +Vendor data capability}
> > > > +
> > > > +The device SHOULD present the PCI subsystem vendor ID matching
> > > > +the device vendor, at offset 0x2C in its PCI configuration space
> > > > +header.
> > > > +
> > > > +Devices CAN present \field{vendor_id} that does not match
> > > > +either the PCI Vendor ID or the PCI Subsystem Vendor ID.
> > > > +
> > > > +Devices CAN present multiple Vendor data capabilities with
> > > > +either different or identical \field{vendor_id} values.
> > > > +
> > > > +The value \field{vendor_id} MUST NOT equal 0x1AF4.
> > > > +
> > > > +The size of the Vendor data capability MUST be a multiple of 4 byt=
es.
> > > > +
> > > > +Reads of the Vendor data capability by the driver MUST NOT have an=
y
> > > > +side effects.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

