Return-Path: virtio-dev-return-4915-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD94D985CDD
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Oct 2018 10:14:20 +0000 (UTC)
Message-ID: <5BD1988D.7010606@intel.com>
Date: Thu, 25 Oct 2018 18:18:53 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1535333539-32420-1-git-send-email-wei.w.wang@intel.com> <20181024205759-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181024205759-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v37 0/3] Virtio-balloon: support free page reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, dgilbert@redhat.com, torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com, quintela@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/25/2018 08:58 AM, Michael S. Tsirkin wrote:
> On Mon, Aug 27, 2018 at 09:32:16AM +0800, Wei Wang wrote:
>> The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT, implemented by this
>> series enables the virtio-balloon driver to report hints of guest free
>> pages to host. It can be used to accelerate virtual machine (VM) live
>> migration. Here is an introduction of this usage:
>>
>> Live migration needs to transfer the VM's memory from the source machine
>> to the destination round by round. For the 1st round, all the VM's memory
>> is transferred. From the 2nd round, only the pieces of memory that were
>> written by the guest (after the 1st round) are transferred. One method
>> that is popularly used by the hypervisor to track which part of memory is
>> written is to have the hypervisor write-protect all the guest memory.
>>
>> This feature enables the optimization by skipping the transfer of guest
>> free pages during VM live migration. It is not concerned that the memory
>> pages are used after they are given to the hypervisor as a hint of the
>> free pages, because they will be tracked by the hypervisor and transferred
>> in the subsequent round if they are used and written.
> OK so it will be in linux-next.  Now can I trouble you for a virtio spec
> patch with the description please?

No problem, I'll start to patch the spec. Thanks!

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

