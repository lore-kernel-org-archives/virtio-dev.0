Return-Path: virtio-dev-return-6198-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD481985FDA
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Oct 2019 15:05:09 +0000 (UTC)
References: <20191001152441.27008.99285.stgit@localhost.localdomain>
 <7233498c-2f64-d661-4981-707b59c78fd5@redhat.com>
 <1ea1a4e11617291062db81f65745b9c95fd0bb30.camel@linux.intel.com>
 <8bd303a6-6e50-b2dc-19ab-4c3f176c4b02@redhat.com>
 <d21e6fce694f286ecaf227697a1ec5555734520b.camel@linux.intel.com>
 <b45c9ea924cbb8b8dc390082d5a0b4bd91e7a8f8.camel@linux.intel.com>
 <150e09b3-42c0-567e-55b8-7be6b45fd576@intel.com>
From: Nitesh Narayan Lal <nitesh@redhat.com>
Message-ID: <46593efd-4a97-cdcc-fe22-01a5400d23c9@redhat.com>
Date: Wed, 2 Oct 2019 11:04:44 -0400
MIME-Version: 1.0
In-Reply-To: <150e09b3-42c0-567e-55b8-7be6b45fd576@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v11 0/6] mm / virtio: Provide support for unused page
 reporting
To: Dave Hansen <dave.hansen@intel.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, mgorman@techsingularity.net, vbabka@suse.cz, osalvador@suse.de
Cc: yang.zhang.wz@gmail.com, pagupta@redhat.com, konrad.wilk@oracle.com, riel@surriel.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 10/1/19 4:51 PM, Dave Hansen wrote:
> On 10/1/19 1:49 PM, Alexander Duyck wrote:
>> So it looks like v12 still has issues. I'm pretty sure you should be u=
sing
>> spin_lock_irq(), not spin_lock() in page_reporting.c to avoid the
>> possibility of an IRQ firing and causing lock recursion on the zone lo=
ck.
> Lockdep should make all of this a lot easier to find.  Is it being used=
?

I do have it in the function which returns the pages to the buddy but I m=
issed
it in the function that isolates the pages.
I will correct this.


--=20
Thanks
Nitesh


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

