Return-Path: <virtio-dev-return-9228-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B9879864DD
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Jan 2022 09:17:16 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220130102940-mutt-send-email-mst@kernel.org>
References: <87wnikys4p.fsf@redhat.com>
 <20220128074613-mutt-send-email-mst@kernel.org>
 <87tudnzwq9.fsf@redhat.com>
 <20220128105012-mutt-send-email-mst@kernel.org>
 <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
 <e80bdf0d-4b52-03ca-6378-cf9e2a062b34@nvidia.com>
 <20220130043917-mutt-send-email-mst@kernel.org>
 <f3644061-70b6-892d-a2e0-1e710bf58609@nvidia.com>
 <20220130093740-mutt-send-email-mst@kernel.org>
 <da7444d6-f67d-3598-814d-a1b945c3542d@nvidia.com>
 <20220130102940-mutt-send-email-mst@kernel.org>
Date: Mon, 31 Jan 2022 10:16:43 +0100
Message-ID: <87ilu0z2mc.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 30 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Sun, Jan 30, 2022 at 05:12:46PM +0200, Max Gurtovoy wrote:
>>=20
>> On 1/30/2022 4:41 PM, Michael S. Tsirkin wrote:
>> > On Sun, Jan 30, 2022 at 11:56:30AM +0200, Max Gurtovoy wrote:
>> > > On 1/30/2022 11:40 AM, Michael S. Tsirkin wrote:
>> > > > On Sun, Jan 30, 2022 at 11:13:38AM +0200, Max Gurtovoy wrote:
>> > > > > On 1/29/2022 5:53 AM, Jason Wang wrote:
>> > > > > > On Fri, Jan 28, 2022 at 11:52 PM Michael S. Tsirkin <mst@redha=
t.com> wrote:
>> > > > > > > On Fri, Jan 28, 2022 at 04:49:34PM +0100, Cornelia Huck wrot=
e:
>> > > > > > > > On Fri, Jan 28 2022, "Michael S. Tsirkin" <mst@redhat.com>=
 wrote:
>> > > > > > > >=20
>> > > > > > > > > On Fri, Jan 28, 2022 at 01:14:14PM +0100, Cornelia Huck =
wrote:
>> > > > > > > > > > On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidia.co=
m> wrote:
>> > > > > > > > > > > +\section{Admin Virtqueues}\label{sec:Basic Faciliti=
es of a Virtio Device / Admin Virtqueues}
>> > > > > > > > > > > +
>> > > > > > > > > > > +Admin virtqueue is used to send administrative comm=
ands to manipulate
>> > > > > > > > > > > +various features of the device and/or to manipulate=
 various features,
>> > > > > > > > > > > +if possible, of another device within the same grou=
p (e.g. PCI VFs of
>> > > > > > > > > > > +a parent PCI PF device are grouped together. These =
devices can be
>> > > > > > > > > > > +optionally managed by its parent PCI PF using its a=
dmin virtqueue.).
>> > > > > > > > > > > +
>> > > > > > > > > > > +Use of Admin virtqueue is negotiated by the VIRTIO_=
F_ADMIN_VQ
>> > > > > > > > > > > +feature bit.
>> > > > > > > > > > > +
>> > > > > > > > > > > +Admin virtqueue index may vary among different devi=
ce types.
>> > > > > > > > > > So, my understanding is:
>> > > > > > > > > > - any device type may or may not support the admin vq
>> > > > > > > > > > - if the device type wants to be able to accommodate t=
he admin vq, it
>> > > > > > > > > >      also needs to specify where it shows up when the =
feature is negotiated
>> > > > > > > > > >=20
>> > > > > > > > > > Do we expect that eventually all device types will nee=
d to support the
>> > > > > > > > > > admin vq (if some use case comes along that will requi=
re all devices to
>> > > > > > > > > > participate, for example?)
>> > > > > > > > > I suspect yes. And that's one of the reasons why I'd rat=
her we had a
>> > > > > > > > > device independent way to locate the admin queue. There =
are less
>> > > > > > > > > transports than device types.
>> > > > > > > > So, do we want to bite the bullet now and simply say that =
every device
>> > > > > > > > type has the admin vq as the last vq if the feature is neg=
otiated?
>> > > > > > > > Should be straightforward for the device types that have a=
 fixed number
>> > > > > > > > of vqs, and doable for those that have a variable amount (=
two device
>> > > > > > > > types are covered by this series anyway.) I think we need =
to put it with
>> > > > > > > > the device types, as otherwise the numbering of virtqueues=
 could change
>> > > > > > > > in unpredictable ways with the admin vq off/on.
>> > > > > > > Well that only works once. The next thing we'll need we won'=
t be able to
>> > > > > > > make the last one ;) So I am inclined to add a per-transport=
 field that
>> > > > > > > gives the admin queue number.
>> > > > > > Technically, there's no need to use the same namespace for adm=
in
>> > > > > > virtqueue if it has a dedicated notification area. If we go th=
is way,
>> > > > > > we can simply use 0 as queue index for admin virtqueue.
>> > > > > Or we can use index 0xFFFF for admin virtqueue for compatibility=
.
>> > > > I think I'd prefer a register with the #. For example we might wan=
t
>> > > > to limit the # of VQs in order to pass extra data with the kick wr=
ite.
>> > > So you are suggesting adding a new cfg_type (#define
>> > > VIRTIO_PCI_CAP_ADMIN_CFG 10) ?
>> > >=20
>> > > that will look something like:
>> > >=20
>> > > struct virtio_pci_admin_cfg {
>> > >=20
>> > >  =C2=A0=C2=A0=C2=A0 le32 queue_index; /* read only for the driver */
>> > >=20
>> > >  =C2=A0=C2=A0=C2=A0 le16 queue_size; /* read-write */
>> > >  =C2=A0=C2=A0=C2=A0 le16 queue_msix_vector; /* read-write */
>> > >  =C2=A0=C2=A0=C2=A0 le16 queue_enable; /* read-write */
>> > >  =C2=A0=C2=A0=C2=A0 le16 queue_notify_off; /* read-only for driver *=
/
>> > >  =C2=A0=C2=A0=C2=A0 le64 queue_desc; /* read-write */
>> > >  =C2=A0=C2=A0=C2=A0 le64 queue_driver; /* read-write */
>> > >  =C2=A0=C2=A0=C2=A0 le64 queue_device; /* read-write */
>> > >  =C2=A0=C2=A0=C2=A0 le16 queue_notify_data; /* read-only for driver =
*/
>> > >  =C2=A0=C2=A0=C2=A0 le16 queue_reset; /* read-write */
>> > >=20
>> > > };
>> > >=20
>> > > instead of re-using the struct virtio_pci_common_cfg ?
>> > >=20
>> > >=20
>> > > or do you prefer extending the struct virtio_pci_common_cfg with "le=
16
>> > > admin_queue_index; /* read only for the driver */ ?
>> > The later. Other transports will need this too.
>> >=20
>> >=20
>> > Cornelia has another idea which is that instead of
>> > adding just the admin queue register to all transports,
>> > we instead add a misc_config structure to all
>> > transports. Working basically like device specific config,
>> > but being device independent. For now it will only have
>> > a single le16 admin_queue_index register.
>> >=20
>> > For PCI we would thus add it with VIRTIO_PCI_CAP_MISC_CFG
>> >=20
>> > The point here is that we are making it easier to add
>> > more fields just like admin queue index in the future.
>>=20
>> OK.
>>=20
>> #define VIRTIO_PCI_CAP_MISC_CFG 10
>>=20
>> and
>>=20
>> struct virtio_pci_misc_cfg {
>>     le16 admin_queue_index; /* read-only for driver */
>> };
>>=20
>> Is agreed by all for V3 ? instead of the net and blk AQ index definition=
s.
>
> We need to add it to MMIO and CCW I guess too.

That seems ok for pci.

For ccw, I'd do something like

#define CCW_CMD_READ_MISC_CONF 0x82

struct virtio_misc_conf {
       be16 admin_queue_index;
};

bound to revision 3, which gets a payload data containing the length of
this structure (for future expansions).

Halil, do you think that would work?

For mmio, I'd need to think a bit more. Any mmio experts around?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

