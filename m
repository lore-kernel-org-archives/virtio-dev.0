Return-Path: virtio-dev-return-4277-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B8FEC5818DC6
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Jun 2018 07:39:48 -0700 (PDT)
Date: Tue, 5 Jun 2018 17:39:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605173342-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
 <20180601045824.GH14867@xz-mi>
 <5B10F412.8050900@intel.com>
 <20180601104005.GL14867@xz-mi>
 <20180601153328.GC2531@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601153328.GC2531@work-vm>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jun 01, 2018 at 04:33:29PM +0100, Dr. David Alan Gilbert wrote:
> I think the answer is no - it doesn't matter; by telling the hypervisor
> the page is 'free' the kernel gives freedom to the hypervisor to
> discard the page contents.

I'd like to call attention to this since it's easy to get confused.

That's not exactly true in the current interface.

It's a *hint* not a guarantee.

Let me explain.

It all starts with a request from hypervisor and each free page report
is matched to a request.  What the report says is that the page was free
*sometime after the request was sent to guest*.  If hypervisor was
tracking changes to page all the time since before sending the request,
it can conclude that page was free and can discard the contents.  If it
wasn't then it can't be sure and can not discard the page, it can maybe
use the hint for other decisions (e.g. unused => should be sent before
other pages).

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

