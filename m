Return-Path: <virtio-comment-return-3621-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Sun, 25 Dec 2022 00:26:12 +0000
Message-ID: <PH0PR12MB5481590B413875096E262FD9DCEF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221224180619.73959-1-parav@nvidia.com>
 <20221224162951-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221224162951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: RE: [virtio-comment] Re: [PATCH 0/6] Split device spec to its
 individual files
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Michael S. Tsirkin

> On Sat, Dec 24, 2022 at 08:06:13PM +0200, Parav Pandit wrote:
> > Relatively several of the recent device specification are maintained
> > in their own specification file. Such separate files enables better
> > maintenance of the specification overall.
> > However, several of the initial virtio device specifications are
> > located in single file.
> >
> > Hence, split them into their individual files.
>=20
> Makes sense to me.
> As a follow-up, how about splitting out conformace sections as well?

Good point.
I missed to add conformance section link in patch [1].

Once it is in the file errors made in [1] can be reduced.
Will do in generic conformance series as follow up.

[1] https://lists.oasis-open.org/archives/virtio-dev/202212/msg00056.html



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

