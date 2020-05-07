Return-Path: virtio-dev-return-7261-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59ACB985E10
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 11:34:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-8-david@redhat.com>
 <20200507064558-mutt-send-email-mst@kernel.org>
 <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
Message-ID: <441bfb92-ecfa-f54e-3661-b219ea166e55@redhat.com>
Date: Thu, 7 May 2020 13:33:23 +0200
MIME-Version: 1.0
In-Reply-To: <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v3 07/15] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-ID: <virtio-dev.lists.oasis-open.org>

>> I get:
>>
>> error: sha1 information is lacking or useless (mm/memory_hotplug.c).
>> error: could not build fake ancestor
>>
>> which version is this against? Pls post patches on top of some tag
>> in Linus' tree if possible.
> 
> As the cover states, latest linux-next. To be precise
> 
> commit 6b43f715b6379433e8eb30aa9bcc99bd6a585f77 (tag: next-20200507,
> next/master)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Thu May 7 18:11:31 2020 +1000
> 
>     Add linux-next specific files for 20200507
> 

The patches seem to apply cleanly on top of

commit a811c1fa0a02c062555b54651065899437bacdbe (linus/master)
Merge: b9388959ba50 16f8036086a9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed May 6 20:53:22 2020 -0700

    Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net


I can resend based on that, after giving it a short test.

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

