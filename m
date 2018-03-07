Return-Path: virtio-return-2973-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 15:47:40 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180307154220-mutt-send-email-mst@kernel.org>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
 <1519860484-7936-11-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519860484-7936-11-git-send-email-mst@redhat.com>
Subject: [virtio] Re: [PATCH v9 10/16] packed virtqueues: more efficient virtqueue
 layout
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 01, 2018 at 01:31:34AM +0200, Michael S. Tsirkin wrote:
> Performance analysis of this is in my kvm forum 2016 presentation.  The
> idea is to have a r/w descriptor in a ring structure, replacing the used
> and available ring, index and descriptor buffer.
> 
> This is also easier for devices to implement than the 1.0 layout.
> Several more enhancements will be necessary to actually make this
> efficient for devices to use.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

OK so it's been almost a week and no more comments, but I went
over it myself again and found a bug in the pseudocode. It did
not handle out of order used buffers correctly.  The right thing
to do is to record the number of descriptors - not the id - in a
driver-specific data structure.

As it's just a pseudocode change, I assume it's not a reason for
more delay.  Will include in the final version which I plan to
start voting on early next week.


diff --git a/packed-ring.tex b/packed-ring.tex
index 12bab67..99912c3 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -594,12 +594,15 @@ the VIRTIO_F_RING_EVENT_IDX feature.
 
 \begin{lstlisting}
 /* Note: vq->avail_wrap_count is initialized to 1 */
-/* Note: vq->ids is an array same size as the ring */
+/* Note: vq->sgs is an array same size as the ring */
 
-first = vq->next_avail;
 id = alloc_id(vq);
 
+first = vq->next_avail;
+sgs = 0;
 for (each buffer element b) {
+        sgs++;
+
         vq->ids[vq->next_avail] = -1;
         vq->desc[vq->next_avail].address = get_addr(b);
         vq->desc[vq->next_avail].len = get_len(b);
@@ -607,9 +610,9 @@ for (each buffer element b) {
         avail = vq->avail_wrap_count ? VIRTQ_DESC_F_AVAIL : 0;
         used = !vq->avail_wrap_count ? VIRTQ_DESC_F_USED : 0;
         f = get_flags(b) | avail | used;
-	if (b is not the last buffer element) {
-		f |= VIRTQ_DESC_F_NEXT;
-	}
+        if (b is not the last buffer element) {
+                f |= VIRTQ_DESC_F_NEXT;
+        }
 
         /* Don't mark the 1st descriptor available until all of them are ready. */
         if (vq->next_avail == first) {
@@ -626,11 +629,10 @@ for (each buffer element b) {
                 vq->next_avail = 0;
                 vq->avail_wrap_count \^= 1;
         }
-
-
 }
+vq->sgs[id] = sgs;
 /* ID included in the last descriptor in the list */
-vq->ids[last] = vq->desc[last].id = id;
+vq->desc[last].id = id;
 write_memory_barrier();
 vq->desc[first].flags = flags;
 
@@ -689,15 +691,17 @@ for (;;) {
 
         read_memory_barrier();
 
-	/* skip descriptors until we find the correct ID */
-        do {
-		found = vq->ids[vq->next_used] == d->id;
-                vq->next_used++;
-                if (vq->next_used >= vq->size) {
-                        vq->next_used = 0;
-                        vq->used_wrap_count \^= 1;
-                }
-        } while (!found);
+        /* skip descriptors until the next buffer */
+        id = d->id;
+        assert(id < vq->size);
+        sgs = vq->sgs[id];
+        vq->next_used += sgs;
+        if (vq->next_used >= vq->size) {
+                vq->next_used -= vq->size;
+                vq->used_wrap_count \^= 1;
+        }
+
+        free_id(vq, id);
 
         process_buffer(d);
 }

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

