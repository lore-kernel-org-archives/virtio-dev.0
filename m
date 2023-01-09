Return-Path: <virtio-comment-return-3719-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Mon, 9 Jan 2023 14:12:36 +0000
Message-ID: <PH0PR12MB54814FCB63E60BE7F5985A15DCFE9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-2-parav@nvidia.com>
 <20230109083745-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230109083745-mutt-send-email-mst@kernel.org>
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
> Sent: Monday, January 9, 2023 8:43 AM
>=20
> I found another issue with this. Currently for redline diff generation
> we use latexpand. Using a flat expanded file has lots of benefits, in
> particular latexdiff is sometimes fragile as it is, with a flat file
> one can at least see the input it gets.
>=20
> We should either stick with \\input or more work is needed on
> these scripts. Besides, we are already using \\input and I like
> consistency.
>=20
> So my preference is \\input for now.
\\input doesn't support reading from the directory.

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

