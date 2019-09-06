Return-Path: virtio-dev-return-6053-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 324FE985EC6
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Sep 2019 14:53:30 +0000 (UTC)
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 06 Sep 2019 07:53:27 -0700
Message-ID: <20190906145327.32552.39455.stgit@localhost.localdomain>
In-Reply-To: <20190906145213.32552.30160.stgit@localhost.localdomain>
References: <20190906145213.32552.30160.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] [PATCH v8 1/7] mm: Add per-cpu logic to page shuffling
To: nitesh@redhat.com, kvm@vger.kernel.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, virtio-dev@lists.oasis-open.org, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com, konrad.wilk@oracle.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Change the logic used to generate randomness in the suffle path so that we
can avoid cache line bouncing. The previous logic was sharing the offset
and entropy word between all CPUs. As such this can result in cache line
bouncing and will ultimately hurt performance when enabled.

To resolve this I have moved to a per-cpu logic for maintaining a unsigned
long containing some amount of bits, and an offset value for which bit we
can use for entropy with each call.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/shuffle.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/mm/shuffle.c b/mm/shuffle.c
index 3ce12481b1dc..9ba542ecf335 100644
--- a/mm/shuffle.c
+++ b/mm/shuffle.c
@@ -183,25 +183,38 @@ void __meminit __shuffle_free_memory(pg_data_t *pgdat)
 		shuffle_zone(z);
 }
 
+struct batched_bit_entropy {
+	unsigned long entropy_bool;
+	int position;
+};
+
+static DEFINE_PER_CPU(struct batched_bit_entropy, batched_entropy_bool);
+
 void add_to_free_area_random(struct page *page, struct free_area *area,
 		int migratetype)
 {
-	static u64 rand;
-	static u8 rand_bits;
+	struct batched_bit_entropy *batch;
+	unsigned long entropy;
+	int position;
 
 	/*
-	 * The lack of locking is deliberate. If 2 threads race to
-	 * update the rand state it just adds to the entropy.
+	 * We shouldn't need to disable IRQs as the only caller is
+	 * __free_one_page and it should only be called with the zone lock
+	 * held and either from IRQ context or with local IRQs disabled.
 	 */
-	if (rand_bits == 0) {
-		rand_bits = 64;
-		rand = get_random_u64();
+	batch = raw_cpu_ptr(&batched_entropy_bool);
+	position = batch->position;
+
+	if (--position < 0) {
+		batch->entropy_bool = get_random_long();
+		position = BITS_PER_LONG - 1;
 	}
 
-	if (rand & 1)
+	batch->position = position;
+	entropy = batch->entropy_bool;
+
+	if (1ul & (entropy >> position))
 		add_to_free_area(page, area, migratetype);
 	else
 		add_to_free_area_tail(page, area, migratetype);
-	rand_bits--;
-	rand >>= 1;
 }


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

