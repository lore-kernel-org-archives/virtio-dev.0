Return-Path: virtio-dev-return-4761-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA06F985CD2
	for <virtio-dev@lists.oasis-open.org>; Wed,  1 Aug 2018 11:08:11 +0000 (UTC)
Message-ID: <5B619599.1000307@intel.com>
Date: Wed, 01 Aug 2018 19:12:25 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com> <1532683495-31974-3-git-send-email-wei.w.wang@intel.com> <20180730090041.GC24267@dhcp22.suse.cz>
In-Reply-To: <20180730090041.GC24267@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v2 2/2] virtio_balloon: replace oom notifier with shrinker
To: Michal Hocko <mhocko@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mst@redhat.com, akpm@linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/30/2018 05:00 PM, Michal Hocko wrote:
> On Fri 27-07-18 17:24:55, Wei Wang wrote:
>> The OOM notifier is getting deprecated to use for the reasons mentioned
>> here by Michal Hocko: https://lkml.org/lkml/2018/7/12/314
>>
>> This patch replaces the virtio-balloon oom notifier with a shrinker
>> to release balloon pages on memory pressure.
> It would be great to document the replacement. This is not a small
> change...

OK. I plan to document the following to the commit log:

   The OOM notifier is getting deprecated to use for the reasons:
     - As a callout from the oom context, it is too subtle and easy to
       generate bugs and corner cases which are hard to track;
     - It is called too late (after the reclaiming has been performed).
       Drivers with large amuont of reclaimable memory is expected to be
       released them at an early age of memory pressure;
     - The notifier callback isn't aware of the oom contrains;
     Link: https://lkml.org/lkml/2018/7/12/314

     This patch replaces the virtio-balloon oom notifier with a shrinker
     to release balloon pages on memory pressure. Users can set the 
amount of
     memory pages to release each time a shrinker_scan is called via the
     module parameter balloon_pages_to_shrink, and the default amount is 256
     pages. Historically, the feature VIRTIO_BALLOON_F_DEFLATE_ON_OOM has
     been used to release balloon pages on OOM. We continue to use this
     feature bit for the shrinker, so the shrinker is only registered when
     this feature bit has been negotiated with host.

     In addition, the bug in the replaced virtballoon_oom_notify that only
     VIRTIO_BALLOON_ARRAY_PFNS_MAX (i.e 256) balloon pages can be freed
     though the user has specified more than that number is fixed in the
     shrinker_scan function.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

