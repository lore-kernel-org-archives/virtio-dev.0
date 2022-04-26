Return-Path: <virtio-dev-return-9461-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 459349863F1
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Apr 2022 11:07:27 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Tue, 26 Apr 2022 11:07:24 +0000
Message-ID: <PH0PR12MB54811BAF3BF90E8F9B0F32CBDCFB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1650785333.6800807-1-xuanzhuo@linux.alibaba.com>
 <Ymex3WO746GcBYuZ@stefanha-x1.localdomain>
 <20220426055149-mutt-send-email-mst@kernel.org>
 <1650966920.9889245-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1650966920.9889245-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] queue_reset register polarity to improve
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, April 26, 2022 5:55 AM

> > > The current definition relies on the driver maintaining internal
> > > state (although this could just be assumptions in the code rather
> > > than variables stored in memory) because it cannot determine the
> > > state by reading q_enable and q_reset.
> > >
> > > Introspection may not be important for regular drivers because they
> > > know which previous operations they performed, but in some cases
> > > like driver crash recovery or live migration introspection can be
> > > useful. That said, they can reset the entire device to return to a
> > > known state, if necessary.
> > >
> > > Stefan
> >
> > Sounds like a valid reason, probably a good idea to include in the
> > commit log.
>=20
> In this way, in addition to this reason, one is the complexity of the har=
dware
> state. The other is register polarity, I don't understand what special ef=
fect
> this problem has? It seems to be a hardware related problem.

Not sure I follow your comment.
The proposed fix is simple, q_reset register value has to be same regardles=
s of how the queue is reset.
Either reset VQ using q_reset register or VQ during initial reset time or d=
evice reset time.
All has to show the same value when q reset is completed regardless of hw/s=
w/vendor etc.

Adding to Stefan's point, current definition requires little weird state on=
 the device side implementation too.
I showed both the example pseudo code in the commit log based on current an=
d new polarity.
Please check that show that new polarity makes it much easier to implement.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

