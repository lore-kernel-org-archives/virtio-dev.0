Return-Path: virtio-dev-return-4895-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 776BA985CB4
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Oct 2018 14:14:51 +0000 (UTC)
Date: Thu, 11 Oct 2018 22:13:31 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20181011141331.GA11650@debian>
References: <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
 <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
 <20181010103335-mutt-send-email-mst@kernel.org>
 <20181011121221.GA27106@debian>
 <20181011094705-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011094705-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com, zhihong.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 11, 2018 at 09:48:48AM -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 11, 2018 at 08:12:21PM +0800, Tiwei Bie wrote:
> > > > But if it's not too late, I second for a OUT_OF_ORDER feature.
> > > > Starting from in order can have much simpler code in driver.
> > > > 
> > > > Thanks
> > > 
> > > It's tricky to change the flag polarity because of compatibility
> > > with legacy interfaces. Why is this such a big deal?
> > > 
> > > Let's teach drivers about IN_ORDER, then if devices
> > > are in order it will get enabled by default.
> > 
> > Yeah, make sense.
> > 
> > Besides, I have done some further profiling and debugging
> > both in kernel driver and DPDK vhost. Previously I was mislead
> > by a bug in vhost code. I will send a patch to fix that bug.
> > With that bug fixed, the performance of packed ring in the
> > test between kernel driver and DPDK vhost is better now.
> 
> OK, if we get a performance gain on the virtio side, we can finally
> upstream it. If you see that please re-post ASAP so we can
> put it in the next kernel release.

Got it, I will re-post ASAP.

Thanks!


> 
> -- 
> MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

