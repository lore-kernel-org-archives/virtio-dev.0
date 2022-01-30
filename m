Return-Path: <mst@redhat.com>
Date: Sun, 30 Jan 2022 16:15:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Message-ID: <20220130161452-mutt-send-email-mst@kernel.org>
References: <87tudnzwq9.fsf@redhat.com>
 <20220128105012-mutt-send-email-mst@kernel.org>
 <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
 <e80bdf0d-4b52-03ca-6378-cf9e2a062b34@nvidia.com>
 <20220130043917-mutt-send-email-mst@kernel.org>
 <f3644061-70b6-892d-a2e0-1e710bf58609@nvidia.com>
 <20220130093740-mutt-send-email-mst@kernel.org>
 <da7444d6-f67d-3598-814d-a1b945c3542d@nvidia.com>
 <20220130102940-mutt-send-email-mst@kernel.org>
 <25a07ee5-3e2a-62fa-159b-ee7510d2d644@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <25a07ee5-3e2a-62fa-159b-ee7510d2d644@nvidia.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 30, 2022 at 08:23:30PM +0200, Max Gurtovoy wrote:
>=20
> On 1/30/2022 5:30 PM, Michael S. Tsirkin wrote:
> > On Sun, Jan 30, 2022 at 05:12:46PM +0200, Max Gurtovoy wrote:
> > > On 1/30/2022 4:41 PM, Michael S. Tsirkin wrote:
> > > > On Sun, Jan 30, 2022 at 11:56:30AM +0200, Max Gurtovoy wrote:
> > > > > On 1/30/2022 11:40 AM, Michael S. Tsirkin wrote:
> > > > > > On Sun, Jan 30, 2022 at 11:13:38AM +0200, Max Gurtovoy wrote:
> > > > > > > On 1/29/2022 5:53 AM, Jason Wang wrote:
> > > > > > > > On Fri, Jan 28, 2022 at 11:52 PM Michael S. Tsirkin <mst@re=
dhat.com> wrote:
> > > > > > > > > On Fri, Jan 28, 2022 at 04:49:34PM +0100, Cornelia Huck w=
rote:
> > > > > > > > > > On Fri, Jan 28 2022, "Michael S. Tsirkin" <mst@redhat.c=
om> wrote:
> > > > > > > > > >=20
> > > > > > > > > > > On Fri, Jan 28, 2022 at 01:14:14PM +0100, Cornelia Hu=
ck wrote:
> > > > > > > > > > > > On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidia=
.com> wrote:
> > > > > > > > > > > > > +\section{Admin Virtqueues}\label{sec:Basic Facil=
ities of a Virtio Device / Admin Virtqueues}
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +Admin virtqueue is used to send administrative c=
ommands to manipulate
> > > > > > > > > > > > > +various features of the device and/or to manipul=
ate various features,
> > > > > > > > > > > > > +if possible, of another device within the same g=
roup (e.g. PCI VFs of
> > > > > > > > > > > > > +a parent PCI PF device are grouped together. The=
se devices can be
> > > > > > > > > > > > > +optionally managed by its parent PCI PF using it=
s admin virtqueue.).
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +Use of Admin virtqueue is negotiated by the VIRT=
IO_F_ADMIN_VQ
> > > > > > > > > > > > > +feature bit.
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +Admin virtqueue index may vary among different d=
evice types.
> > > > > > > > > > > > So, my understanding is:
> > > > > > > > > > > > - any device type may or may not support the admin =
vq
> > > > > > > > > > > > - if the device type wants to be able to accommodat=
e the admin vq, it
> > > > > > > > > > > >       also needs to specify where it shows up when =
the feature is negotiated
> > > > > > > > > > > >=20
> > > > > > > > > > > > Do we expect that eventually all device types will =
need to support the
> > > > > > > > > > > > admin vq (if some use case comes along that will re=
quire all devices to
> > > > > > > > > > > > participate, for example?)
> > > > > > > > > > > I suspect yes. And that's one of the reasons why I'd =
rather we had a
> > > > > > > > > > > device independent way to locate the admin queue. The=
re are less
> > > > > > > > > > > transports than device types.
> > > > > > > > > > So, do we want to bite the bullet now and simply say th=
at every device
> > > > > > > > > > type has the admin vq as the last vq if the feature is =
negotiated?
> > > > > > > > > > Should be straightforward for the device types that hav=
e a fixed number
> > > > > > > > > > of vqs, and doable for those that have a variable amoun=
t (two device
> > > > > > > > > > types are covered by this series anyway.) I think we ne=
ed to put it with
> > > > > > > > > > the device types, as otherwise the numbering of virtque=
ues could change
> > > > > > > > > > in unpredictable ways with the admin vq off/on.
> > > > > > > > > Well that only works once. The next thing we'll need we w=
on't be able to
> > > > > > > > > make the last one ;) So I am inclined to add a per-transp=
ort field that
> > > > > > > > > gives the admin queue number.
> > > > > > > > Technically, there's no need to use the same namespace for =
admin
> > > > > > > > virtqueue if it has a dedicated notification area. If we go=
 this way,
> > > > > > > > we can simply use 0 as queue index for admin virtqueue.
> > > > > > > Or we can use index 0xFFFF for admin virtqueue for compatibil=
ity.
> > > > > > I think I'd prefer a register with the #. For example we might =
want
> > > > > > to limit the # of VQs in order to pass extra data with the kick=
 write.
> > > > > So you are suggesting adding a new cfg_type (#define
> > > > > VIRTIO_PCI_CAP_ADMIN_CFG 10) ?
> > > > >=20
> > > > > that will look something like:
> > > > >=20
> > > > > struct virtio_pci_admin_cfg {
> > > > >=20
> > > > >   =A0=A0=A0 le32 queue_index; /* read only for the driver */
> > > > >=20
> > > > >   =A0=A0=A0 le16 queue_size; /* read-write */
> > > > >   =A0=A0=A0 le16 queue_msix_vector; /* read-write */
> > > > >   =A0=A0=A0 le16 queue_enable; /* read-write */
> > > > >   =A0=A0=A0 le16 queue_notify_off; /* read-only for driver */
> > > > >   =A0=A0=A0 le64 queue_desc; /* read-write */
> > > > >   =A0=A0=A0 le64 queue_driver; /* read-write */
> > > > >   =A0=A0=A0 le64 queue_device; /* read-write */
> > > > >   =A0=A0=A0 le16 queue_notify_data; /* read-only for driver */
> > > > >   =A0=A0=A0 le16 queue_reset; /* read-write */
> > > > >=20
> > > > > };
> > > > >=20
> > > > > instead of re-using the struct virtio_pci_common_cfg ?
> > > > >=20
> > > > >=20
> > > > > or do you prefer extending the struct virtio_pci_common_cfg with =
"le16
> > > > > admin_queue_index; /* read only for the driver */ ?
> > > > The later. Other transports will need this too.
> > > >=20
> > > >=20
> > > > Cornelia has another idea which is that instead of
> > > > adding just the admin queue register to all transports,
> > > > we instead add a misc_config structure to all
> > > > transports. Working basically like device specific config,
> > > > but being device independent. For now it will only have
> > > > a single le16 admin_queue_index register.
> > > >=20
> > > > For PCI we would thus add it with VIRTIO_PCI_CAP_MISC_CFG
> > > >=20
> > > > The point here is that we are making it easier to add
> > > > more fields just like admin queue index in the future.
> > > OK.
> > >=20
> > > #define VIRTIO_PCI_CAP_MISC_CFG 10
> > >=20
> > > and
> > >=20
> > > struct virtio_pci_misc_cfg {
> > >      le16 admin_queue_index; /* read-only for driver */
> > > };
> > >=20
> > > Is agreed by all for V3 ? instead of the net and blk AQ index definit=
ions.
> > We need to add it to MMIO and CCW I guess too.
> >=20
> > This is Cornelia's idea, we'll need her response.
>=20
> Ok, Cornelia please review the above.
>=20
> For V3 I'll prepare the PCI transport and we can work off list on the MMIO
> and CCW patches for V4.
>=20
> sounds reasonable ?


Yes except pls work on list.



> >=20
> >=20
> > > >=20
> > > > > > > > Thanks
> > > > > > > >=20
> > > > > > > > > Another advantage to this approach is that
> > > > > > > > > we can make sure admin queue gets a page by itself (which=
 can be good if
> > > > > > > > > we want to allow access to regular vqs but not to the adm=
in queue to
> > > > > > > > > guest) even if regular vqs share a page. Will help device=
s use less
> > > > > > > > > memory space.
> > > > > > > > >=20
> > > > > > > > > --
> > > > > > > > > MST
> > > > > > > > >=20

