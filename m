Return-Path: <virtio-comment-return-3901-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 23 Jan 2023 12:41:16 +0000
Message-ID: <PH0PR12MB54814E64310DE64E19ABD7DADCC89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230110230945.528293-1-parav@nvidia.com>
 <20230123124006.0cae9a96.pasic@linux.ibm.com>
In-Reply-To: <20230123124006.0cae9a96.pasic@linux.ibm.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] [PATCH v9] virtio-network: Clarify VLAN filter table
 configuration
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Halil Pasic <pasic@linux.ibm.com>
> Sent: Monday, January 23, 2023 6:40 AM
>=20
> On Wed, 11 Jan 2023 01:09:45 +0200
> Parav Pandit <parav@nvidia.com> wrote:
>=20
> > The filtering behavior of the VLAN filter commands is not very clear
> > as discussed in thread [1].
>=20
> >
> > Hence, add the command description and device requirements for it.
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202301/msg00136.html
>=20
> Sorry I could not find the discussion. Can you point me to the email wher=
e the
> discussion starts?
>
Latest patch is for this change is : https://lists.oasis-open.org/archives/=
virtio-dev/202301/msg00231.html

There was past discussion at https://www.mail-archive.com/qemu-devel@nongnu=
.org/msg913433.html

> > +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types /
> > +Network Device / Device Operation / Control Virtqueue / VLAN
> > +Filtering}
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device MUST accept
> > +all VLAN tagged packets as per the device configuration.
>=20
> I find "as per the device configuration" difficult to comprehend. Maybe w=
e can
> work on this with an editorial. What are you trying to express here? On o=
ne
> hand you say "the device MUST accept all VLAN tagged packets" on the othe=
r
> hand "per the device configuration" may explain, or may relativize and re=
strict
> that statement.
>=20
From VLAN filtering perspective, it should accept all packets, but this is =
subject to other device configuration such as MAC programming.
The current one is fine that cover both the aspects to VLAN specific and ot=
her config.

> Would
> "When VIRTIO_NET_F_CTRL_VLAN is not negotiated, VLAN filtering is not
> applied. I.e. VLAN tags are ignored by the device."
> also work?
>
No. its not about ignoring "VLAN tags". Its about dealing with "packets" th=
at starts with the VLAN tag.
=20
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST accept all
> > +VLAN tagged packets whose VLAN tag is present in the VLAN filter
> > +table and SHOULD drop all VLAN tagged packets whose VLAN tag is
> > +absent in the VLAN filter table.
> > +
>=20
> Maybe it would be more fortunate to make these statements with respect to
> the VLAN filtering or VLAN filter, and not with respect to the device.
>=20
> For example, if the package is otherwise broken or should be dropped for
> different reasons (maybe MAC filtering?).
>=20
Here the context is only VLAN filter. Packet may be dropped for other reaso=
ns.
We preferably want to stay away from describing it such details here, becau=
se steering features are expected to grow.
And talking about each of them in cross section just complicates it.=20

In near future, I plan to further improve and add a steering section, that =
will describe the hierarchy or interworking of these, unrelated to this.

> BTW why SHOULD drop?
This is the offload feature to drop such packets so that OS driver doesn't =
need to do the filtering work. :)


This publicly archived list offers a means to provide input to the=0D
OASIS Virtual I/O Device (VIRTIO) TC.=0D
=0D
In order to verify user consent to the Feedback License terms and=0D
to minimize spam in the list archive, subscription is required=0D
before posting.=0D
=0D
Subscribe: virtio-comment-subscribe@lists.oasis-open.org=0D
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org=0D
List help: virtio-comment-help@lists.oasis-open.org=0D
List archive: https://lists.oasis-open.org/archives/virtio-comment/=0D
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf=
=0D
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts=0D
Committee: https://www.oasis-open.org/committees/virtio/=0D
Join OASIS: https://www.oasis-open.org/join/

