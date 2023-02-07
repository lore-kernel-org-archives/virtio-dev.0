Return-Path: <virtio-dev-return-10751-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D6B298644E
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Feb 2023 14:56:45 +0000 (UTC)
MIME-Version: 1.0
References: <20230207111634.75542-1-hengqi@linux.alibaba.com>
 <CAJs=3_DXNf0LTXwcY9dNgZJYxkpThhM8o=1KwDNf6+SLdssU-Q@mail.gmail.com>
 <1675770628.725382-1-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481C388B551B89D89747F1CDCDB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230207092439-mutt-send-email-mst@kernel.org> <CAJs=3_Cv2abDoXTQS5waFO29cX2a1pKjVowt4BNC22hVYdHU1A@mail.gmail.com>
 <20230207094403-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230207094403-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Tue, 7 Feb 2023 16:56:06 +0200
Message-ID: <CAJs=3_B8w0Eet5SvfODC2Xwj1rnMmhR2sZpHxjJ4JC=5jnv-xA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH] virtio-net: support
 per-queue coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "virtio-comment @ lists . oasis-open . org" <virtio-comment@lists.oasis-open.org>, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> An example of a question is this: we have two RX queues say 1 and 2 each
> with a distinct interrupt vector. coalescing is set to 10 packets.  Now
> 9 packets arrive on queue 1 and 1 on queue 2. Do you expect an
> interrupt? If yes which one - 1 or 2 or both?

Sorry, I wasn't clear enough.
In this case, you should not issue an interrupt until one of the
queues receives the 10'th packet.
The counters are per queue, the coalescing parameters (usecs and
max_packets) are global.

I agree that this should be mentioned in the spec, I missed it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

