Return-Path: virtio-dev-return-7466-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 66A4A986107
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Jun 2020 11:41:31 +0000 (UTC)
Date: Thu, 11 Jun 2020 07:41:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200611073943-mutt-send-email-mst@kernel.org>
References: <20200611071744-mutt-send-email-mst@kernel.org>
 <613382D2-5F4D-4A32-AC8E-E1D03240036F@redhat.com>
MIME-Version: 1.0
In-Reply-To: <613382D2-5F4D-4A32-AC8E-E1D03240036F@redhat.com>
Subject: [virtio-dev] Re: [PATCH v1] virtio-mem: add memory via add_memory_driver_managed()
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jun 11, 2020 at 01:33:04PM +0200, David Hildenbrand wrote:
> 
> 
>     Am 11.06.2020 um 13:18 schrieb Michael S. Tsirkin <mst@redhat.com>:
> 
> 
>     On Thu, Jun 11, 2020 at 01:00:24PM +0200, David Hildenbrand wrote:
> 
>                 I'd like to have this patch in 5.8, with the initial merge of
>                 virtio-mem
> 
>                 if possible (so the user space representation of virtio-mem
>                 added memory
> 
>                 resources won't change anymore).
> 
>            
> 
>             So my plan is to rebase on top of -rc1 and merge this for rc2 then.
> 
>             I don't like rebase on top of tip as the results are sometimes kind
>             of
> 
>             random.
> 
>        
> 
>         Right, I just wanted to get this out early so we can discuss how to
>         proceed.
> 
>        
> 
>             And let's add a Fixes: tag as well, this way people will remember
>             to
> 
>             pick this.
> 
>             Makes sense?
> 
>        
> 
>         Yes, it's somehow a fix (for kexec). So
> 
>        
> 
>         Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
> 
>        
> 
>         I can respin after -rc1 with the commit id fixed as noted by Pankaj.
> 
>         Just let me know what you prefer.
> 
>        
> 
>         Thanks!
> 
>    
>     Some once this commit is in Linus' tree, please ping me.
> 
> 
> It already is as mentioned, only the id was wrong.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=
> 7b7b27214bba1966772f9213cd2d8e5d67f8487f

OK I pushed this into next based on tip. Let's see what happens.


> 
>    
> 
>         --
> 
>         Thanks,
> 
>        
> 
>         David / dhildenb
> 
>    
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

