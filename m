Return-Path: virtio-dev-return-7059-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3DF37985F59
	for <virtio-dev@lists.oasis-open.org>; Tue, 14 Apr 2020 16:28:55 +0000 (UTC)
Date: Tue, 14 Apr 2020 12:28:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200414122716-mutt-send-email-mst@kernel.org>
References: <20200311171422.10484-1-david@redhat.com>
 <20200329084128-mutt-send-email-mst@kernel.org>
 <b9984195-bb48-e2a6-887d-0905692a7524@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b9984195-bb48-e2a6-887d-0905692a7524@redhat.com>
Subject: [virtio-dev] Re: [PATCH v2 00/10] virtio-mem: paravirtualized memory
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Samuel Ortiz <samuel.ortiz@intel.com>, Robert Bradford <robert.bradford@intel.com>, Luiz Capitulino <lcapitulino@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, teawater <teawaterz@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Alexander Potapenko <glider@google.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Anthony Yznaga <anthony.yznaga@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Dave Young <dyoung@redhat.com>, Jason Wang <jasowang@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Juergen Gross <jgross@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Len Brown <lenb@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>, Oscar Salvador <osalvador@suse.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Wei Yang <richard.weiyang@gmail.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 14, 2020 at 11:15:18AM +0200, David Hildenbrand wrote:
> On 29.03.20 14:42, Michael S. Tsirkin wrote:
> > On Wed, Mar 11, 2020 at 06:14:12PM +0100, David Hildenbrand wrote:
> >> This series is based on latest linux-next. The patches are located at:
> >>     https://github.com/davidhildenbrand/linux.git virtio-mem-v2
> >>
> >> I now have acks for all !virtio-mem changes. I'll be happy to get revi=
ew
> >> feedback, testing reports, etc. for the virtio-mem changes. If there a=
re
> >> no further comments, I guess this is good to go as a v1 soon.
> >=20
> > I'd like to queue it for merge after the release. If you feel it's read=
y
> > please ping me after the release to help make sure it didn't get
> > dropped.  I see there were some reports about people having trouble
> > using this, pls keep working on this meanwhile.
>=20
> Hi Michael,
>=20
> I think this is ready to go as a first version. There are a couple of
> future work items related to kexec/kdump:
> - Teach kexec-tools/kexec_file_load() to not place the kexec
>   kernel/initrd onto virtio-mem added memory.
> - Teach kexec-tools/kdump to consider a bigger number of memory
>   resources for dumping.
>=20
> In general, as virtio-mem adds a lot of memory resources, we might want
> to tweak performance in that area as well. Future stuff.
>=20
> So I suggest queuing this. If you need a resend, please let me know.
>=20
> Cheers!

Thanks!
I'll queue it for merge after the release. If possible please ping me
after the release to help make sure it didn't get dropped.




> --=20
> Thanks,
>=20
> David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

