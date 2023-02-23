Return-Path: <virtio-comment-return-4488-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 23 Feb 2023 14:40:46 +0000
Message-ID: <PH0PR12MB5481FD1A82D37157AFCFC541DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230223080358-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230223080358-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [PATCH v9] virtio-net: support inner header hash
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "ailan@redhat.com" <ailan@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 23, 2023 8:14 AM
>=20
> On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:


> So for RSS specifically, we brain-stormed with Amnon (Cc'd) and came up w=
ith
> an idea: RSS indirection table entries are 16 bit but onlu 15 bits are us=
ed to
> indentify an RX queue.
> We can use the remaining bit as a "tunnel bit" to signal whether to use t=
he
> inner or the outer hash for queue selection.
>
I further brainstormed internally with Saeed and Rony on this.

The inner hash is only needed for GRE, IPIP etc.
For VXLAN and NVGRE Linux kernel transmit side uses the entropy of the sour=
ce port of the outer header.
It does that based on the inner header.
Refer to [1] as one example.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/geneve.c#L92=
2

> The lookup will work like this then:
>=20
> calculate outer hash
> if (rss[outer hash] & tunnel bit)
Tunnel bit, you mean tunneled packet, right?

> then
> =09calculate inner hash
> =09return rss[inner hash] & ~tunnel bit
Why to end with a tunnel bit?

> else
> =09return rss[outer hash]
>=20
>=20
> this fixes the security issue returning us back to status quo : specific =
tunnels can
> be directed to separate queues.
>
The number of tunnels is far higher than the number of queues with para vir=
t driver doing decap.
=20
>=20
> This is for RSS.
>=20
>=20
> For hash reporting indirection table is not used.
> Maybe it is enough to signal to driver that inner hash was used.
> We do need that signalling though.
>=20
> My question would be whether it's practical to implement in hardware.

In above example, hw calculating double hash is difficult without much gain=
.
Either calculating on one inner or outer makes sense.

Signaling whether calculated on inner or outer is fine because hw exactly t=
ells what it did.

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

