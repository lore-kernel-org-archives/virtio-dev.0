Return-Path: virtio-dev-return-4005-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8EA415818EFB
	for <virtio-dev@lists.oasis-open.org>; Sun, 29 Apr 2018 02:05:57 -0700 (PDT)
References: <20180427113624.15020-1-david@redhat.com>
 <20180427180541-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e5f74e8e-143c-9a27-f6a9-b52983a776d7@redhat.com>
Date: Sun, 29 Apr 2018 11:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180427180541-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Re: [PATCH v1] content: reserve virtio device ID for
 memory devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 27.04.2018 17:06, Michael S. Tsirkin wrote:
> On Fri, Apr 27, 2018 at 01:36:24PM +0200, David Hildenbrand wrote:
>> Reserve device ID 24 for virtio-mem devices.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> OK pls open a github issue and send a Fixes: tag here.
> Then we can vote this in.

Sure, thanks!

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/9


-- 

Thanks,

David / dhildenb

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

