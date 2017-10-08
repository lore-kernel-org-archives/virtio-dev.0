Return-Path: virtio-dev-return-2595-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6ABB65819040
	for <virtio-dev@lists.oasis-open.org>; Sat,  7 Oct 2017 23:16:48 -0700 (PDT)
From: Ilya Lesokhin <ilyal@mellanox.com>
Date: Sun, 8 Oct 2017 06:16:44 +0000
Message-ID: <AM4PR0501MB27236B71E1B02176F1844ACBD4770@AM4PR0501MB2723.eurprd05.prod.outlook.com>
References: <20160915223915.qjlnlvf2w7u37bu3@redhat.com> 
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: packed ring layout proposal v3
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> > -----Original Message-----
> > From: virtualization-bounces@lists.linux-foundation.org
> > [mailto:virtualization-bounces@lists.linux-foundation.org] On Behalf
> > Of Michael S. Tsirkin
> >
> > This is an update from v2 version.
>> ...
> > When driver descriptors are chained in this way, multiple descriptors
> > are treated as a part of a single transaction containing an optional
> > write buffer followed by an optional read buffer.
> > All descriptors in the chain must have the same ID.
> >

I apologize for the repost, I didn't realize I have to be a member of the=20
virtio-dev mailing list.

I'm concerned about the "same ID" requirement in chained descriptors.
=20
Assuming out of order execution, how is the driver supposed to re-assign
unique IDs to the previously chained descriptor?
Is the driver expected to copy original IDs somewhere else before the
chaining and then restore the IDs after the chain is executed?
=20
Thanks,
Ilya


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

