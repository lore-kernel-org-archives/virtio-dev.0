Return-Path: <virtio-dev-return-10104-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E722A98642C
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Oct 2022 15:46:02 +0000 (UTC)
Date: Mon, 31 Oct 2022 11:45:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221031114132-mutt-send-email-mst@kernel.org>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-4-usama.arif@bytedance.com>
 <Y1r3wEnQwTsZqGWg@fedora>
MIME-Version: 1.0
In-Reply-To: <Y1r3wEnQwTsZqGWg@fedora>
Subject: [virtio-dev] Re: [PATCH v3 3/4] content: Introduce driver/device auxiliary
 notifications for MMIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 27, 2022 at 05:27:28PM -0400, Stefan Hajnoczi wrote:
> On Fri, Oct 07, 2022 at 05:56:42PM +0100, Usama Arif wrote:
> > This includes the additions to the corresponding device and driver
> > conformances.
> > 
> > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> You can keep this. One thought:
> 
> I realized that virtio-mmio support won't be very useful until
> virtio-mmio gets MSI-X support because drivers currently cannot
> differentiate between device auxiliary notifications.
> 
> Stefan


The big issue with MSI is it actually needs a ton of registers
for interrupt rebalancing, masking etc and they need to be fast.
Maybe a status bit like pci has makes sense here.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

