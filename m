Return-Path: <virtio-dev-return-9336-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8219698646D
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Mar 2022 12:36:37 +0000 (UTC)
Message-ID: <1646137739.411392-1-xuanzhuo@linux.alibaba.com>
Date: Tue, 1 Mar 2022 20:28:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220301083446.55424-1-xuanzhuo@linux.alibaba.com>
 <20220301054557-mutt-send-email-mst@kernel.org>
 <1646134343.8491874-1-xuanzhuo@linux.alibaba.com>
 <20220301071913-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220301071913-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v10] virtio-net: support device stats
Content-Type: text/plain; charset="US-ASCII"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 1 Mar 2022 07:25:16 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Mar 01, 2022 at 07:32:23PM +0800, Xuan Zhuo wrote:
> >
> > I have to say, this design is really good.
> >
> > I think one of the core points of your design is to separate drop stats, gso
> > stats, etc. Get the stats you want based on negotiation and needs. And covering
> > the control queue, I am very surprised.
> >
> > But does this design solve the problem of expansion? Various stats independent
> > structures seem to be convenient for expansion. But is this expansion ready for
> > dynamic negotiation?
>
> For negotiation, we can either separate feature flags for each supported
> type, or do like RSS and add commands for querying supported types
> and enabling stats collection. Features is probably easier
> for now ... Also, do we need to enable/disable stat collection?

I think you mean dynamic enable/disable it. There is no such requirement in our
environment. Since the statistical overhead is very small, I think there is no
need to dynamically disable it.

But I thought it would be interesting to support clearing. It would be useful in
some debugging scenarios. :)

>
>
>
> > My earliest solution is dynamic negotiation, that is, the driver tells the
> > device how many stats it wants to get. And the device negotiates how many stats
> > it should give to the driver based on this information of the driver.
> >
> > But that's not great for migration. So gave up.  @Jason
>
> Any optional feature is problematic for migration, at least with
> features device knows ahead of the time what does driver
> want to use.


I want to make it clear that we will expand stats based on new features or new
commands. So as long as we split up each stats for future expansion, it will be
ok.

I will reorganize a copy based on your design and send it out tomorrow.

Thank you for your help and patience.

>
> --
> MST
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

