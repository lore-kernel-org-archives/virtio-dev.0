Return-Path: virtio-dev-return-7000-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF81F98604F
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Mar 2020 17:04:02 +0000 (UTC)
References: <20200311171422.10484-1-david@redhat.com>
 <CAM9Jb+g6DEL1=L1ESfW+Jnr_rfO5rEtOwnp10eCLpajaAv8wvg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6858c4d8-7570-2c2b-5d53-1a7f994c14ee@redhat.com>
Date: Fri, 27 Mar 2020 18:03:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+g6DEL1=L1ESfW+Jnr_rfO5rEtOwnp10eCLpajaAv8wvg@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2 00/10] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 27.03.20 17:58, Pankaj Gupta wrote:
> Hi David,
> 
> Trying to test the series with the Qemu branch(virtio-mem) mentioned.
> Unfortunately,
> not able to hotplug memory. Is anything changed from your previous posting
> or I am doing something wrong?
> 
> After giving value to "requested-size", I see size as zero.
> 
> (qemu) qom-set vm0 requested-size 10G
> (qemu) info memory-devices
> Memory device [virtio-mem]: "vm0"
>   memaddr: 0x240000000
>   node: 0
>   requested-size: 10737418240
>   size: 0
>   max-size: 107374182400
>   block-size: 2097152
>   memdev: /objects/mem0
> 
> Guest kernel: 5.6.0-rc4
> Using same Qemu commandline arguments mentioned in cover-letter.

Are you booting from an initrd? Are you compiling virtio-mem as a kernel
module or into the kernel binary?

Make sure that the virtio-mem driver will actually be loaded. (lsmod  |
grep virtio-mem).

Also, double check if there are any virtio-mem dmesg errors/warnings.

-- 
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

