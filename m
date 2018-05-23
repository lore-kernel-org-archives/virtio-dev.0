Return-Path: virtio-dev-return-4130-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 604361CB80F0
	for <virtio-dev@lists.oasis-open.org>; Tue, 22 May 2018 22:01:31 -0700 (PDT)
Date: Wed, 23 May 2018 01:01:20 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <965065117.36673579.1527051680099.JavaMail.zimbra@redhat.com>
In-Reply-To: <c2984e27-a8ef-7295-8451-31480ab67216@redhat.com>
References: <20180518044106.31357-1-pagupta@redhat.com> <20180522094248.GI21655@stefanha-x1.localdomain> <c2984e27-a8ef-7295-8451-31480ab67216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: reserve device ID for virtio-pmem
 devices
To: Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Hi Stefan,

> >> We need a device ID for virtio-pmem devices. As 24 is already
> >> requested by virtio-mem, so requesting next available(25)
> >>
> >> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> >> ---
> >>  content.tex | 2 ++
> >>  1 file changed, 2 insertions(+)
> > 
> > virtio-mem is designed for hotplug.  Does it make sense to merge
> > virtio-pmem into virtio-mem since you'll need hotplug too?
> > 
> > Stefan
> > 
> Hi Stefan,
> 
> Initially I had (and even proposed during some discussion) the same
> idea. But it turns out that they are fundamentally different.
> 
> They are memory devices, yes, but that's the point where they stop being
> similar.
> 
> While virtio-pmem wants to expose a memory region as persistent memory
> and adding a flushing interface, virtio-mem is all about managing
> (add/remove/online/offline) sub-chunks and applying protection
> mechanisms on the hypervisor side to make sure unplugged memory cannot
> (or only in some limited sense) be accessed.

Yes, we discussed possibility of merging both these devices in the past.
As rightly explained by David, both these devices solving different problems.
Also, their architectures are different, common part is both use memory device 
& VIRTIO.

Also, as we plan to add more features specific to each virtio{mem/pmem}, it 
will be more confusing and difficult to maintain. I think it makes more sense to 
keep both these devices separate. 

Thanks,
Pankaj


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

