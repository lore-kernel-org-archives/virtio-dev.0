Return-Path: <virtio-dev-return-9903-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E06029864A6
	for <virtio-dev@lists.oasis-open.org>; Wed,  7 Sep 2022 02:57:15 +0000 (UTC)
Message-ID: <76fca691-aff5-ad9e-6228-0377e2890a05@nvidia.com>
Date: Wed, 7 Sep 2022 10:57:01 +0800
From: Gavin Li <gavinl@nvidia.com>
References: <20220901021038.84751-1-gavinl@nvidia.com>
In-Reply-To: <20220901021038.84751-1-gavinl@nvidia.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v5 0/2] Improve virtio performance for 9k mtu
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: stephen@networkplumber.org, davem@davemloft.net, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kuba@kernel.org, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, mst@redhat.com
Cc: gavi@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dave/Jakub, Michael,

Sorry for the previous email formatting.
Should this 2-patch series merge through virtio tree or netdev tree?

On 9/1/2022 10:10 AM, Gavin Li wrote:
> External email: Use caution opening links or attachments
>
>
> This small series contains two patches that improves virtio netdevice
> performance for 9K mtu when GRO/ guest TSO is disabled.
>
> Gavin Li (2):
>    virtio-net: introduce and use helper function for guest gso support
>      checks
>    virtio-net: use mtu size as buffer length for big packets
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
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

