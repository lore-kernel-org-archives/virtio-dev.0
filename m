Return-Path: virtio-dev-return-4700-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64F13985507
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Jul 2018 00:52:25 +0000 (UTC)
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180712.144458.2076041018423659380.davem@davemloft.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7d3b86d0-c6c7-1468-a3a6-e2091c0e63c0@redhat.com>
Date: Fri, 13 Jul 2018 08:52:17 +0800
MIME-Version: 1.0
In-Reply-To: <20180712.144458.2076041018423659380.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed ring
To: David Miller <davem@davemloft.net>, tiwei.bie@intel.com
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtio-dev@lists.oasis-open.org, wexu@redhat.com, jfreimann@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年07月13日 05:44, David Miller wrote:
> From: Tiwei Bie <tiwei.bie@intel.com>
> Date: Wed, 11 Jul 2018 10:27:06 +0800
>
>> Hello everyone,
>>
>> This patch set implements packed ring support in virtio driver.
>>
>> Some functional tests have been done with Jason's
>> packed ring implementation in vhost:
>>
>> https://lkml.org/lkml/2018/7/3/33
>>
>> Both of ping and netperf worked as expected.
> Michael and Jason, where are we with this series?

For the series:

Acked-by: Jason Wang <jasowang@redhat.com>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

