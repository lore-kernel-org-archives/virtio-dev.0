Return-Path: virtio-dev-return-2424-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E2B958182C4
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Jul 2017 01:22:47 -0700 (PDT)
Message-ID: <597AF4EF.4020705@intel.com>
Date: Fri, 28 Jul 2017 16:25:19 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com> <1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
To: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, mhocko@kernel.org, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 07/12/2017 08:40 PM, Wei Wang wrote:
> Add a new feature, VIRTIO_BALLOON_F_SG, which enables to
> transfer a chunk of ballooned (i.e. inflated/deflated) pages using
> scatter-gather lists to the host.
>
> The implementation of the previous virtio-balloon is not very
> efficient, because the balloon pages are transferred to the
> host one by one. Here is the breakdown of the time in percentage
> spent on each step of the balloon inflating process (inflating
> 7GB of an 8GB idle guest).
>
> 1) allocating pages (6.5%)
> 2) sending PFNs to host (68.3%)
> 3) address translation (6.1%)
> 4) madvise (19%)
>
> It takes about 4126ms for the inflating process to complete.
> The above profiling shows that the bottlenecks are stage 2)
> and stage 4).
>
> This patch optimizes step 2) by transferring pages to the host in
> sgs. An sg describes a chunk of guest physically continuous pages.
> With this mechanism, step 4) can also be optimized by doing address
> translation and madvise() in chunks rather than page by page.
>
> With this new feature, the above ballooning process takes ~491ms
> resulting in an improvement of ~88%.
>


I found a recent mm patch, bb01b64cfab7c22f3848cb73dc0c2b46b8d38499
, zeros all the ballooned pages, which is very time consuming.

Tests show that the time to balloon 7G pages is increased from ~491 ms to
2.8 seconds with the above patch.

How about moving the zero operation to the hypervisor? In this way, we
will have a much faster balloon process.


Best,
Wei



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

