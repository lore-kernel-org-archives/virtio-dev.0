Return-Path: virtio-dev-return-6518-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 53D22985BE3
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Dec 2019 11:03:50 +0000 (UTC)
References: <20191212171137.13872-1-david@redhat.com>
 <20191213201556.GC26990@char.us.oracle.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <178a5e94-f1f1-130c-9a28-2b8dd2be2abe@redhat.com>
Date: Mon, 16 Dec 2019 12:03:21 +0100
MIME-Version: 1.0
In-Reply-To: <20191213201556.GC26990@char.us.oracle.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH RFC v4 00/13] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 13.12.19 21:15, Konrad Rzeszutek Wilk wrote:
> On Thu, Dec 12, 2019 at 06:11:24PM +0100, David Hildenbrand wrote:
>> This series is based on latest linux-next. The patches are located at:
>>     https://github.com/davidhildenbrand/linux.git virtio-mem-rfc-v4
> Heya!

Hi Konrad!

>=20
> Would there be by any chance a virtio-spec git tree somewhere?

I haven't started working on a spec yet - it's on my todo list but has
low priority (one-man-team). I'll focus on the QEMU pieces next, once
the kernel part is in an acceptable state.

The uapi file contains quite some documentation - if somebody wants to
start hacking on an alternative hypervisor implementation, I'm happy to
answer questions until I have a spec ready.

>=20
> ..snip..
>> ------------------------------------------------------------------------=
--
>> 5. Future work
>> ------------------------------------------------------------------------=
--
>>
>> The separate patches contain a lot of future work items. One of the next
>> steps is to make memory unplug more likely to succeed - currently, there
>> are no guarantees on how much memory can get unplugged again. I have
>=20
>=20
> Or perhaps tell the caller why we can't and let them sort it out?
> For example: "Application XYZ is mlocked. Can't offload'.

Yes, it might in general be interesting for the guest to indicate
persistent errors, both when hotplugging and hotunplugging memory.
Indicating why unplugging is not able to succeed in that detail is,
however, non-trivial.

The hypervisor sets the requested size can can watch over the actual
size of a virtio-mem device. Right now, after it updated the requested
size, it can wait some time (e.g., 1-5 minutes). If the requested size
was not reached after that time, it knows there is a persistent issue
limiting plug/unplug. In the future, this could be extended by a rough
or detailed root cause indication. In the worst case, the guest crashed
and is no longer able to respond (not even with an error indication).

One interesting piece of the current hypervisor (QEMU) design is that
the maximum memory size a VM can consume is always known and QEMU will
send QMP events to upper layers whenever that size changes. This means
that you can e.g., reliably charge a customer how much memory a VM is
actually able to consume over time (independent of hotplug/unplug
errors). But yeah, the QEMU bits are still in a very early stage.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

