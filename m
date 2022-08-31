Return-Path: <virtio-dev-return-9870-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86695986449
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Aug 2022 13:14:15 +0000 (UTC)
Message-ID: <74de3ef9-960c-12b5-6782-7a38854a6ac2@nvidia.com>
Date: Wed, 31 Aug 2022 21:14:01 +0800
References: <20220831130541.81217-1-gavinl@nvidia.com>
 <20220831130541.81217-3-gavinl@nvidia.com>
 <20220831090907-mutt-send-email-mst@kernel.org>
From: Gavin Li <gavinl@nvidia.com>
In-Reply-To: <20220831090907-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH RESEND v4 2/2] virtio-net: use mtu size as buffer length
 for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, gavi@nvidia.com, parav@nvidia.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/31/2022 9:11 PM, Michael S. Tsirkin wrote:
> Accordingly, for now we assume that if GSO has been negotiated
> then it has been enabled, even if it's actually been disabled
> at runtime through VIRTIO_NET_F_CTRL_GUEST_OFFLOADS.
ACK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

