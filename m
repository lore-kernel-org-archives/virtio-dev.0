Return-Path: <virtio-dev-return-10784-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73D8F9860CC
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Feb 2023 10:41:44 +0000 (UTC)
MIME-Version: 1.0
References: <20230206084746.40536-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB54817FE12FD77CC74B36D136DCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206160206-mutt-send-email-mst@kernel.org> <PH0PR12MB54818A5BD25527FEAEAFF6CCDCDA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230206171410-mutt-send-email-mst@kernel.org> <DM8PR12MB54806C5AF84EB7974D80FE0EDCDA9@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230207091242-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230207091242-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 8 Feb 2023 12:41:06 +0200
Message-ID: <CAJs=3_C8=SVX2CUMx-jbBqF58d9hNfLi=eSPmiOHWD+ZJrhg8Q@mail.gmail.com>
Subject: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] [PATCH] virtio-net: Fix and
 update VIRTIO_NET_F_NOTF_COAL feature
Content-Type: text/plain; charset="UTF-8"
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Seems that we still have some disagreements here.

Should I remove the "best effort" note? I actually think that this is
a good note, but I'll remove it if you think that I should.
Should I replace TX and RX with receive virtqueue and transmit
virtqueue? This may be related to Heng's patch, so maybe we should do
it there?
Should I rephrase the "Notifications When Coalescing Parameters
Change" paragraph?

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

