Return-Path: virtio-dev-return-2634-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BAB15818E62
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Oct 2017 07:35:00 -0700 (PDT)
From: Ilya Lesokhin <ilyal@mellanox.com>
Date: Sun, 29 Oct 2017 14:34:56 +0000
Message-ID: <AM4PR0501MB272332C92A384C97D6975D8DD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com>
 <AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
 <20171025191346-mutt-send-email-mst@kernel.org>
 <AM4PR0501MB2723177BF4E5EE32CC878E8CD4580@AM4PR0501MB2723.eurprd05.prod.outlook.com>
 <20171029162117-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171029162117-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: packed ring layout proposal v3
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Sunday, October 29, 2017 4:22 PM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: virtio-dev@lists.oasis-open.org; virtualization@lists.linux-foundatio=
n.org
> Subject: Re: packed ring layout proposal v3
>=20
> If you do this whats the point of the id? Just use descriptor offset like=
 virtio 0 did.
>=20

I agree that ID is pointless when requests are completed in order.

But I'm not sure what you mean by descriptor offset?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

