Return-Path: <virtio-comment-return-3747-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 9 Jan 2023 22:41:26 +0000
Message-ID: <PH0PR12MB54814E201E11B8F1E30A4860DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-2-parav@nvidia.com>
 <20230109083745-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814FCB63E60BE7F5985A15DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230109140825-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230109140825-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v1 01/20] virtio-network: Maintain network device spec in
 separate directory
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, January 9, 2023 2:15 PM
>=20
> > > So my preference is \\input for now.
> > \\input doesn't support reading from the directory.
>=20
> I just tested this and it seems to work fine:
>=20
> \input{sub/file.tex}
>=20
> what is the issue that you see?

I was running with file_conformance.tex name and it doesn't like underscore=
 based named.
And I lost track when I moved away from understore and missed to revert to =
input again.

>=20
> I think I prefer \\input as it's easier to understand.

Yes. I will respin with \input and directories.

>=20
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

