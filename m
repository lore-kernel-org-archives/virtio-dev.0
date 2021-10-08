Return-Path: <virtio-dev-return-8826-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1FC2986561
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Oct 2021 11:47:51 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211008071903-mutt-send-email-mst@kernel.org>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org>
Date: Fri, 08 Oct 2021 13:47:40 +0200
Message-ID: <87lf33ybz7.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2] Add device reset timeout field
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 08 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Oct 08, 2021 at 10:59:02AM +0000, Parav Pandit wrote:
>> It may be even a pre-boot environment where 100msec or 10msec may be too short interval as other extreme of VM boot time example.
>
> I don't really know what this means. We are talking about how long
> it takes device to calm down and stop poking at the host
> after it's told to reset. 10ms worst case not enough for this?

To me, that sounded more like a physical device that needs to do
something like boot its firmware before it can perform an actual virtio
operation (and reset simply happens to be the first one.)

So, I'm getting more confused about the scope of this timeout. If it's
more a "device might not be ready yet" issue, I don't think we need a
timeout for reset specifically. Same for races with hotplugging. If it's
about "reset may take some time, because it will take some time before
all operations have quiesced", I don't see how the device can come up
with a value that isn't anything other than a wild guess, and the driver
could do wild guessing equally well.

I feel like I'm missing something.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

