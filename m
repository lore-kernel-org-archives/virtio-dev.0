Return-Path: virtio-return-3412-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 27 Nov 2019 08:23:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191127082230-mutt-send-email-mst@kernel.org>
References: <20191028105508.31769-1-mst@redhat.com>
 <e4cc37c2-ac51-6260-b615-67222bbad1a5@siemens.com>
 <20191125025608-mutt-send-email-mst@kernel.org>
 <20191127085956.6dc635a1.cohuck@redhat.com>
 <20191127055432-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191127055432-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio] Re: [virtio-dev] [PATCH] content: add vendor specific
 cfg type
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 27, 2019 at 05:59:03AM -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 27, 2019 at 08:59:56AM +0100, Cornelia Huck wrote:
> > On Mon, 25 Nov 2019 03:11:43 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >=20
> > > On Mon, Nov 25, 2019 at 08:45:52AM +0100, Jan Kiszka wrote:
> > > > On 28.10.19 11:55, Michael S. Tsirkin wrote: =20
> > > > > Vendors might want to add their own capability
> > > > > in the PCI capability list. However, Virtio already
> > > > > uses the vendor specific capability ID (0x09)
> > > > > for its own purposes. =20
> > > >=20
> > > > Did some vendor express that need, or do we only assume it so far? =
IOW: Do
> > > > we know at least once concrete use case? =20
> > >=20
> > > Good point, I should have added this in the log.
> > >=20
> > > I know of a device that implements virtio and has a bug.
> > >=20
> > > Device is a transitional one so can not have vendor specific
> > > subsystem IDs (that violates the SHOULD below. Do we want to qualify
> > > that this recommendation is for non-transitional devices?). While tha=
t
> >=20
> > What about adding some notes on top that vendor specific subsystem IDs
> > are not for transitional devices? That would also catch the case in the
> > other update.


So how about I just skip the following chunk when I commit?

=09+The device SHOULD present the PCI subsystem vendor ID matching
=09+the device vendor, at offset 0x2C in its PCI configuration space
=09+header.

that seems to belong to the other ballot that I have withdrawn.

Minor enough that I don't feel we need to redo the whole ballot,
right?.

--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

