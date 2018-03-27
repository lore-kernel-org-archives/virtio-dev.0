Return-Path: virtio-dev-return-3658-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EC0658180D0
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Mar 2018 09:07:25 -0700 (PDT)
Date: Tue, 27 Mar 2018 19:07:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180327190635-mutt-send-email-mst@kernel.org>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
 <1522031994-7246-2-git-send-email-wei.w.wang@intel.com>
 <20180326142254.c4129c3a54ade686ee2a5e21@linux-foundation.org>
 <5AB9E377.30900@intel.com>
 <20180327063322.GW5652@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327063322.GW5652@dhcp22.suse.cz>
Subject: [virtio-dev] Re: [PATCH v29 1/4] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: Wei Wang <wei.w.wang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, huangzhichao@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Mar 27, 2018 at 08:33:22AM +0200, Michal Hocko wrote:
> > > > + * The function itself might sleep so it cannot be called from atomic
> > > > + * contexts.
> > > I don't see how walk_free_mem_block() can sleep.
> > 
> > OK, it would be better to remove this sentence for the current version. But
> > I think we could probably keep it if we decide to add cond_resched() below.
> 
> The point of this sentence was to make any user aware that the function
> might sleep from the very begining rather than chase existing callers
> when we need to add cond_resched or sleep for any other reason. So I
> would rather keep it.

Let's say what it is then - "will be changed to sleep in the future".

> -- 
> Michal Hocko
> SUSE Labs

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

