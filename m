Return-Path: virtio-dev-return-4278-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D37511CB80ED
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Jun 2018 07:40:50 -0700 (PDT)
Date: Tue, 5 Jun 2018 17:40:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605173952-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
 <20180601045824.GH14867@xz-mi>
 <5B10F412.8050900@intel.com>
 <20180601104005.GL14867@xz-mi>
 <20180601153328.GC2531@work-vm>
 <20180605064240.GA9216@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605064240.GA9216@xz-mi>
Subject: [virtio-dev] Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jun 05, 2018 at 02:42:40PM +0800, Peter Xu wrote:
> > I think the answer is no - it doesn't matter; by telling the hypervisor
> > the page is 'free' the kernel gives freedom to the hypervisor to
> > discard the page contents.
> 
> Yeh it seems so.

Well not exactly.  I replied to parent with a clarification.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

