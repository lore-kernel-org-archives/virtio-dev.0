Return-Path: virtio-dev-return-5062-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 19213985D04
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Nov 2018 17:08:43 +0000 (UTC)
Date: Wed, 28 Nov 2018 12:08:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181128120516-mutt-send-email-mst@kernel.org>
References: <20181005101419-mutt-send-email-mst@kernel.org>
 <CADGSJ22QYRX3GBjDqGgauwiHi6p4FpbUwpromD0=nY+w2FDm=Q@mail.gmail.com>
 <20181018233115-mutt-send-email-mst@kernel.org>
 <CAKPgXcH4mokJd7MeTUNjoGzo6Lbyx72cOQPLfKccQLwVHSMArg@mail.gmail.com>
 <20181121124246-mutt-send-email-mst@kernel.org>
 <CAKPgXcH2D4XcUNoS6tvDfLxPAv05u7Yu77OYxRnuFFfgN34A_w@mail.gmail.com>
 <20181122132626-mutt-send-email-mst@kernel.org>
 <CAKPgXcHT9rOt=FLSpK1qndJVMe1c7sDDqmHWenXVT5CaXt4Rxg@mail.gmail.com>
 <CAKPgXcEXVjH6ZHLLYA-rC+4LM43HMmZN2AgsJMpJJjhPm7cK2Q@mail.gmail.com>
 <25a340eb-62a8-ea90-5f0d-0ee3171479ce@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25a340eb-62a8-ea90-5f0d-0ee3171479ce@intel.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, Siwei Liu <loseweigh@gmail.com>, venu.busireddy@oracle.com, cohuck@redhat.com, virtio-dev <virtio-dev@lists.oasis-open.org>, liran.alon@oracle.com, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 26, 2018 at 12:22:56PM -0800, Samudrala, Sridhar wrote:
> > Update:
> > I have just set the vf mac's address to 0 (ip link set ens2f0 vf 1 mac
> > 00:00:00:00:00:00) after unplugging it (the primary device) and the
> > pings started working again on the failover interface. So it seems
> > like the frames were arriving to the vf on the host.
> > 
> > 
> 
> Yes. When the VF is unplugged, you need to reset the VFs MAC so that the packets
> with VMs MAC start flowing via VF, bridge and the virtio interface.
> 
> Have you looked at this documentation that shows a sample script to initiate live
> migration?
> https://www.kernel.org/doc/html/latest/networking/net_failover.html
> 
> -Sridhar

Interesting I didn't notice it does this. So in fact
just defining VF mac will immediately divert packets
to the VF? Given guest driver did not initialize VF
yet won't a bunch of packets be dropped?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

