Return-Path: virtio-dev-return-4686-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E6EB985B2D
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 10:48:41 +0000 (UTC)
Message-ID: <5B45E17D.2090205@intel.com>
Date: Wed, 11 Jul 2018 18:52:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com> <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com> <5B455D50.90902@intel.com> <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com> <20180711092152.GE20050@dhcp22.suse.cz>
In-Reply-To: <20180711092152.GE20050@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To: Michal Hocko <mhocko@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/11/2018 05:21 PM, Michal Hocko wrote:
> On Tue 10-07-18 18:44:34, Linus Torvalds wrote:
> [...]
>> That was what I tried to encourage with actually removing the pages
>> form the page list. That would be an _incremental_ interface. You can
>> remove MAX_ORDER-1 pages one by one (or a hundred at a time), and mark
>> them free for ballooning that way. And if you still feel you have tons
>> of free memory, just continue removing more pages from the free list.
> We already have an interface for that. alloc_pages(GFP_NOWAIT, MAX_ORDER -1).
> So why do we need any array based interface?

Yes, I'm trying to get free pages directly via alloc_pages, so there 
will be no new mm APIs.
I plan to let free page allocation stop when the remaining system free 
memory becomes close to min_free_kbytes (prevent swapping).


Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

