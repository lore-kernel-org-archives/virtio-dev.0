Return-Path: <virtio-comment-return-3624-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 26 Dec 2022 01:59:17 +0000
Message-ID: <PH0PR12MB548109FDD1CE702E89496127DCEC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221224183010.74297-1-parav@nvidia.com>
 <20221224160852-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813F0DFB11296B8C29BD85DCEF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20221225063158-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221225063158-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-comment] Re: [PATCH] virtio-network: Avoid confusion
 between a card and a device
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, December 25, 2022 6:33 AM
>=20
> On Sun, Dec 25, 2022 at 12:05:51AM +0000, Parav Pandit wrote:
> >
> >
> > > From: virtio-comment@lists.oasis-open.org
> > > <virtio-comment@lists.oasis- open.org> On Behalf Of Michael S.
> > > Tsirkin
> > >
> > > On Sat, Dec 24, 2022 at 08:30:10PM +0200, Parav Pandit wrote:
> > > > Ethernet card is a relatively vague term in context of virtio
> > > > network device specification. A Ethernet card in the industry has
> > > > one to multiple ports, one to multiple PCI functions.
> > >
> > > Is this the terminology that IEEE uses?
> >
> > I do not know if the IEEE has defined Ethernet _card_ per say.
>=20
> What terminology does it use? I don't have a spec to hand - does not it t=
alk
> about host adapters?
No. In context of IEEE spec 802.3 and 802.1q ocean, there are various terms=
 that address the network device of the host as below.
Mac service providers, link peers, mac client, end station port depending o=
n the part of the spec you refer to.

Virtio spec only refers to the MAC address portion of the IEEE 802.3 spec.


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

