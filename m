Return-Path: virtio-dev-return-4620-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 271B158191D1
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jun 2018 21:27:40 -0700 (PDT)
Message-ID: <5B370797.1090700@intel.com>
Date: Sat, 30 Jun 2018 12:31:19 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
To: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com, peterx@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 06/25/2018 08:05 PM, Wei Wang wrote:
> This patch series is separated from the previous "Virtio-balloon
> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
> implemented by this series enables the virtio-balloon driver to report
> hints of guest free pages to the host. It can be used to accelerate live
> migration of VMs. Here is an introduction of this usage:
>
> Live migration needs to transfer the VM's memory from the source machine
> to the destination round by round. For the 1st round, all the VM's memory
> is transferred. From the 2nd round, only the pieces of memory that were
> written by the guest (after the 1st round) are transferred. One method
> that is popularly used by the hypervisor to track which part of memory is
> written is to write-protect all the guest memory.
>
> This feature enables the optimization by skipping the transfer of guest
> free pages during VM live migration. It is not concerned that the memory
> pages are used after they are given to the hypervisor as a hint of the
> free pages, because they will be tracked by the hypervisor and transferred
> in the subsequent round if they are used and written.
>
> * Tests
> - Test Environment
>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>      Guest: 8G RAM, 4 vCPU
>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
>
> - Test Results
>      - Idle Guest Live Migration Time (results are averaged over 10 runs):
>          - Optimization v.s. Legacy = 284ms vs 1757ms --> ~84% reduction

According to Michael's comments, add one more set of data here:

Enabling page poison with value=0, and enable KSM.

The legacy live migration time is 1806ms (averaged across 10 runs), 
compared to the case with this optimization feature in use (i.e. 284ms), 
there is still around ~84% reduction.


Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

