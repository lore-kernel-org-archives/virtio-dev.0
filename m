Return-Path: virtio-dev-return-6874-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1459985D83
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Mar 2020 08:06:50 +0000 (UTC)
References: <20200302134941.315212-3-david@redhat.com>
 <202003031039.To18mcrC%lkp@intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <3851c1eb-92ee-7c85-088f-2adeef3272e6@redhat.com>
Date: Tue, 3 Mar 2020 09:06:29 +0100
MIME-Version: 1.0
In-Reply-To: <202003031039.To18mcrC%lkp@intel.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 02/11] virtio-mem: Paravirtualized memory hotplug
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Oscar Salvador <osalvador@suse.de>, Igor Mammedov <imammedo@redhat.com>, Dave Young <dyoung@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Stefan Hajnoczi <stefanha@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 03.03.20 03:24, kbuild test robot wrote:
> Hi David,
>=20
> I love your patch! Yet something to improve:
>=20
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on linus/master v5.6-rc4 next-20200302]
> [cannot apply to linux/master mmotm/master]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>=20
> url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/virtio=
-mem-paravirtualized-memory/20200303-020852
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.g=
it linux-next
> config: x86_64-randconfig-s1-20200303 (attached as .config)
> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Dx86_64=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from <command-line>:1:0:
>>> ./usr/include/linux/virtio_mem.h:185:2: error: unknown type name 'uint3=
2_t'
>      uint32_t block_size;
>      ^
>>> ./usr/include/linux/virtio_mem.h:187:2: error: unknown type name 'uint1=
6_t'
>      uint16_t node_id;
>      ^
>    ./usr/include/linux/virtio_mem.h:188:2: error: unknown type name 'uint=
16_t'
>      uint16_t padding;
>      ^
>>> ./usr/include/linux/virtio_mem.h:190:2: error: unknown type name 'uint6=
4_t'
>      uint64_t addr;
>      ^
>    ./usr/include/linux/virtio_mem.h:192:2: error: unknown type name 'uint=
64_t'
>      uint64_t region_size;
>      ^
>    ./usr/include/linux/virtio_mem.h:198:2: error: unknown type name 'uint=
64_t'
>      uint64_t usable_region_size;
>      ^
>    ./usr/include/linux/virtio_mem.h:203:2: error: unknown type name 'uint=
64_t'
>      uint64_t plugged_size;
>      ^
>    ./usr/include/linux/virtio_mem.h:205:2: error: unknown type name 'uint=
64_t'
>      uint64_t requested_size;
>      ^

Right, these have to be __u64 and friends. Should really enable
CONFIG_UAPI_HEADER_TEST in my default config.


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

