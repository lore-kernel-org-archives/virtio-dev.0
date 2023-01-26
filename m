Return-Path: <virtio-comment-return-3919-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 26 Jan 2023 16:27:47 +0000
Message-ID: <PH0PR12MB5481B8FB0C30132E5092BBD5DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
 <20230125155204-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810534C4518320B28BC9D6DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230126000221-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230126000221-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, Tiwei Bie <tiwei.bie@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, January 26, 2023 12:08 AM
>=20
> On Wed, Jan 25, 2023 at 11:46:58PM +0000, Parav Pandit wrote:
> > > > but vlans are different aren't they? Anyway changing that will
> > > > need a new feature bit.
> > > I do not the history for about "Note" on why it was made best effort.
> > > To best of my knowledge, it should not be best effort.
> > > Device should not overflow the table. It should fail the ADD call.
>=20
> For the MAC table?  Failing commands generally is a bad way to communicat=
e
> to drivers.=20
Failing the command when device cannot do the job is right way to tell the =
driver to follow the contract in general terms.
A command could be to disable a vq, delete entry, add entry, encrypt data, =
LSO packets and more.
Again in general terms. :)
Device telling driver that it did the job and not doing it in device only b=
rings inferior user experience.

May be QEMU has some history...

> If we do there needs to also be a way to report our limits.=20
Yes, I agree. Reporting limits is good approach we should follow.

> In this case
> it's enough to look at qemu to see an implementation that just sets a "ta=
ble
> overflow" flag and stops filtering.
>=20
> Similarly a populat vhost+bridge+tap combo does not keep the copy of the =
mac
> table at all and instead realies on guest sending announcement packets an=
d
> bridge learning from these.
>
How does this work in a sane way?
Driver set the mac filter table and it doesn't expect random packets to com=
e in?
If the device doesn't maintain the filter table, it is "SHOULD" requirement=
 as stated today on best effort basis.
=20
>=20
> > > If the above claim of "Note" is not strong enough, we can probably
> > > run a different issue to make it "MUST".
> > > I am not sure we really need feature bit it we fix the note.
> >
> > I clicked too early while typing.
> > Since DEL operation doesn't synchronize with the data path of device an=
d
> driver, at some point a packet in pipe can be still received with removed=
 VLAN.
> > So may be the note was added.
> > But for sure ADD should not be best effort basis.
>=20
> So for VLANs this was added by Tiwei. I guess it looked sane then but now=
 I
> don't remember the motivation. Tiwei CC'd.
> --
> MST


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

