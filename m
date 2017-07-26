Return-Path: virtio-dev-return-2418-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id F16E75818F9A
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Jul 2017 19:19:47 -0700 (PDT)
Message-ID: <5977FCDF.7040606@intel.com>
Date: Wed, 26 Jul 2017 10:22:23 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20170717152448.GN12888@dhcp22.suse.cz> <596D6E7E.4070700@intel.com> <20170719081311.GC26779@dhcp22.suse.cz> <596F4A0E.4010507@intel.com> <20170724090042.GF25221@dhcp22.suse.cz> <59771010.6080108@intel.com> <20170725112513.GD26723@dhcp22.suse.cz> <597731E8.9040803@intel.com> <20170725124141.GF26723@dhcp22.suse.cz> <286AC319A985734F985F78AFA26841F739283F62@shsmsx102.ccr.corp.intel.com> <20170725145333.GK26723@dhcp22.suse.cz>
In-Reply-To: <20170725145333.GK26723@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v12 6/8] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/25/2017 10:53 PM, Michal Hocko wrote:
> On Tue 25-07-17 14:47:16, Wang, Wei W wrote:
>> On Tuesday, July 25, 2017 8:42 PM, hal Hocko wrote:
>>> On Tue 25-07-17 19:56:24, Wei Wang wrote:
>>>> On 07/25/2017 07:25 PM, Michal Hocko wrote:
>>>>> On Tue 25-07-17 17:32:00, Wei Wang wrote:
>>>>>> On 07/24/2017 05:00 PM, Michal Hocko wrote:
>>>>>>> On Wed 19-07-17 20:01:18, Wei Wang wrote:
>>>>>>>> On 07/19/2017 04:13 PM, Michal Hocko wrote:
>>>>>>> [...
>>>> We don't need to do the pfn walk in the guest kernel. When the API
>>>> reports, for example, a 2MB free page block, the API caller offers to
>>>> the hypervisor the base address of the page block, and size=2MB, to
>>>> the hypervisor.
>>> So you want to skip pfn walks by regularly calling into the page allocator to
>>> update your bitmap. If that is the case then would an API that would allow you
>>> to update your bitmap via a callback be s sufficient? Something like
>>> 	void walk_free_mem(int node, int min_order,
>>> 			void (*visit)(unsigned long pfn, unsigned long nr_pages))
>>>
>>> The function will call the given callback for each free memory block on the given
>>> node starting from the given min_order. The callback will be strictly an atomic
>>> and very light context. You can update your bitmap from there.
>> I would need to introduce more about the background here:
>> The hypervisor and the guest live in their own address space. The hypervisor's bitmap
>> isn't seen by the guest. I think we also wouldn't be able to give a callback function
>> from the hypervisor to the guest in this case.
> How did you plan to use your original API which export struct page array
> then?


That's where the virtio-balloon driver comes in. It uses a shared ring 
mechanism to
send the guest memory info to the hypervisor.

We didn't expose the struct page array from the guest to the hypervisor. 
For example, when
a 2MB free page block is reported from the free page list, the info put 
on the ring is just
(base address of the 2MB continuous memory, size=2M).


>
>>> This would address my main concern that the allocator internals would get
>>> outside of the allocator proper.
>> What issue would it have to expose the internal, for_each_zone()?
> zone is a MM internal concept. No code outside of the MM proper should
> really care about zones.

I think this is also what Andrew suggested in the previous discussion:
https://lkml.org/lkml/2017/3/16/951

Move the code to virtio-balloon and a little layering violation seems 
acceptable.


Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

