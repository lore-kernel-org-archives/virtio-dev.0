Return-Path: virtio-dev-return-5214-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79B5E985E31
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Dec 2018 07:57:26 +0000 (UTC)
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 28 Dec 2018 08:57:16 +0100
MIME-Version: 1.0
In-Reply-To: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Message-Id: <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v1 0/2] Virtio: fix some vq allocation issues
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: pbonzini@redhat.com, dgilbert@redhat.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 28.12.2018 03:26, Wei Wang wrote:
> Some vqs don't need to be allocated when the related feature bits are
> disabled. Callers notice the vq allocation layer by setting the related
> names[i] to be NULL.
> 
> This patch series fixes the find_vqs implementations to handle this case.

So the random crashes during boot are gone.
What still does not work is actually using the balloon.

So in the qemu monitor using lets say "balloon 1000"  will hang the guest.
Seems to be a deadlock in the virtio-ccw code.  We seem to call the
config code in the interrupt handler.

crash> bt
PID: 0      TASK: d9a400            CPU: 0   COMMAND: "swapper/0"
 LOWCORE INFO:
  -psw      : 0x0404c00180000000 0x0000000000116472
  -function : smp_yield_cpu at 116472
  -prefix   : 0x7fffc000
  -cpu timer: 0x7fffffcc8c0af5be
  -clock cmp: 0x720a4e4002831000
  -general registers:
     000000000000000000 000000000000000000
     0x000000000000009c 0x0000000000fac2b0
     0x0000000000000015 0xffffffffffffffe2
     0x000003e000100000 0x0000000000000001
     000000000000000000 0x0000000000000001
     0x00000000000003e8 0x000000000f85c020
     000000000000000000 0x0000000000000001
     0x0000000000116464 0x000003e00035fad0
  -access registers:
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
     0000000000 0000000000 0000000000 0000000000
  -control registers:
     0x0080000014866a10 0x0000000000fbc007
     0x0000000000100140 000000000000000000
     0x000000000000ffff 0x0000000000100140
     0x0000000031000000 0x000000000f9281c3
     000000000000000000 000000000000000000
     000000000000000000 000000000000000000
     000000000000000000 0x0000000000fbc007
     0x00000000db000000 0x0000000000100280
  -floating point registers:
     000000000000000000 0x000002aa374b0298
     0x0000000000000001 0x0000000000000010
     0x00000000000001ae 0x000000000000000f
     0x000002aa46056010 0x000002aa460681c0
     0x000003ffd867d590 0x000003ffdca7c818
     0x000003ffd867d58f 0x000003fff6ffdc60
     0x000003ffd867dad8 0x000003ffdca7c5e8
     0x000003ffd867dadc 0x000003ffdca7c818

 #0 [3e00035faf8] arch_spin_lock_wait at a7bd52
 #1 [3e00035fb50] ccw_io_helper at 9130ea
 #2 [3e00035fbd0] virtio_ccw_get_config at 914a28
 #3 [3e00035fc30] virtballoon_changed at 76e776
 #4 [3e00035fc70] virtio_config_changed at 76aabc
 #5 [3e00035fca8] virtio_ccw_int_handler at 914ede
 #6 [3e00035fd18] ccw_device_irq at 8941d4
 #7 [3e00035fd48] do_cio_interrupt at 885906
 #8 [3e00035fd80] __handle_irq_event_percpu at 1b3c22
 #9 [3e00035fdf0] handle_irq_event_percpu at 1b3e1e
#10 [3e00035fe28] handle_percpu_irq at 1b87d8
#11 [3e00035fe58] generic_handle_irq at 1b2ce6
#12 [3e00035fe70] do_IRQ at 10c3b2
#13 [3e00035fea8] io_int_handler at a86b3c
 PSW:  0404c00180000000 00000000001034f6 (enabled_wait+70)
 GPRS: ffffffffffffffff 0000000000000000 000000007ff70200 0706c00180000000 
       000000000000000c 000001bf6f331c58 ffffffffffffffff 0000000000000000 
       0000000000000000 0000000000000000 0000000000000000 0000000000000001 
       000000007ff70200 0000000000a8b2f0 00000000001034f6 000003e000317e00 
 #0 [3e000317e28] arch_cpu_idle at 103842
 #1 [3e000317e48] do_idle at 17ad18
 #2 [3e000317e80] cpu_startup_entry at 17af16
 #3 [3e000317ea8] arch_call_rest_init at eac934


> 
> Wei Wang (2):
>   virtio_pci: use queue idx instead of array idx to set up the vq
>   virtio: don't allocate vqs when names[i] = NULL
> 
>  drivers/misc/mic/vop/vop_main.c        |  9 +++++++--
>  drivers/remoteproc/remoteproc_virtio.c |  9 +++++++--
>  drivers/s390/virtio/virtio_ccw.c       | 12 +++++++++---
>  drivers/virtio/virtio_mmio.c           |  9 +++++++--
>  drivers/virtio/virtio_pci_common.c     |  8 ++++----
>  5 files changed, 34 insertions(+), 13 deletions(-)
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

