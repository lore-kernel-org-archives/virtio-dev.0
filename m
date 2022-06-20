Return-Path: <virtio-comment-return-3146-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 20 Jun 2022 17:16:36 +0000
Message-ID: <PH0PR12MB54813218E32885C29A17E031DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220517074130-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D968013490C396CD2944DCDC9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620055014-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BB1BE6102DC78E555DEDDCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220620123447-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220620123447-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin
>=20
> On Mon, Jun 20, 2022 at 11:06:07AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Monday, June 20, 2022 6:00 AM
> > >
> > > On Tue, May 31, 2022 at 08:39:24PM +0000, Parav Pandit wrote:
> > > > > And as I said, you will need much more spec work to reach the
> > > > > level to which features are specified - and note we are not yet
> > > > > happy with how features are
> > > > Can you be specific of the work that you are expecting in this v5
> version?
> > >
> > > I proposed getting rid of attrs_mask/device_admin_caps and instead
> > > specify that e.g. feature bits 64 to 95 are reserved for management
> purposes.
> > > Maybe just add a 32 bit register, or maybe "extended features"
> > > with a selector and length like mmio and ccw already do, up to you.
> > > I think Cornelia likes this suggestion too.
> > >
> > > This would replace functionality of the
> > >
> VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY/VIRTIO_ADMIN_DEVICE_CAPS_AC
> > > CEPT
> > > commands and have the advantage of being generally well specified
> > > and understood.
> > >
> > > Is this acceptable? Or is there a reason the new commands are
> preferable?
> >
> > We prefer the new commands for following reason.
> >
> > 1. proposed new command doesn't demand exposing registers in the PCI
> > memory mapped area 2. Today AQ is perceived in to be PF, but it doesn't
> have to be. For next 10 years spec may evolve to have AQ for some other
> purpose on VFs/SFs.
> > Such devices scale at much higher magnitude than PFs.
> > And exposing memory mapped registers for rare functionality is the last
> thing to do in my mind.
> > 3. Placements of such features bits in an AQ gives device lot more flex=
ibility
> on _how_ to implement them. Some in sw, fw, hw, memory die etc.
> > Placement of them in PCI register space reduces these options.
> >
> > So exposing them something in PCI register space has to have strong
> technical reason than just simplicity of access.
>=20
> I ansolutely get this argument. Please do get mine which is avoiding
> duplicating very similar functionality is subtly differing ways.
Yes, because it is anticipated that AQ will be more widely used that adds m=
ore features/functionality.

>=20
> Your above arguments apply equally to most other registers we already
> have.  Wouldn't you then agree we need to address this more drastically b=
y
> defining an alternative transport such as virtio over virtqueue then?

We cannot change what already exists. But we can better define new addition=
s.
If we would be adding AQ only for the purpose of querying feature bits of a=
 device under operation that would be a significant overhead.
But that is not done. An AQ is reused for multiple tasks.

I see feature bits is something that is very essential for device initializ=
ation sequence; without negotiating them it is very hard to operate the dev=
ice.
Implementing them as essential pci registers feature bits makes a total sen=
se like done today.

For AQ features proposed that has no hard requirements of it with device in=
itialization, it is better to query and negotiate run time.

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

