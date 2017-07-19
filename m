Return-Path: virtio-dev-return-2409-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E3E6F5818FAD
	for <virtio-dev@lists.oasis-open.org>; Wed, 19 Jul 2017 04:58:50 -0700 (PDT)
Message-ID: <596F4A0E.4010507@intel.com>
Date: Wed, 19 Jul 2017 20:01:18 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com> <1499863221-16206-7-git-send-email-wei.w.wang@intel.com> <20170714123023.GA2624@dhcp22.suse.cz> <20170714181523-mutt-send-email-mst@kernel.org> <20170717152448.GN12888@dhcp22.suse.cz> <596D6E7E.4070700@intel.com> <20170719081311.GC26779@dhcp22.suse.cz>
In-Reply-To: <20170719081311.GC26779@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v12 6/8] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/19/2017 04:13 PM, Michal Hocko wrote:
> On Tue 18-07-17 10:12:14, Wei Wang wrote:
> [...]
>> Probably I should have included the introduction of the usages in
>> the log. Hope it is not too later to explain here:
> Yes this should have been described in the cover.


OK, I will do it in the next version.


>   
>> Live migration needs to transfer the VM's memory from the source
>> machine to the destination round by round. For the 1st round, all the VM's
>> memory is transferred. From the 2nd round, only the pieces of memory
>> that were written by the guest (after the 1st round) are transferred. One
>> method that is popularly used by the hypervisor to track which part of
>> memory is written is to write-protect all the guest memory.
>>
>> This patch enables the optimization of the 1st round memory transfer -
>> the hypervisor can skip the transfer of guest unused pages in the 1st round.
> All you should need is the check for the page reference count, no?  I
> assume you do some sort of pfn walk and so you should be able to get an
> access to the struct page.


Not necessarily - the guest struct page is not seen by the hypervisor. The
hypervisor only gets those guest pfns which are hinted as unused. From the
hypervisor (host) point of view, a guest physical address corresponds to a
virtual address of a host process. So, once the hypervisor knows a guest
physical page is unsued, it knows that the corresponding virtual memory of
the process doesn't need to be transferred in the 1st round.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

