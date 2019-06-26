Return-Path: virtio-dev-return-5817-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 12C6A985D1D
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Jun 2019 07:53:09 +0000 (UTC)
Date: Wed, 26 Jun 2019 09:52:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190626095259.1343e509.cohuck@redhat.com>
In-Reply-To: <20190626000046.wnjpwqg7bwkkrd44@sirius.home.kraxel.org>
References: <20190625171541.05528049.cohuck@redhat.com>
	<20190626000046.wnjpwqg7bwkkrd44@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: Sleeping while atomic in virtio-gpu edid handling
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 26 Jun 2019 02:00:46 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Tue, Jun 25, 2019 at 05:15:41PM +0200, Cornelia Huck wrote:
> > Hi Gerd,
> > 
> > flipping the virtio-gpu edid support in QEMU to default enabled exposed
> > the following backtrace in my guest (from my bisect run down to the
> > initial commit in Linux):
> > 
> > [drm] virgl 3d acceleration not supported by guest
> > [drm] EDID support available.
> > [drm] number of scanouts: 1
> > [drm] number of cap sets: 0
> > BUG: sleeping function called from invalid context at mm/slab.h:421
> > in_atomic(): 1, irqs_disabled(): 0, pid: 7, name: kworker/0:1
> > 3 locks held by kworker/0:1/7:
> >  #0: (____ptrval____) ((wq_completion)"events"){+.+.}, at: process_one_work+0x1c8/0x618
> >  #1: (____ptrval____) ((work_completion)(&vgvq->dequeue_work)){+.+.}, at: process_one_work+0x1c8/0x618
> >  #2: (____ptrval____) (&(&vgdev->display_info_lock)->rlock){+.+.}, at: virtio_gpu_cmd_get_edid_cb+0x6e/0xc0
> > CPU: 0 PID: 7 Comm: kworker/0:1 Tainted: G        W         4.20.0-rc1+ #142
> > Hardware name: QEMU 2964 QEMU (KVM/Linux)
> > Workqueue: events virtio_gpu_dequeue_ctrl_func
> > Call Trace:
> > ([<0000000000112a2c>] show_stack+0x54/0xd0)
> >  [<0000000000ba7bd0>] dump_stack+0x90/0xc8 
> >  [<00000000001a8cf8>] ___might_sleep+0x240/0x258 
> >  [<00000000003560e6>] __kmalloc_node+0x2de/0x478 
> >  [<00000000007e0f64>] drm_property_create_blob.part.0+0x3c/0x138 
> >  [<00000000007e1bfe>] drm_property_replace_global_blob+0xb6/0x118 
> >  [<00000000007dedac>] drm_connector_update_edid_property+0x8c/0xb0 
> >  [<00000000007febe8>] virtio_gpu_cmd_get_edid_cb+0x88/0xc0 
> >  [<00000000007ff03a>] virtio_gpu_dequeue_ctrl_func+0x142/0x200 
> >  [<000000000018fdbc>] process_one_work+0x284/0x618 
> >  [<000000000019019a>] worker_thread+0x4a/0x3f0 
> >  [<0000000000197c92>] kthread+0x152/0x170 
> >  [<0000000000bcac76>] kernel_thread_starter+0x6/0xc 
> >  [<0000000000bcac70>] kernel_thread_starter+0x0/0xc 
> > 3 locks held by kworker/0:1/7:
> >  #0: (____ptrval____) ((wq_completion)"events"){+.+.}, at: process_one_work+0x1c8/0x618
> >  #1: (____ptrval____) ((work_completion)(&vgvq->dequeue_work)){+.+.}, at: process_one_work+0x1c8/0x618
> >  #2: (____ptrval____) (&(&vgdev->display_info_lock)->rlock){+.+.}, at: virtio_gpu_cmd_get_edid_cb+0x6e/0xc0
> > virtio_gpu virtio5: fb1: virtiodrmfb frame buffer device
> > [drm] Initialized virtio_gpu 0.1.0 0 for virtio5 on minor 1
> > 
> > This is an s390x guest, run via tcg; the stack trace is triggered both
> > for virtio-gpu-ccw and virtio-gpu-pci devices, so it's probably
> > something generic. The device seems to initialize fine, but I have not
> > tried to actually use it (I simply keep a virtio-gpu device in my QEMU
> > command line for sanity checking.)
> > 
> > As said, I bisected this down to the initial commit
> > 
> > commit b4b01b4995fb15b55a2d067eb405917f5ab32709 (refs/bisect/bad)
> > Author: Gerd Hoffmann <kraxel@redhat.com>
> > Date:   Tue Oct 30 07:32:06 2018 +0100
> > 
> >     drm/virtio: add edid support
> >     
> >     linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.
> >     
> >     Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >     Acked-by: Daniel Vetter <daniel@ffwll.ch>
> >     Link: http://patchwork.freedesktop.org/patch/msgid/20181030063206.19528-3-kraxel@redhat.com
> > 
> > so it seems to have always been present, but I just noticed it now that
> > the default for edid in QEMU has changed.
> > 
> > I have not tried it with a non-s390x guest, though.  
> 
> https://patchwork.freedesktop.org/patch/296386/
> 
> (patch braucht noch ein review oder ack)
> 
> cheers,
>   Gerd
> 

Thanks, replied there; hopefully this can move forward soon :)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

