Return-Path: <mst@redhat.com>
Date: Mon, 31 Jan 2022 11:01:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220131110100-mutt-send-email-mst@kernel.org>
References: <20220128105012-mutt-send-email-mst@kernel.org>
 <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
 <e80bdf0d-4b52-03ca-6378-cf9e2a062b34@nvidia.com>
 <20220130043917-mutt-send-email-mst@kernel.org>
 <f3644061-70b6-892d-a2e0-1e710bf58609@nvidia.com>
 <20220130093740-mutt-send-email-mst@kernel.org>
 <da7444d6-f67d-3598-814d-a1b945c3542d@nvidia.com>
 <20220130102940-mutt-send-email-mst@kernel.org>
 <87ilu0z2mc.fsf@redhat.com>
 <20220131164729.71eab1b6.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220131164729.71eab1b6.pasic@linux.ibm.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 31, 2022 at 04:47:29PM +0100, Halil Pasic wrote:
> On Mon, 31 Jan 2022 10:16:43 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Sun, Jan 30 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >=20
> > > On Sun, Jan 30, 2022 at 05:12:46PM +0200, Max Gurtovoy wrote: =20
> > >>=20
> > >> On 1/30/2022 4:41 PM, Michael S. Tsirkin wrote: =20
> > >> > On Sun, Jan 30, 2022 at 11:56:30AM +0200, Max Gurtovoy wrote: =20
> > >> > > On 1/30/2022 11:40 AM, Michael S. Tsirkin wrote: =20
> > >> > > > On Sun, Jan 30, 2022 at 11:13:38AM +0200, Max Gurtovoy wrote: =
=20
> > >> > > > > On 1/29/2022 5:53 AM, Jason Wang wrote: =20
> > >> > > > > > On Fri, Jan 28, 2022 at 11:52 PM Michael S. Tsirkin <mst@r=
edhat.com> wrote: =20
> > >> > > > > > > On Fri, Jan 28, 2022 at 04:49:34PM +0100, Cornelia Huck =
wrote: =20
> > >> > > > > > > > On Fri, Jan 28 2022, "Michael S. Tsirkin" <mst@redhat.=
com> wrote:
> > >> > > > > > > >  =20
> > >> > > > > > > > > On Fri, Jan 28, 2022 at 01:14:14PM +0100, Cornelia H=
uck wrote: =20
> > >> > > > > > > > > > On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidi=
a.com> wrote: =20
> > >> > > > > > > > > > > +\section{Admin Virtqueues}\label{sec:Basic Faci=
lities of a Virtio Device / Admin Virtqueues}
> > >> > > > > > > > > > > +
> > >> > > > > > > > > > > +Admin virtqueue is used to send administrative =
commands to manipulate
> > >> > > > > > > > > > > +various features of the device and/or to manipu=
late various features,
> > >> > > > > > > > > > > +if possible, of another device within the same =
group (e.g. PCI VFs of
> > >> > > > > > > > > > > +a parent PCI PF device are grouped together. Th=
ese devices can be
> > >> > > > > > > > > > > +optionally managed by its parent PCI PF using i=
ts admin virtqueue.).
> > >> > > > > > > > > > > +
> > >> > > > > > > > > > > +Use of Admin virtqueue is negotiated by the VIR=
TIO_F_ADMIN_VQ
> > >> > > > > > > > > > > +feature bit.
> > >> > > > > > > > > > > +
> > >> > > > > > > > > > > +Admin virtqueue index may vary among different =
device types. =20
> > >> > > > > > > > > > So, my understanding is:
> > >> > > > > > > > > > - any device type may or may not support the admin=
 vq
> > >> > > > > > > > > > - if the device type wants to be able to accommoda=
te the admin vq, it
> > >> > > > > > > > > >      also needs to specify where it shows up when =
the feature is negotiated
> > >> > > > > > > > > >=20
> > >> > > > > > > > > > Do we expect that eventually all device types will=
 need to support the
> > >> > > > > > > > > > admin vq (if some use case comes along that will r=
equire all devices to
> > >> > > > > > > > > > participate, for example?) =20
> > >> > > > > > > > > I suspect yes. And that's one of the reasons why I'd=
 rather we had a
> > >> > > > > > > > > device independent way to locate the admin queue. Th=
ere are less
> > >> > > > > > > > > transports than device types. =20
> > >> > > > > > > > So, do we want to bite the bullet now and simply say t=
hat every device
> > >> > > > > > > > type has the admin vq as the last vq if the feature is=
 negotiated?
> > >> > > > > > > > Should be straightforward for the device types that ha=
ve a fixed number
> > >> > > > > > > > of vqs, and doable for those that have a variable amou=
nt (two device
> > >> > > > > > > > types are covered by this series anyway.) I think we n=
eed to put it with
> > >> > > > > > > > the device types, as otherwise the numbering of virtqu=
eues could change
> > >> > > > > > > > in unpredictable ways with the admin vq off/on. =20
> > >> > > > > > > Well that only works once. The next thing we'll need we =
won't be able to
> > >> > > > > > > make the last one ;) So I am inclined to add a per-trans=
port field that
> > >> > > > > > > gives the admin queue number. =20
> > >> > > > > > Technically, there's no need to use the same namespace for=
 admin
> > >> > > > > > virtqueue if it has a dedicated notification area. If we g=
o this way,
> > >> > > > > > we can simply use 0 as queue index for admin virtqueue. =20
> > >> > > > > Or we can use index 0xFFFF for admin virtqueue for compatibi=
lity. =20
> > >> > > > I think I'd prefer a register with the #. For example we might=
 want
> > >> > > > to limit the # of VQs in order to pass extra data with the kic=
k write. =20
> > >> > > So you are suggesting adding a new cfg_type (#define
> > >> > > VIRTIO_PCI_CAP_ADMIN_CFG 10) ?
> > >> > >=20
> > >> > > that will look something like:
> > >> > >=20
> > >> > > struct virtio_pci_admin_cfg {
> > >> > >=20
> > >> > >  =A0=A0=A0 le32 queue_index; /* read only for the driver */
> > >> > >=20
> > >> > >  =A0=A0=A0 le16 queue_size; /* read-write */
> > >> > >  =A0=A0=A0 le16 queue_msix_vector; /* read-write */
> > >> > >  =A0=A0=A0 le16 queue_enable; /* read-write */
> > >> > >  =A0=A0=A0 le16 queue_notify_off; /* read-only for driver */
> > >> > >  =A0=A0=A0 le64 queue_desc; /* read-write */
> > >> > >  =A0=A0=A0 le64 queue_driver; /* read-write */
> > >> > >  =A0=A0=A0 le64 queue_device; /* read-write */
> > >> > >  =A0=A0=A0 le16 queue_notify_data; /* read-only for driver */
> > >> > >  =A0=A0=A0 le16 queue_reset; /* read-write */
> > >> > >=20
> > >> > > };
> > >> > >=20
> > >> > > instead of re-using the struct virtio_pci_common_cfg ?
> > >> > >=20
> > >> > >=20
> > >> > > or do you prefer extending the struct virtio_pci_common_cfg with=
 "le16
> > >> > > admin_queue_index; /* read only for the driver */ ? =20
> > >> > The later. Other transports will need this too.
> > >> >=20
> > >> >=20
> > >> > Cornelia has another idea which is that instead of
> > >> > adding just the admin queue register to all transports,
> > >> > we instead add a misc_config structure to all
> > >> > transports. Working basically like device specific config,
> > >> > but being device independent. For now it will only have
> > >> > a single le16 admin_queue_index register.
> > >> >=20
> > >> > For PCI we would thus add it with VIRTIO_PCI_CAP_MISC_CFG
> > >> >=20
> > >> > The point here is that we are making it easier to add
> > >> > more fields just like admin queue index in the future. =20
> > >>=20
> > >> OK.
> > >>=20
> > >> #define VIRTIO_PCI_CAP_MISC_CFG 10
> > >>=20
> > >> and
> > >>=20
> > >> struct virtio_pci_misc_cfg {
> > >>     le16 admin_queue_index; /* read-only for driver */
> > >> };
> > >>=20
> > >> Is agreed by all for V3 ? instead of the net and blk AQ index defini=
tions. =20
> > >
> > > We need to add it to MMIO and CCW I guess too. =20
> >=20
> > That seems ok for pci.
> >=20
> > For ccw, I'd do something like
> >=20
> > #define CCW_CMD_READ_MISC_CONF 0x82
> >=20
> > struct virtio_misc_conf {
> >        be16 admin_queue_index;
> > };
> >=20
> > bound to revision 3, which gets a payload data containing the length of
> > this structure (for future expansions).
> >=20
> > Halil, do you think that would work?
>=20
>=20
> I think so. But I would like to review the actual proposal :)
>=20
> Some of the questions I have in mind are:
> * Are fields in this config protected with feature bits
> * Do we ever need to write this config? Adding a writable field to pci
>   is easier than to ccw (no need to invent a new ccw)
> * Looks like we will have an addressability mismatch with
>   ccw compared to pci and mmio: ccw can only read a prefix of this new
>   config, while mmio and pci have access to the individual fields
> * Is this static stuff only? If not, do we need notifications for config
>   change like for the device specific config?

I'd just reuse the generic config change if we ever add
something non-static.

Donnu about other questions.

> >=20
> > For mmio, I'd need to think a bit more. Any mmio experts around?
> >=20
> >=20
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >=20

