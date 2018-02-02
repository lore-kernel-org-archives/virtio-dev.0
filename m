Return-Path: virtio-dev-return-3131-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 334255818039
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Feb 2018 04:46:25 -0800 (PST)
Message-ID: <5A745E27.7070002@intel.com>
Date: Fri, 02 Feb 2018 20:48:39 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1516871646-22741-1-git-send-email-wei.w.wang@intel.com> <20180201211525-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180201211525-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v25 0/2] Virtio-balloon: support free page reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 02/02/2018 03:15 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 25, 2018 at 05:14:04PM +0800, Wei Wang wrote:
>> This patch series is separated from the previous "Virtio-balloon
>> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>> implemented by this series enables the virtio-balloon driver to report
>> hints of guest free pages to the host. It can be used to accelerate live
>> migration of VMs. Here is an introduction of this usage:
>>
>> Live migration needs to transfer the VM's memory from the source machine
>> to the destination round by round. For the 1st round, all the VM's memory
>> is transferred. From the 2nd round, only the pieces of memory that were
>> written by the guest (after the 1st round) are transferred. One method
>> that is popularly used by the hypervisor to track which part of memory is
>> written is to write-protect all the guest memory.
>>
>> The second feature enables the optimization of the 1st round memory
>> transfer - the hypervisor can skip the transfer of guest free pages in the
>> 1st round. It is not concerned that the memory pages are used after they
>> are given to the hypervisor as a hint of the free pages, because they will
>> be tracked by the hypervisor and transferred in the next round if they are
>> used and written.
> Could you post performance numbers please?

Yes, it was posted here https://lkml.org/lkml/2018/1/25/698

I just changed the host side to poll the vq so that we don't need kick 
in the driver, it works pretty well. I'll test a little bit more and 
post out a new version with new performance numbers attached in the 
cover letter.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

