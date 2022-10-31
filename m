Return-Path: <virtio-dev-return-10105-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F188098642C
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Oct 2022 15:48:02 +0000 (UTC)
Date: Mon, 31 Oct 2022 11:47:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221031114727-mutt-send-email-mst@kernel.org>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-4-usama.arif@bytedance.com>
 <Y1r3wEnQwTsZqGWg@fedora>
 <a0773598-1ce5-1b98-5aa1-95350bccdbb6@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <a0773598-1ce5-1b98-5aa1-95350bccdbb6@bytedance.com>
Subject: [virtio-dev] Re: [External] Re: [PATCH v3 3/4] content: Introduce driver/device
 auxiliary notifications for MMIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Usama Arif <usama.arif@bytedance.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 31, 2022 at 02:22:22PM +0000, Usama Arif wrote:
> 
> 
> On 27/10/2022 22:27, Stefan Hajnoczi wrote:
> > On Fri, Oct 07, 2022 at 05:56:42PM +0100, Usama Arif wrote:
> > > This includes the additions to the corresponding device and driver
> > > conformances.
> > > 
> > > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > You can keep this. One thought:
> > 
> > I realized that virtio-mmio support won't be very useful until
> > virtio-mmio gets MSI-X support because drivers currently cannot
> > differentiate between device auxiliary notifications.
> > 
> > Stefan
> 
> Did you mean drivers currently cannot differentiate between "driver"
> auxiliary notifications? The driver will be able to be able to choose the
> index it wants to notifiy using DeviceAuxNotificationIndex.
> 
> I can add the following line in the Interrupt Status change of the patch if
> it makes sense?
> "As MSI-X is not available, it is not possible to determine which driver

drop "As MSI-X is not available," msi-x is a pci technology.

> auxiliary notification occured, hence only a single notification is
> supported."
> 
> Thanks,
> Usama


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

