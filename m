Return-Path: <virtio-dev-return-9989-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C607198660E
	for <virtio-dev@lists.oasis-open.org>; Thu, 29 Sep 2022 06:50:14 +0000 (UTC)
Message-ID: <68934c1a-6c75-f410-2c29-1a7edc97aeb9@nvidia.com>
Date: Thu, 29 Sep 2022 14:50:00 +0800
From: Gavin Li <gavinl@nvidia.com>
References: <20220914144911.56422-1-gavinl@nvidia.com>
In-Reply-To: <20220914144911.56422-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v6 0/2] Improve virtio performance for 9k mtu
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 9/14/2022 10:49 PM, Gavin Li wrote:
> External email: Use caution opening links or attachments
>
>
> This small series contains two patches that improves virtio netdevice
> performance for 9K mtu when GRO/ guest TSO is disabled.
>
> Gavin Li (2):
>    virtio-net: introduce and use helper function for guest gso support
>      checks
> ---
> changelog:
> v4->v5
> - Addressed comments from Michael S. Tsirkin
> - Remove unnecessary () in return clause
> v1->v2
> - Add new patch
> ---
>    virtio-net: use mtu size as buffer length for big packets
> ---
> changelog:
> v5->v6
> - Addressed comments from Jason and Michael S. Tsirkin
> - Remove wrong commit log description
> - Rename virtnet_set_big_packets_fields with virtnet_set_big_packets
> - Add more test results for different feature combinations
> v4->v5
> - Addressed comments from Michael S. Tsirkin
> - Improve commit message
> v3->v4
> - Addressed comments from Si-Wei
> - Rename big_packets_sg_num with big_packets_num_skbfrags
> v2->v3
> - Addressed comments from Si-Wei
> - Simplify the condition check to enable the optimization
> v1->v2
> - Addressed comments from Jason, Michael, Si-Wei.
> - Remove the flag of guest GSO support, set sg_num for big packets and
>    use it directly
> - Recalculate sg_num for big packets in virtnet_set_guest_offloads
> - Replace the round up algorithm with DIV_ROUND_UP
> ---
>
>   drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++--------------
>   1 file changed, 32 insertions(+), 16 deletions(-)
>
> --
> 2.31.1
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
Did you get a chance to pull these short series?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

