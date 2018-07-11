Return-Path: virtio-dev-return-4688-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49DE7985BD0
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 19:36:55 +0000 (UTC)
Date: Wed, 11 Jul 2018 22:36:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180711223040-mutt-send-email-mst@kernel.org>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
 <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz>
 <5B45E17D.2090205@intel.com>
 <20180711110949.GJ20050@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711110949.GJ20050@dhcp22.suse.cz>
Subject: [virtio-dev] Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: Wei Wang <wei.w.wang@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, virtio-dev@lists.oasis-open.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, Rik van Riel <riel@redhat.com>, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 11, 2018 at 01:09:49PM +0200, Michal Hocko wrote:
> But let me note that I am not really convinced how this (or previous)
> approach will really work in most workloads. We tend to cache heavily so
> there is rarely any memory free.

It might be that it's worth flushing the cache when VM is
migrating. Or maybe we should implement virtio-tmem or add
transcendent memory support to the balloon.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

