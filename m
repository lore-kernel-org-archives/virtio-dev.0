Return-Path: virtio-dev-return-4702-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 816CF985509
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Jul 2018 03:27:01 +0000 (UTC)
Date: Fri, 13 Jul 2018 06:26:57 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180713062627-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180712.144458.2076041018423659380.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712.144458.2076041018423659380.davem@davemloft.net>
Subject: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed ring
To: David Miller <davem@davemloft.net>
Cc: tiwei.bie@intel.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jul 12, 2018 at 02:44:58PM -0700, David Miller wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>
> Date: Wed, 11 Jul 2018 10:27:06 +0800
> 
> > Hello everyone,
> > 
> > This patch set implements packed ring support in virtio driver.
> > 
> > Some functional tests have been done with Jason's
> > packed ring implementation in vhost:
> > 
> > https://lkml.org/lkml/2018/7/3/33
> > 
> > Both of ping and netperf worked as expected.
> 
> Michael and Jason, where are we with this series?

I'm at netdev, won't be able to review before Monday.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

