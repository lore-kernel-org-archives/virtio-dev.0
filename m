Return-Path: virtio-dev-return-4405-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 359B01CB807D
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jun 2018 07:38:43 -0700 (PDT)
Date: Fri, 15 Jun 2018 17:38:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180615172933-mutt-send-email-mst@kernel.org>
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com>
 <20180615142610-mutt-send-email-mst@kernel.org>
 <286AC319A985734F985F78AFA26841F7396A3DC9@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <286AC319A985734F985F78AFA26841F7396A3DC9@shsmsx102.ccr.corp.intel.com>
Subject: [virtio-dev] Re: [PATCH v33 0/4] Virtio-balloon: support free page reporting
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 15, 2018 at 02:28:49PM +0000, Wang, Wei W wrote:
> On Friday, June 15, 2018 7:30 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 15, 2018 at 12:43:09PM +0800, Wei Wang wrote:
> > >       - remove the cmd id related interface. Now host can just send a free
> > >         page hint command to the guest (via the host_cmd config register)
> > >         to start the reporting.
> > 
> > Here we go again. And what if reporting was already started previously?
> > I don't think it's a good idea to tweak the host/guest interface yet again.
> 
> This interface is much simpler, and I'm not sure if that would be an
> issue here now, because now the guest delivers the whole buffer of
> hints to host once, instead of hint by hint as before. And the guest
> notifies host after the buffer is delivered. In any case, the host
> doorbell handler will be invoked, if host doesn't need the hints at
> that time, it will just give back the buffer. There will be no stale
> hints remained in the ring now.
> 
> Best,
> Wei

I still think all the old arguments for cmd id apply.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

