Return-Path: virtio-dev-return-2452-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C4B6C1CB807B
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2017 01:52:40 -0700 (PDT)
Message-ID: <5984367A.3030809@intel.com>
Date: Fri, 04 Aug 2017 16:55:22 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <59830897.2060203@intel.com> <20170803112831.GN12521@dhcp22.suse.cz> <5983130E.2070806@intel.com> <20170803124106.GR12521@dhcp22.suse.cz> <59832265.1040805@intel.com> <20170803135047.GV12521@dhcp22.suse.cz> <286AC319A985734F985F78AFA26841F73928C971@shsmsx102.ccr.corp.intel.com> <20170804000043-mutt-send-email-mst@kernel.org> <20170804075337.GC26029@dhcp22.suse.cz> <59842D1C.5020608@intel.com> <20170804082423.GG26029@dhcp22.suse.cz>
In-Reply-To: <20170804082423.GG26029@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v13 4/5] mm: support reporting free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 08/04/2017 04:24 PM, Michal Hocko wrote:
>
>> For our use case, the callback just puts the reported page
>> block to the ring, then returns. If the ring is full as the host
>> is busy, then I think it should skip this one, and just return.
>> Because:
>>      A. This is an optimization feature, losing a couple of free
>>           pages to report isn't that important;
>>      B. In reality, I think it's uncommon to see this ring getting
>>          full (I didn't observe ring full in the tests), since the host
>>          (consumer) is notified to take out the page block right
>>          after it is added.
> I thought you only updated a pre allocated bitmat... Anyway, I cannot
> comment on this part much as I am not familiar with your usecase.
>   

Actually the bitmap is in the hypervisor (host). The callback puts the
(pfn,size) on a ring which is shared with the hypervisor, then the
hypervisor takes that info from the ring and updates that bitmap.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

