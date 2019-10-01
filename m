Return-Path: virtio-dev-return-6186-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24E0E985FBB
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Oct 2019 19:08:40 +0000 (UTC)
Date: Tue, 1 Oct 2019 15:08:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191001144331-mutt-send-email-mst@kernel.org>
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz, osalvador@suse.de, yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, nitesh@redhat.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Oct 01, 2019 at 09:21:46AM -0700, Alexander Duyck wrote:
> I thought what Michal was asking for was what was the benefit of using the
> boundary pointer. I added a bit up above and to the description for patch
> 3 as on a 32G VM it adds up to about a 18% difference without factoring in
> the page faulting and zeroing logic that occurs when we actually do the
> madvise.

Something maybe worth adding to the log:

one disadvantage of the tight integration with the mm core is
that only a single reporting device is supported.
It's not obvious that more than one is useful though.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

