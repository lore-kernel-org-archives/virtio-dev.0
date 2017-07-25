Return-Path: virtio-dev-return-2415-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2EF445818206
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Jul 2017 04:53:48 -0700 (PDT)
Message-ID: <597731E8.9040803@intel.com>
Date: Tue, 25 Jul 2017 19:56:24 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com> <1499863221-16206-7-git-send-email-wei.w.wang@intel.com> <20170714123023.GA2624@dhcp22.suse.cz> <20170714181523-mutt-send-email-mst@kernel.org> <20170717152448.GN12888@dhcp22.suse.cz> <596D6E7E.4070700@intel.com> <20170719081311.GC26779@dhcp22.suse.cz> <596F4A0E.4010507@intel.com> <20170724090042.GF25221@dhcp22.suse.cz> <59771010.6080108@intel.com> <20170725112513.GD26723@dhcp22.suse.cz>
In-Reply-To: <20170725112513.GD26723@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v12 6/8] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/25/2017 07:25 PM, Michal Hocko wrote:
> On Tue 25-07-17 17:32:00, Wei Wang wrote:
>> On 07/24/2017 05:00 PM, Michal Hocko wrote:
>>> On Wed 19-07-17 20:01:18, Wei Wang wrote:
>>>> On 07/19/2017 04:13 PM, Michal Hocko wrote:
>>> [...
>>>>> All you should need is the check for the page reference count, no?  I
>>>>> assume you do some sort of pfn walk and so you should be able to get an
>>>>> access to the struct page.
>>>> Not necessarily - the guest struct page is not seen by the hypervisor. The
>>>> hypervisor only gets those guest pfns which are hinted as unused. From the
>>>> hypervisor (host) point of view, a guest physical address corresponds to a
>>>> virtual address of a host process. So, once the hypervisor knows a guest
>>>> physical page is unsued, it knows that the corresponding virtual memory of
>>>> the process doesn't need to be transferred in the 1st round.
>>> I am sorry, but I do not understand. Why cannot _guest_ simply check the
>>> struct page ref count and send them to the hypervisor?
>> Were you suggesting the following?
>> 1) get a free page block from the page list using the API;
> No. Use a pfn walk, check the reference count and skip those pages which
> have 0 ref count.


"pfn walk" - do you mean start from the first pfn, and scan all the pfns 
that the VM has?


> I suspected that you need to do some sort of the pfn
> walk anyway because you somehow have to evaluate a memory to migrate,
> right?


We don't need to do the pfn walk in the guest kernel. When the API 
reports, for example,
a 2MB free page block, the API caller offers to the hypervisor the base 
address of the page
block, and size=2MB, to the hypervisor.

The hypervisor maintains a bitmap of all the guest physical memory (a 
bit corresponds to
a guest pfn). When migrating memory, only the pfns that are set in the 
bitmap are transferred
to the destination machine. So, when the hypervisor receives a 2MB free 
page block, the
corresponding bits in the bitmap are cleared.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

