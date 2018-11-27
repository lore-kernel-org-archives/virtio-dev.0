Return-Path: virtio-dev-return-5037-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 418A8985B00
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Nov 2018 03:06:49 +0000 (UTC)
Message-ID: <5BFCB5F1.1070300@intel.com>
Date: Tue, 27 Nov 2018 11:11:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH v9 0/8] virtio-balloon: free page hint support
To: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com
Cc: peterx@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 11/15/2018 06:07 PM, Wei Wang wrote:
> This is the deivce part implementation to add a new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> receives the guest free page hints from the driver and clears the
> corresponding bits in the dirty bitmap, so that those free pages are
> not sent by the migration thread to the destination.
>
> *Tests
> 1 Test Environment
>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 400ms
>
> 2 Test Results (results are averaged over several repeated runs)
>      2.1 Guest setup: 8G RAM, 4 vCPU
>          2.1.1 Idle guest live migration time
>              Optimization v.s. Legacy = 620ms vs 2970ms
>              --> ~79% reduction
>          2.1.2 Guest live migration with Linux compilation workload
>            (i.e. make bzImage -j4) running
>            1) Live Migration Time:
>               Optimization v.s. Legacy = 2273ms v.s. 4502ms
>               --> ~50% reduction
>            2) Linux Compilation Time:
>               Optimization v.s. Legacy = 8min42s v.s. 8min43s
>               --> no obvious difference
>
>      2.2 Guest setup: 128G RAM, 4 vCPU
>          2.2.1 Idle guest live migration time
>              Optimization v.s. Legacy = 5294ms vs 41651ms
>              --> ~87% reduction
>          2.2.2 Guest live migration with Linux compilation workload
>            1) Live Migration Time:
>              Optimization v.s. Legacy = 8816ms v.s. 54201ms
>              --> 84% reduction
>            2) Linux Compilation Time:
>               Optimization v.s. Legacy = 8min30s v.s. 8min36s
>               --> no obvious difference
>
> ChangeLog:
> v8->v9:
> bitmap:
>      - fix bitmap_count_one to handle the nbits=0 case
> migration:
>      - replace the ram save notifier chain with a more general precopy
>        notifier chain, which is similar to the postcopy notifier chain.
>      - Avoid exposing the RAMState struct, and add a function,
>        precopy_disable_bulk_stage, to let the virtio-balloon notifier
>        callback to disable the bulk stage flag.

Hi Dave and Peter,

Could you continue to review the patches? Thanks!

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

