Return-Path: <virtio-dev-return-10749-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 56C4298644E
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 14:41:34 +0000 (UTC)
MIME-Version: 1.0
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230207092439-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230207092439-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 7 Feb 2023 16:40:56 +0200
Message-ID: <CAJs=3_Cv2abDoXTQS5waFO29cX2a1pKjVowt4BNC22hVYdHU1A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH] virtio-net: support
 per-queue coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> Arguably it's true.
> It will all be up to the committee vote of course ...
> To keep things a bit safer how about we just allow commands
> without qid instead of a special qid value?
> Also if we are going to change things how about adding a query command too?
>
> Also Alvaro what is your take on whether the gloabal version counts
> packets and time for all queues together or per queue? The spec
> does not make it clear ATM.

My intention was for it to be global, mirroring ethtool coalescing parameters.
The notification coalescing section doesn't mention virtqueues, but it
is not directly mentioned that these are global parameters.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

