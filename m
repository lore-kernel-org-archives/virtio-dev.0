Return-Path: <virtio-comment-return-3921-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 26 Jan 2023 16:42:29 +0000
Message-ID: <PH0PR12MB5481CAF904FE0D8CE039BE0DDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
 <20230125155204-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810534C4518320B28BC9D6DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230126000221-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B8FB0C30132E5092BBD5DCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230126112938-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230126112938-mutt-send-email-mst@kernel.org>
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
> Sent: Thursday, January 26, 2023 11:31 AM
>=20
> On Thu, Jan 26, 2023 at 04:27:47PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, January 26, 2023 12:08 AM
> > >
> > > On Wed, Jan 25, 2023 at 11:46:58PM +0000, Parav Pandit wrote:
> > > > > > but vlans are different aren't they? Anyway changing that will
> > > > > > need a new feature bit.
> > > > > I do not the history for about "Note" on why it was made best eff=
ort.
> > > > > To best of my knowledge, it should not be best effort.
> > > > > Device should not overflow the table. It should fail the ADD call=
.
> > >
> > > For the MAC table?  Failing commands generally is a bad way to
> > > communicate to drivers.
> > Failing the command when device cannot do the job is right way to tell =
the
> driver to follow the contract in general terms.
>=20
> There's no contract though. My point is that table size is not in the spe=
c. As long
> as that is the case failing because it's too big is a bad idea.
>=20
I agree that table size should be in the spec.
But I am not convinced that a device should return a fake success and do so=
mething wonky behavior.
For some legacy reason it may have been done, but spec guideline should not=
 be to return some fake success..

> > > So for VLANs this was added by Tiwei. I guess it looked sane then
> > > but now I don't remember the motivation. Tiwei CC'd.
> > > --
> > > MST
I get undeliverable reply for Tiwei's email.
I don't see vlan table being done on best effort in QEMU, nor in mlx5 vdpa =
device.

Si-Wei,
Do you know any implementation that attempts to do vlan on best effort?
Otherwise we should clean this up.

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

