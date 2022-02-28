Return-Path: <virtio-dev-return-9328-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 482A8986281
	for <virtio-dev@lists.oasis-open.org>; Mon, 28 Feb 2022 12:13:27 +0000 (UTC)
Message-ID: <1646050226.152571-1-xuanzhuo@linux.alibaba.com>
Date: Mon, 28 Feb 2022 20:10:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220215074743.35155-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs7NuoGQyn6gQ-fvnaLh3Gccy4vLdmiH8Cve-GJr8mfRQ@mail.gmail.com>
 <1646047299.629008-1-xuanzhuo@linux.alibaba.com>
 <20220228064259-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220228064259-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support device stats
Content-Type: text/plain; charset="US-ASCII"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 28 Feb 2022 06:55:27 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Feb 28, 2022 at 07:21:39PM +0800, Xuan Zhuo wrote:
> > > struct stats{
> > > /* the counters that doesn't need any features */
> > > /* the counters that needs CSUM */
> > > /* the counters that needs GSO */
> > > /* the counters that needs reset */
> > > }
> > >
> > > Or even split them into different commands. The reason is that the
> > > current design requires the knowledge of a feature even if it doesn't
> > > support it.
> >
> >
> > I think this is a good idea.
>
> The issue is this: some stats are only useful if they are correlated.
> For example, # of rx interrupts is not useful unless you also know the #
> of packets. Similar for GSO things. Is it necessary to correlate TX and
> RX events? It might be if driver polls TX ring on an RX interrupt. In
> all these cases we need a single command to return multiple stats for
> atomicity. From that POV having a single struct is great, however if we
> do it like this then it is not clear how are we going to extend it. Do
> we just add fields at the end? Then the clean separation between RX and
> TX fields is lost.

It should still be convenient to add new commands or feature flags.

> Is it always enough to query a single pair of VQs?
> E.g. when querying RSS, might we want to correlate between multiple
> queues to see that traffic is balanced?
>
> So maybe a good design will get an array of structures describing things
> to query and return an array of structures describing the result.

Thanks for your analysis, I think you are right.

Thanks.

>
> --
> MST
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

