Return-Path: <virtio-dev-return-10750-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 943F698644E
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 14:48:12 +0000 (UTC)
Date: Tue, 7 Feb 2023 09:48:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230207094403-mutt-send-email-mst@kernel.org>
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230207092439-mutt-send-email-mst@kernel.org>
 <CAJs=3_Cv2abDoXTQS5waFO29cX2a1pKjVowt4BNC22hVYdHU1A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_Cv2abDoXTQS5waFO29cX2a1pKjVowt4BNC22hVYdHU1A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH] virtio-net:
 support per-queue coalescing moderation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 07, 2023 at 04:40:56PM +0200, Alvaro Karsz wrote:
> > Arguably it's true.
> > It will all be up to the committee vote of course ...
> > To keep things a bit safer how about we just allow commands
> > without qid instead of a special qid value?
> > Also if we are going to change things how about adding a query command too?
> >
> > Also Alvaro what is your take on whether the gloabal version counts
> > packets and time for all queues together or per queue? The spec
> > does not make it clear ATM.
> 
> My intention was for it to be global, mirroring ethtool coalescing parameters.
> The notification coalescing section doesn't mention virtqueues, but it
> is not directly mentioned that these are global parameters.

An example of a question is this: we have two RX queues say 1 and 2 each
with a distinct interrupt vector. coalescing is set to 10 packets.  Now
9 packets arrive on queue 1 and 1 on queue 2. Do you expect an
interrupt? If yes which one - 1 or 2 or both?

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

