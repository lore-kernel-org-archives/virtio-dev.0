Return-Path: virtio-dev-return-3059-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 71AE758191AB
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 01:42:49 -0800 (PST)
Message-ID: <5A69A72F.4000104@intel.com>
Date: Thu, 25 Jan 2018 17:45:19 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516790562-37889-1-git-send-email-wei.w.wang@intel.com> <1516790562-37889-3-git-send-email-wei.w.wang@intel.com> <20180124183349-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180124183349-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v24 2/2] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 01/25/2018 01:15 AM, Michael S. Tsirkin wrote:
> On Wed, Jan 24, 2018 at 06:42:42PM +0800, Wei Wang wrote:
>>   
>>
>> What is this doing? Basically handling the case where vq is broken?
>> It's kind of ugly to tweak feature bits, most code assumes they never
>> change.  Please just return an error to caller instead and handle it
>> there.
>>
>> You can then avoid sprinking the check for the feature bit
>> all over the code.
>>
>
> One thing I don't like about this one is that the previous request
> will still try to run to completion.
>
> And it all seems pretty complex.
>
> How about:
> - pass cmd id to a queued work
> - queued work gets that cmd id, stores a copy and uses that,
>    re-checking periodically - stop if cmd id changes:
>    will replace  report_free_page too since that's set to
>    stop.
>
> This means you do not reuse the queued cmd id also
> for the buffer - which is probably for the best.

Thanks for the suggestion. Please have a check how it's implemented in v25.
Just a little reminder that work queue has internally ensured that there 
is no re-entrant of the same queued function.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

