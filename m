Return-Path: virtio-dev-return-6865-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 86B91985CDE
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Mar 2020 14:09:24 +0000 (UTC)
References: <20200302134941.315212-1-david@redhat.com>
 <20200302134941.315212-2-david@redhat.com>
 <20200302140309.GM4380@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <baff6701-fc75-d205-2e78-904166f63030@redhat.com>
Date: Mon, 2 Mar 2020 15:09:10 +0100
MIME-Version: 1.0
In-Reply-To: <20200302140309.GM4380@dhcp22.suse.cz>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 01/11] ACPI: NUMA: export pxm_to_node
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 02.03.20 15:03, Michal Hocko wrote:
> On Mon 02-03-20 14:49:31, David Hildenbrand wrote:
>> Will be needed by virtio-mem to identify the node from a pxm.
> 
> No objection to export the symbol. But it is almost always better to add
> the export in the patch that actually uses it. The intention is much
> more clear that way.

Yeah, but I guess this way people might take more likely a look as if
this would be squashed into a
 5 files changed, 1786 insertions(+)

patch. At least that's what my experience tells me :)

If there are hard feelings, I can squash (but I am afraid it will be
even harder to get ACKs/RBs for core-mm changes that way ...)

Thanks for having a look!

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

