Return-Path: virtio-dev-return-5200-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61431985E7E
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Dec 2018 06:32:26 +0000 (UTC)
Message-ID: <5C134FAE.9030300@intel.com>
Date: Fri, 14 Dec 2018 14:37:34 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1544516693-5395-1-git-send-email-wei.w.wang@intel.com> <1544516693-5395-2-git-send-email-wei.w.wang@intel.com> <20181213142800.GO2313@work-vm>
In-Reply-To: <20181213142800.GO2313@work-vm>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v11 1/7] bitmap: fix bitmap_count_one
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/13/2018 10:28 PM, Dr. David Alan Gilbert wrote:
> * Wei Wang (wei.w.wang@intel.com) wrote:
>> BITMAP_LAST_WORD_MASK(nbits) returns 0xffffffff when "nbits=0", which
>> makes bitmap_count_one fail to handle the "nbits=0" case. It appears to be
>> preferred to remain BITMAP_LAST_WORD_MASK identical to the kernel
>> implementation that it is ported from.
>>
>> So this patch fixes bitmap_count_one to handle the nbits=0 case.
> OK; it's a little odd that it's only bitmap_count_one that's being fixed
> for this case; but OK.
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Thanks.

We could also help fix other callers outside this series.
(this one is put here as it helps this optimization feature avoid that 
issue).

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

