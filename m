Return-Path: <virtio-dev-return-10748-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3773F98643F
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 14:32:01 +0000 (UTC)
Date: Tue, 7 Feb 2023 09:29:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230207092439-mutt-send-email-mst@kernel.org>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH] virtio-net: support per-queue
 coalescing moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 07, 2023 at 12:51:26PM +0000, Parav Pandit wrote:
> 
> > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Sent: Tuesday, February 7, 2023 6:50 AM
> > 
> > On Tue, 7 Feb 2023 13:25:13 +0200, Alvaro Karsz <alvaro.karsz@solid-run.com>
> > wrote:
> > > Hi Heng,
> > >
> > > > Currently, the coalescing profile is directly applied to all queues.
> > > > This patch supports configuring the parameters for a specified queue.
> > > >
> > > > When the traffic between queues is unbalanced, for example, one
> > > > queue is busy and another queue is idle, then it will be very useful
> > > > to control coalescing parameters at the queue granularity.
> > > >
> > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  content.tex | 49 ++++++++++++++++++++++++++++++++++++++++++-------
> > > >  1 file changed, 42 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/content.tex b/content.tex index e863709..049c0e4 100644
> > > > --- a/content.tex
> > > > +++ b/content.tex
> > > > @@ -3084,6 +3084,9 @@ \subsection{Feature bits}\label{sec:Device
> > > > Types / Network Device / Feature bits
> > \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> > > >      channel.
> > > >
> > > > +\item[VIRTIO_NET_F_PERQUEUE_NOTF_COAL(52)] Device supports per-
> > queue
> > > > +       notifications coalescing.
> > > > +
> > >
> > > Since this feature allows us to change the coalescing parameters for
> > > all the queues when rx/tx_qid = 0xFFFF, and since version 1.3 wasn't
> > > released yet, maybe the "per-vq" functionality can be added to
> > > VIRTIO_NET_F_NOTF_COAL instead of adding a new feature?
> > 
> > 
> > According to my understanding, all the features of voting are formal. It can be
> > used by the manufacturer.
> > 
> > Of course, as far as I know, no manufacturer has used this feature for the time
> > being. But I think we should add a new feature.
> > 
> > Or other people have other ideas.
> 
> I believe we should treat it as fix and avoid a new feature bit as spec is not released, and it is very recent change.

Arguably it's true.
It will all be up to the committee vote of course ...
To keep things a bit safer how about we just allow commands
without qid instead of a special qid value?
Also if we are going to change things how about adding a query command too?

Also Alvaro what is your take on whether the gloabal version counts
packets and time for all queues together or per queue? The spec
does not make it clear ATM.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

