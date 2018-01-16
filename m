Return-Path: virtio-dev-return-2967-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A2C425818FA3
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Jan 2018 18:40:43 -0800 (PST)
Date: Tue, 16 Jan 2018 04:40:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116042342-mutt-send-email-mst@kernel.org>
References: <AM4PR0501MB27230E63B2FC6BBF79D1419FD4150@AM4PR0501MB2723.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM4PR0501MB27230E63B2FC6BBF79D1419FD4150@AM4PR0501MB2723.eurprd05.prod.outlook.com>
Subject: [virtio-dev] Re: PCIe ordering and new VIRTIO packed ring format.
To: Ilya Lesokhin <ilyal@mellanox.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Liran Liss <liranl@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 14, 2018 at 07:45:50AM +0000, Ilya Lesokhin wrote:
> Hi,
> I have a concern about the portability of offloading the new VIRTIO packed ring format to hardware.
> 
> According to the PCIe rev 2.0, paragraph 2.4.2. Update Ordering and Granularity Observed by a Read Transaction"
> " if a host CPU writes a QWORD to host memory, a Requester reading that QWORD from host memory may observe a portion of the QWORD updated and another portion of it containing the old value."
> 
> This means that after the device reads a 16byte descriptor, it cannot know that all the values In the descriptor are up to date even if the VIRTQ_DESC_F_AVAIL bit is set.
> This is true even if the driver uses the appropriate memory barriers.
> 
> We encountered this behavior in practice on x86 servers. Our solution was to add an index to the latest valid descriptor
> 
> Note that in practice the update granularity in x86 seems to be a cacheline, But this is not guaranteed by the spec. 
> The spec only makes the following recommendation:
> "While not required by this specification, it is strongly recommended that host platforms guarantee that when a host CPU writes aligned DWORDs or aligned QWORDs to host memory, the update granularity observed by a PCI Express read will not be smaller than a DWORD."
> 
> Thanks,
> Ilya

This is a very good point.  This consideration is one of the reasons I
included last valid descriptor in the driver notification.  My guess
would be that such hardware should never use driver event suppression.
As a result, driver will always send notifications after each batch of
descriptors. Device can use that to figure out which descriptors to
fetch. Luckily, with pass-through device memory can be mapped
directly into the VM, so no the notification will not trigger
a VM exit.

It would be interesting to find out whether specific host systems
give a stronger guarantee than what is required by the PCIE spec.
If so we could add e.g. a feature bit to let the device
know it's safe to read beyond the index supplied in the kick
notification. Drivers would detect this and use it to reduce
the overhead.

Conversely, this is also why I selected:
#define VIRTQ_DESC_F_USED      15
this way we don't have the same issue in the reverse order:
the last byte is used to mark buffer as used,
which actually seems to be guaranteed to happen the last from
software point of view in a portable.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

